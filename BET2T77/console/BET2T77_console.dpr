program BET2T77_Console;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

var
  fname: string;
  F1, F2: File;

procedure bitout(i1: integer);
var
  buf2: array[1..1] of Char;
  cnt2: Integer;
begin
  if i1 = 1 then
  begin
    buf2[1] := Chr($80); BlockWrite(F2, buf2, 1, cnt2);
    buf2[1] := Chr($30); BlockWrite(F2, buf2, 1, cnt2);
    buf2[1] := Chr($00); BlockWrite(F2, buf2, 1, cnt2);
    buf2[1] := Chr($30); BlockWrite(F2, buf2, 1, cnt2);
  end
  else
  begin
    buf2[1] := Chr($80); BlockWrite(F2, buf2, 1, cnt2);
    buf2[1] := Chr($1A); BlockWrite(F2, buf2, 1, cnt2);
    buf2[1] := Chr($00); BlockWrite(F2, buf2, 1, cnt2);
    buf2[1] := Chr($1A); BlockWrite(F2, buf2, 1, cnt2);
  end;
end;

procedure ConvertFile(const fname: string);
var
  buf: array[1..1] of Char;
  i1, cnt1, cnt2: Integer;
  S1, fname2: string;
begin
  S1 := fname;
  fname2 := ChangeFileExt(fname, '') + '.T77';

  if FileExists(S1) then
  begin
    AssignFile(F1, S1);
    AssignFile(F2, fname2);
    Reset(F1, 1);
    Rewrite(F2, 1);

    // ヘッダ出力
    buf[1] := 'X'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'M'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := '7'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := ' '; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'T'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'A'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'P'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'E'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := ' '; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'I'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'M'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'A'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'G'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := 'E'; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := ' '; BlockWrite(F2, buf, 1, cnt2);
    buf[1] := '0'; BlockWrite(F2, buf, 1, cnt2);

    buf[1] := Chr($00); BlockWrite(F2, buf, 1, cnt2);
    buf[1] := Chr($00); BlockWrite(F2, buf, 1, cnt2);
    buf[1] := Chr($7F); BlockWrite(F2, buf, 1, cnt2);
    buf[1] := Chr($FF); BlockWrite(F2, buf, 1, cnt2);

    buf[1] := Chr($00); BlockWrite(F2, buf, 1, cnt2);
    buf[1] := Chr($00); BlockWrite(F2, buf, 1, cnt2);
    buf[1] := Chr($7F); BlockWrite(F2, buf, 1, cnt2);
    buf[1] := Chr($FF); BlockWrite(F2, buf, 1, cnt2);

    // データ変換
    while not Eof(F1) do
    begin
      bitout(0);
      BlockRead(F1, buf, 1, cnt2);
      i1 := Ord(buf[1]);

      for cnt1 := 1 to 8 do
        bitout((i1 and (1 shl (cnt1 - 1))) shr (cnt1 - 1));

      bitout(1);
      bitout(1);
    end;

    CloseFile(F1);
    CloseFile(F2);

    Writeln('変換完了: ', fname2);
  end
  else
    Writeln('ファイルが存在しません: ', fname);
end;

begin
  try
    if ParamCount = 0 then
    begin
      Writeln('使い方: BET2T77_Console <入力ファイル>');
      Exit;
    end;

    fname := ParamStr(1);
    ConvertFile(fname);

  except
    on E: Exception do
      Writeln('エラー: ', E.Message);
  end;
end.
