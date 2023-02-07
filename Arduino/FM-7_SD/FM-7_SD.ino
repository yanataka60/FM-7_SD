//
#include "SdFat.h"
#include <SPI.h>
SdFat SD;
unsigned long r_count=0;
unsigned long f_length=0;
char m_name[40];
char f_name[40];
char w_name[40];
char c_name[40];
char sdir[10][40];
File file_r,file_w;
unsigned int w_len1,w_len2;

#define CABLESELECTPIN  (10)
#define CHKPIN          (15)
#define PB0PIN          (2)
#define PB1PIN          (3)
#define PB2PIN          (4)
#define PB3PIN          (5)
#define PB4PIN          (6)
#define PB5PIN          (7)
#define PB6PIN          (8)
#define PB7PIN          (9)
#define FLGPIN          (14)
#define PA0PIN          (16)
#define PA1PIN          (17)
#define PA2PIN          (18)
#define PA3PIN          (19)
// ファイル名は、ロングファイルネーム形式対応
boolean eflg;

void setup(){
////    Serial.begin(9600);
// CS=pin10
// pin10 output

  pinMode(CABLESELECTPIN,OUTPUT);
  pinMode( CHKPIN,INPUT);  //CHK
  pinMode( PB0PIN,OUTPUT); //送信データ
  pinMode( PB1PIN,OUTPUT); //送信データ
  pinMode( PB2PIN,OUTPUT); //送信データ
  pinMode( PB3PIN,OUTPUT); //送信データ
  pinMode( PB4PIN,OUTPUT); //送信データ
  pinMode( PB5PIN,OUTPUT); //送信データ
  pinMode( PB6PIN,OUTPUT); //送信データ
  pinMode( PB7PIN,OUTPUT); //送信データ
  pinMode( FLGPIN,OUTPUT); //FLG

  pinMode( PA0PIN,INPUT_PULLUP); //受信データ
  pinMode( PA1PIN,INPUT_PULLUP); //受信データ
  pinMode( PA2PIN,INPUT_PULLUP); //受信データ
  pinMode( PA3PIN,INPUT_PULLUP); //受信データ

  digitalWrite(PB0PIN,LOW);
  digitalWrite(PB1PIN,LOW);
  digitalWrite(PB2PIN,LOW);
  digitalWrite(PB3PIN,LOW);
  digitalWrite(PB4PIN,LOW);
  digitalWrite(PB5PIN,LOW);
  digitalWrite(PB6PIN,LOW);
  digitalWrite(PB7PIN,LOW);
  digitalWrite(FLGPIN,LOW);

//  delay(1000);
//SETSコマンドでSAVE用ファイル名を指定なくSAVEされた場合のデフォルトファイル名を設定
  strcpy(w_name,"default.bim");
  // SD初期化
  if( !SD.begin(CABLESELECTPIN,8) )
  {
////    Serial.println("Failed : SD.begin");
    eflg = true;
  } else {
////    Serial.println("OK : SD.begin");
    eflg = false;
  }
////    Serial.println("START");
}

//4BIT受信
byte rcv4bit(void){
//HIGHになるまでループ
  while(digitalRead(CHKPIN) != HIGH){
  }
//受信
  byte j_data = digitalRead(PA0PIN)+digitalRead(PA1PIN)*2+digitalRead(PA2PIN)*4+digitalRead(PA3PIN)*8;
//FLGをセット
  digitalWrite(FLGPIN,HIGH);
//LOWになるまでループ
  while(digitalRead(CHKPIN) == HIGH){
  }
//FLGをリセット
  digitalWrite(FLGPIN,LOW);
  return(j_data);
}

//1BYTE受信
byte rcv1byte(void){
  byte i_data = 0;
  i_data=rcv4bit()*16;
  i_data=i_data+rcv4bit();
////  Serial.print("rcv:");
////  Serial.println(i_data,HEX);
  return(i_data);
}

