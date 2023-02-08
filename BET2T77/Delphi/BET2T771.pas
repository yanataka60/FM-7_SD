unit BET2T771;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    procedure check;
    procedure Panel1DragLeave(Sender: TObject);
    procedure Panel1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure bitout(i1:integer);
  private
    { private êÈåæ }
  public
    { public êÈåæ }
  end;

var
  Form1: TForm1;
  fname:string;
  F1,F2 : File;

implementation

{$R *.fmx}

procedure TForm1.Panel1DragLeave(Sender: TObject);
begin
  check;
end;

procedure TForm1.Panel1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
    fname:=Data.files[0];
end;

procedure tform1.check;
var
  buf : array[1..1] of char;
  i1,CNT1,cnt2:integer;
  S1,fname2:string;
begin
  S1 := fname;
  fname2:=ChangeFileExt(fname,'')+'.T77';
  IF FILEEXISTS(S1) THEN
    BEGIN
      ASSIGNFILE(F1,S1);
      ASSIGNFILE(F2,fname2);
      RESET(F1,1);
      REWRITE(F2,1);
      buf[1]:='X';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='M';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='7';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=' ';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='T';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='A';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='P';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='E';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=' ';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='I';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='M';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='A';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='G';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='E';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=' ';
      blockwrite(F2,buf,1,cnt2);
      buf[1]:='0';

      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($00);
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($00);
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($7f);
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($ff);
      blockwrite(F2,buf,1,cnt2);

      buf[1]:=chr($00);
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($00);
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($7f);
      blockwrite(F2,buf,1,cnt2);
      buf[1]:=chr($ff);
      blockwrite(F2,buf,1,cnt2);


      while not(eof(F1)) do
        begin
          bitout(0);
          blockread(f1,buf,1,cnt2);
          i1:=ord(buf[1]);

          for cnt1 := 1 to 8 do
            begin
              bitout((i1 and (1 shl (cnt1-1))) shr (cnt1-1));
            end;
          bitout(1);
          bitout(1);
        end;
      CLOSEFILE(F1);
      CLOSEFILE(F2);
    END;
end;

procedure tform1.bitout(i1:integer);
var
  buf2 : array[1..1] of char;
  cnt2:integer;
begin
  if i1=1 then
    begin
      buf2[1]:=chr($80);
      blockwrite(F2,buf2,1,cnt2);
      buf2[1]:=chr($30);
      blockwrite(F2,buf2,1,cnt2);
      buf2[1]:=chr($00);
      blockwrite(F2,buf2,1,cnt2);
      buf2[1]:=chr($30);
      blockwrite(F2,buf2,1,cnt2);
    end
   else
    begin
      buf2[1]:=chr($80);
      blockwrite(F2,buf2,1,cnt2);
      buf2[1]:=chr($1a);
      blockwrite(F2,buf2,1,cnt2);
      buf2[1]:=chr($00);
      blockwrite(F2,buf2,1,cnt2);
      buf2[1]:=chr($1a);
      blockwrite(F2,buf2,1,cnt2);
    end ;
end;

end.
