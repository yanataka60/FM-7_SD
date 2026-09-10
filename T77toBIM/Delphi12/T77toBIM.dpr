program T77toBIM;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes;

const
  T77HeaderSize = 16;
  BitCellUs = 625;       // 1600 bps
  HalfBitUs = 312;       // 625 / 2, integer microseconds
  T77UnitUs = 9;

type
  TT77Decoder = class
  private
    FData: TBytes;
    FEndUs: TArray<Int64>;
    FLevel: TArray<Byte>;
    FRunCount: Integer;
    FPosition: Int64;
    FDurationUs: Int64;
    FStopErrors: Int64;

    function LevelAt(ATimeUs: Int64): Integer;
    function NextRisingEdge(ATimeUs: Int64): Int64;
    function GetBit(out ABit: Integer): Boolean;
    function GetByte(out AValue: Byte): Boolean;
  public
    constructor Create(const FileName: string);
    procedure DecodeTo(const OutputFileName: string);
    property StopErrors: Int64 read FStopErrors;
    property DurationUs: Int64 read FDurationUs;
    property RunCount: Integer read FRunCount;
    property Position: Int64 read FPosition;
  end;

function ReadBE16(const B: TBytes; P: Integer): Word;
begin
  Result := (Word(B[P]) shl 8) or Word(B[P + 1]);
end;

constructor TT77Decoder.Create(const FileName: string);
var
  S: TFileStream;
  I: Integer;
  W: Word;
  T: Int64;
begin
  inherited Create;

  S := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if S.Size > MaxInt then
      raise Exception.Create('T77 image is too large for this build.');
    SetLength(FData, Integer(S.Size));
    if Length(FData) <> 0 then
      S.ReadBuffer(FData[0], Length(FData));
  finally
    S.Free;
  end;

  if Length(FData) < T77HeaderSize then
    raise Exception.Create('File is too small for a T77 image.');

  if not CompareMem(@FData[0], PAnsiChar('XM7 TAPE IMAGE 0'), T77HeaderSize) then
    raise Exception.Create('Invalid T77 header.');

  FRunCount := (Length(FData) - T77HeaderSize) div 2;
  SetLength(FEndUs, FRunCount);
  SetLength(FLevel, FRunCount);

  T := 0;
  for I := 0 to FRunCount - 1 do
  begin
    W := ReadBE16(FData, T77HeaderSize + I * 2);

    // T77 run word:
    // bit 15 = cassette signal level
    // bits 14..0 = duration in 9-us units
    FLevel[I] := (W shr 15) and 1;
    T := T + Int64(W and $7FFF) * T77UnitUs;
    FEndUs[I] := T;
  end;

  FDurationUs := T;
  FPosition := 0;
  FStopErrors := 0;
end;

function TT77Decoder.LevelAt(ATimeUs: Int64): Integer;
var
  L, R, M: Integer;
begin
  if ATimeUs < 0 then
    Exit(-1);

  L := 0;
  R := FRunCount - 1;

  while L <= R do
  begin
    M := (L + R) shr 1;
    if ATimeUs < FEndUs[M] then
      R := M - 1
    else
      L := M + 1;
  end;

  if L >= FRunCount then
    Exit(-1);

  Result := FLevel[L];
end;

function TT77Decoder.NextRisingEdge(ATimeUs: Int64): Int64;
var
  L, R, M, I: Integer;
begin
  // Find the first run whose end is after the current time.
  L := 0;
  R := FRunCount - 1;

  while L <= R do
  begin
    M := (L + R) shr 1;
    if FEndUs[M] <= ATimeUs then
      L := M + 1
    else
      R := M - 1;
  end;

  I := L;

  // A transition at FEndUs[I] is rising when the run ending there
  // has level 0 and the following run has level 1.
  while I < FRunCount - 1 do
  begin
    if (FLevel[I] = 0) and (FLevel[I + 1] = 1) then
      Exit(FEndUs[I]);
    Inc(I);
  end;

  Result := -1;
end;

function TT77Decoder.GetBit(out ABit: Integer): Boolean;
var
  Rise, SampleTime: Int64;
begin
  Rise := NextRisingEdge(FPosition);
  if Rise < 0 then
  begin
    ABit := -1;
    Exit(False);
  end;

  // Public FM-7 cassette specification:
  //   1600 bit/s => 625 us/bit.
  // The half-bit point is therefore about 312.5 us.
  // The T77 representation is integer 9-us time units, so this
  // implementation uses 312 us as the deterministic sample offset.
  //
  // The bit value is determined from the signal level at that point:
  // 2400 Hz represents 0, 1200 Hz represents 1.
  SampleTime := Rise + HalfBitUs;
  ABit := LevelAt(SampleTime);

  if ABit < 0 then
    Exit(False);

  FPosition := SampleTime;
  Result := True;
end;

function TT77Decoder.GetByte(out AValue: Byte): Boolean;
var
  B, S1, S2, I: Integer;
  V: Byte;
begin
  // Search forward for a start bit (0).
  while True do
  begin
    if not GetBit(B) then
      Exit(False);
    if B = 0 then
      Break;
  end;

  // 8 data bits, least-significant bit first.
  V := 0;
  for I := 0 to 7 do
  begin
    if not GetBit(B) then
      Exit(False);

    V := V shr 1;
    if B <> 0 then
      V := V or $80;
  end;

  // Two stop bits.  A stop-bit error is represented by FE,
  // preserving the complete byte stream for forensic comparison.
  if not GetBit(S1) then
    Exit(False);
  if not GetBit(S2) then
    Exit(False);

  if (S1 <> 1) or (S2 <> 1) then
  begin
    Inc(FStopErrors);
    AValue := $FE;
  end
  else
    AValue := V;

  Result := True;
end;

procedure TT77Decoder.DecodeTo(const OutputFileName: string);
var
  OutS: TFileStream;
  B: Byte;
  N: Int64;
begin
  // Generic decoding always starts at the beginning of the T77 signal.
  // No title/file-name recognition and no automatic "clean start"
  // search are performed.
  FPosition := 0;
  FStopErrors := 0;
  N := 0;

  OutS := TFileStream.Create(OutputFileName, fmCreate);
  try
    while GetByte(B) do
    begin
      OutS.WriteBuffer(B, 1);
      Inc(N);
    end;
  finally
    OutS.Free;
  end;

  Writeln('Finished.');
  Writeln('T77 runs      : ', FRunCount);
  Writeln('T77 duration  : ', FDurationUs, ' us');
  Writeln('Decoded bytes : ', N);
  Writeln('Stop errors   : ', FStopErrors);
  Writeln('T77 position  : ', FPosition, ' / ', FDurationUs);
  Writeln('Start time us : 0');
end;

var
  D: TT77Decoder;
begin
  try
    if ParamCount < 2 then
    begin
      Writeln('Usage: T77toBIM.exe input.t77 output.bim');
      Halt(2);
    end;

    D := TT77Decoder.Create(ParamStr(1));
    try
      D.DecodeTo(ParamStr(2));
    finally
      D.Free;
    end;
  except
    on E: Exception do
    begin
      Writeln('ERROR: ', E.Message);
      Halt(1);
    end;
  end;
end.