//1BYTE送信
void snd1byte(byte i_data){
//下位ビットから8ビット分をセット
////  Serial.print("send:");
////  Serial.println(i_data,HEX);
  digitalWrite(PB0PIN,(i_data)&0x01);
  digitalWrite(PB1PIN,(i_data>>1)&0x01);
  digitalWrite(PB2PIN,(i_data>>2)&0x01);
  digitalWrite(PB3PIN,(i_data>>3)&0x01);
  digitalWrite(PB4PIN,(i_data>>4)&0x01);
  digitalWrite(PB5PIN,(i_data>>5)&0x01);
  digitalWrite(PB6PIN,(i_data>>6)&0x01);
  digitalWrite(PB7PIN,(i_data>>7)&0x01);
  digitalWrite(FLGPIN,HIGH);
//HIGHになるまでループ
  while(digitalRead(CHKPIN) != HIGH){
  }
  digitalWrite(FLGPIN,LOW);
//LOWになるまでループ
  while(digitalRead(CHKPIN) == HIGH){
  }
}

//小文字->大文字
char upper(char c){
  if('a' <= c && c <= 'z'){
    c = c - ('a' - 'A');
  }
  return c;
}

//ファイル名の最後が「.bim」でなければ付加
void addbin(char *f_name,char *m_name){
  unsigned int lp1=0;
  while (f_name[lp1] != 0x00){
    m_name[lp1] = f_name[lp1];
    lp1++;
  }
  if (f_name[lp1-4]!='.' ||
    ( f_name[lp1-3]!='B' &&
      f_name[lp1-3]!='b' ) ||
    ( f_name[lp1-2]!='I' &&
      f_name[lp1-2]!='i' ) ||
    ( f_name[lp1-1]!='M' &&
      f_name[lp1-1]!='m' ) ){
         m_name[lp1++] = '.';
         m_name[lp1++] = 'b';
         m_name[lp1++] = 'i';
         m_name[lp1++] = 'm';
  }
  m_name[lp1] = 0x00;
}

//比較文字列取得 32+1文字まで取得
void receive_name(char *f_name){
char r_data;
  unsigned int lp2 = rcv1byte();
////  Serial.print("length:");
////  Serial.println(lp2);
  if (lp2>32){
    lp2=33;
    }
  for (unsigned int lp1 = 0;lp1 < lp2;lp1++){
    r_data = rcv1byte();
////  Serial.print("lp1:");
////  Serial.print(lp1);
////  Serial.print(":");
////  Serial.println(r_data,HEX);
    f_name[lp1] = r_data;
  }
////  Serial.print("f_name:");
////  Serial.println(f_name);
}

// BOOT IPL FM-7
void boot_ipl_fm7(void){
  strcpy(f_name,"@BOOT_IPL_FM-7.BIN");
  boot_ipl(f_name);
}

// BOOT IPL FM-8
void boot_ipl_fm8(void){
  strcpy(f_name,"@BOOT_IPL_FM-8.BIN");
  boot_ipl(f_name);
}
// BOOT IPL LOAD
void boot_ipl(char *f_name){
//ファイルが存在しなければERROR
  if (SD.exists(f_name) == true){
//ファイルオープン
    file_r = SD.open( f_name, FILE_READ );

      if( true == file_r ){
//f_length設定、r_count初期化
        f_length = file_r.size();
        w_len1 = f_length / 256;
        w_len2 = f_length % 256;
        r_count = 0;
//状態コード送信(OK)
        snd1byte(0x00);
      } else {
        snd1byte(0xf0);
      }
    }else{
      snd1byte(0xf1);
    }

////  Serial.println(f_name);
//データ長を送信
////  Serial.print("f_length:");
////  Serial.println(f_length,HEX);
  snd1byte(w_len2);
  snd1byte(w_len1);
////  Serial.print("w_len2:");
////  Serial.println(w_len2,HEX);
////  Serial.print("w_len1:");
////  Serial.println(w_len1,HEX);
      
  for (unsigned int lp1 = 0;lp1 < f_length;lp1++){
//実データを読み込んで送信
    snd1byte(file_r.read());
////  Serial.print("lp1:");
////  Serial.println(lp1);
  }
  file_r.close();
}

// SD-CARDのFILELIST
void dirlist(void){
//比較文字列取得 32+1文字まで
  receive_name(c_name);
//
  File file2 = SD.open( "/" );
  if( file2 == true ){
//状態コード送信(OK)
    snd1byte(0x00);

    File entry =  file2.openNextFile();
    int cntl2 = 0;
    unsigned int br_chk =0;
    int page = 1;
//全件出力の場合には10件出力したところで一時停止、キー入力により継続、打ち切りを選択
    while (br_chk == 0) {
      if(entry){
        entry.getName(f_name,36);
        unsigned int lp1=0;
//一件送信
//比較文字列でファイルネームを先頭から比較して一致するものだけを出力
        if (f_match(f_name,c_name)){
//sdir[]にf_nameを保存
          strcpy(sdir[cntl2],f_name);
          snd1byte(0x30+cntl2);
          snd1byte(0x20);
          while (lp1<=36 && f_name[lp1]!=0x00){
          snd1byte(upper(f_name[lp1]));
          lp1++;
          }
          snd1byte(0x0D);
          snd1byte(0x00);
          cntl2++;
        }
      }
// CNTL2 > 表示件数-1
      if (!entry || cntl2 > 9){
//継続・打ち切り選択指示要求
        snd1byte(0xfe);

//選択指示受信(0:継続 B:前ページ 以外:打ち切り)
        br_chk = rcv1byte();
//前ページ処理
        if (br_chk==0x42){
//先頭ファイルへ
          file2.rewindDirectory();
//entry値更新
          entry =  file2.openNextFile();
//もう一度先頭ファイルへ
          file2.rewindDirectory();
          if(page <= 2){
//現在ページが1ページ又は2ページなら1ページ目に戻る処理
            page = 0;
          } else {
//現在ページが3ページ以降なら前々ページまでのファイルを読み飛ばす
            page = page -2;
            cntl2=0;
//page*表示件数
            while(cntl2 < page*10){
              entry =  file2.openNextFile();
              if (f_match(f_name,c_name)){
                cntl2++;
              }
            }
          }
          br_chk=0;
        }
//1～0までの数字キーが押されたらsdir[]から該当するファイル名を送信
        if(br_chk>=0x30 && br_chk<=0x39){
          file_r = SD.open( sdir[br_chk-0x30], FILE_READ );
          if( file_r == true ){
//f_length設定、r_count初期化
            f_length = file_r.size();
            r_count = 0;
            unsigned int lp2=0;
            snd1byte(0xFD);
            while (lp2<=36 && sdir[br_chk-0x30][lp2]!=0x00){
              snd1byte(upper(sdir[br_chk-0x30][lp2]));
              lp2++;
            }
            snd1byte(0x0A);
            snd1byte(0x0D);
            snd1byte(0x00);
////  Serial.println("file_r open ok");
          }
        }
        page++;
        cntl2 = 0;
      }
//ファイルがまだあるなら次読み込み、なければ打ち切り指示
      if (entry){
        entry =  file2.openNextFile();
      }else{
        br_chk=1;
      }
    }
//処理終了指示
    snd1byte(0xFF);
    snd1byte(0x00);
  }else{
    snd1byte(0xf1);
  }
}

//f_nameとc_nameをc_nameに0x00が出るまで比較
//FILENAME COMPARE
boolean f_match(char *f_name,char *c_name){
  boolean flg1 = true;
  unsigned int lp1 = 0;
  while (lp1 <=32 && c_name[0] != 0x00 && flg1 == true){
    if (upper(f_name[lp1]) != c_name[lp1]){
      flg1 = false;
    }
    lp1++;
    if (c_name[lp1]==0x00){
      break;
    }
  }
  return flg1;
}

//load1byte、OPENしているファイルの続きから1Byteを読み込み、送信
void load1byte(void){
  if (file_r == true){
    int rdata = file_r.read();
    r_count++;
    snd1byte(rdata);
//ファイルエンドまで達していればFILE CLOSE
      if (f_length == r_count){
        file_r.close();
      }
  }      
}

//save1byte、OPENしているファイルに1Byteを受信し書込み
void save1byte(void){
  int rdata = rcv1byte();
  file_w.write(rdata);
}

//モーターオン指示、書込みファイルがオープンされていなければオープン(継続書込み)
void moteron(void){
////  Serial.println("MOTER ON ");
  if(file_w==false){
    file_w = SD.open( w_name, FILE_WRITE );
  }
}

//モーターオフ指示、書き込みファイルがオープンされていればクローズする
void moteroff(void){
////  Serial.println("MOTER OFF");
  if(file_w==true){
    file_w.close();
  }
}

// LOADFILEOPEN　読み込み用のファイル名を設定する
void loadopen(void){
  boolean flg = false;
//DOSファイル名取得
  receive_name(m_name);
  addbin(m_name,f_name);
////  Serial.print("SETL_f_name:");
////  Serial.println(f_name);
//ファイルが存在しなければERROR
  if (SD.exists(f_name) == true){
//ファイルオープン
    file_r = SD.open( f_name, FILE_READ );

    if( true == file_r ){
//f_length設定、r_count初期化
      f_length = file_r.size();
      r_count = 0;
//状態コード送信(OK)
      snd1byte(0x00);
////  Serial.println("file_r open ok");
      flg = true;
    } else {
      snd1byte(0xf2);
////  Serial.println("file_r open error");
      flg = false;
    }
  }else{
    snd1byte(0xf1);
////  Serial.println("file_r open error");
    flg = false;
  }
}

// SAVEFILEOPEN　書き込み用のファイル名を設定する
void saveopen(void){
  boolean flg = false;
//DOSファイル名取得
  receive_name(m_name);
  addbin(m_name,f_name);
  strcpy(w_name,f_name);
////  Serial.print("f_name:");
////  Serial.println(f_name);
//ファイルオープン
  file_w = SD.open( w_name, FILE_WRITE );
//状態コード送信(OK)
  snd1byte(0x00);
////  Serial.println("file_w open ok");
}

void loop()
{
  digitalWrite(PB0PIN,LOW);
  digitalWrite(PB1PIN,LOW);
  digitalWrite(PB2PIN,LOW);
  digitalWrite(PB3PIN,LOW);
  digitalWrite(PB4PIN,LOW);
  digitalWrite(PB5PIN,LOW);
  digitalWrite(PB6PIN,LOW);
  digitalWrite(PB7PIN,LOW);
  digitalWrite(FLGPIN,LOW);
//コマンド取得待ち
////    Serial.println("COMMAND WAIT");
  byte cmd = rcv1byte();
////    Serial.println(cmd,HEX);
  if (eflg == false){
    switch(cmd) {
//50h:FM-7 BOOT_IPL LOAD
      case 0x50:
////    Serial.println("FM-7 BOOT IPL LOAD START");
//状態コード送信(OK)
        snd1byte(0x00);
        boot_ipl_fm7();
        break;
//51h:FM-8 BOOT_IPL LOAD
      case 0x51:
////    Serial.println("FM-8 BOOT IPL LOAD START");
//状態コード送信(OK)
        snd1byte(0x00);
        boot_ipl_fm8();
        break;
//52hでファイルリスト出力
      case 0x52:
////    Serial.println("FILE LIST START");
//状態コード送信(OK)
        snd1byte(0x00);
        dirlist();
        break;
//53hでLOADFILEOPEN
      case 0x53:
////    Serial.println("LOADFILEOPEN");
//状態コード送信(OK)
        snd1byte(0x00);
        loadopen();
        break;
//54hでSAVEFILEOPEN
      case 0x54:
////    Serial.println("SAVEFILEOPEN");
//状態コード送信(OK)
        snd1byte(0x00);
        saveopen();
        break;
//56hでLOAD1BYTE
      case 0x56:
////    Serial.println("LOAD1BYTE");
//状態コード送信(OK)
        if(file_r == true){
          snd1byte(0x00);
          load1byte();
        } else{
////    Serial.println("LOAD FILE NOT OPEN");
          snd1byte(0xff);
        }
        break;
//57hでSAVE1BYTE
      case 0x57:
////    Serial.println("SAVE1BYTE");
//状態コード送信(OK)
        snd1byte(0x00);
        save1byte();
        break;
//58hでMOTER ON
      case 0x58:
////    Serial.println("MOTER ON");
//状態コード送信(OK)
        snd1byte(0x00);
        moteron();
        break;
//59hでMOTER OFF
      case 0x59:
////    Serial.println("MOTER OFF");
//状態コード送信(OK)
        snd1byte(0x00);
        moteroff();
        break;

      default:
//状態コード送信(CMD ERROR)
        snd1byte(0xF4);
    }
  } else {
//状態コード送信(ERROR)
    snd1byte(0xF0);
  }
}
