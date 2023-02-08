# FM-7にSD-CARDからロード、セーブ機能

![TITLE](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/TITLE.JPG)

　FM-7でSD-CARDからロード、セーブ機能を実現するものです。

　対応機種はFM-7、FM-NEW7です。(以下FM-7と記述します。)

　FM-7本体内のBOOT-ROMの差し替えが必須となります。

　対応しているCMT形式は、FM-7がCMTで読み書きするバイナリデータ形式(拡張子BIMとしています)です。T77<->BIMはツールを使って変換が必要です。

　CMTからの読み込み実行に数分掛かっていたゲームも数十秒で実行できます。

　なお、Arduino、ROMへ書き込むための機器が別途必要となります。

## 対応できないもの
　BIOSのCMT読み書きルーチンをフックすることでSD-CARDへのアクセスを実現していますのでBIOSをコールせず独自にCMTからLOADするソフト（ちゃっくんぽっぷ等）は対応できないので途中で止まります。

## 回路図
### FM-7_SD基板
　KiCadフォルダ内のFM-7_SD.pdfを参照してください。

[回路図](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/FM-7_SD.pdf)

![FM-7_SD](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/FM-7_SD_1.jpg)

## 部品
### FM-7_SD基板
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J1|2x25Pinコネクタ|1|秋月電子通商 PH-2x40RGなど|
||J4、J5のいずれか(注1)|||
|J4|Micro_SD_Card_Kit|1|秋月電子通商 AE-microSD-LLCNV (注2)|
|J5|MicroSD Card Adapter|1|Arduino等に使われる5V電源に対応したもの (注4)|
|U1|74LS04|1||
|U2|74LS30|1||
|U3|8255|1||
|U4|Arduino_Pro_Mini_5V|1|(注3)|
|U5|74LS00|1||
|C1 C3 C4 C6|積層セラミックコンデンサ 0.1uF|4||
|C2|電解コンデンサ 16v100uF|1||
||ROM 2716又は2732|1|AT28C16、M2732Aなど|
||2732変換基板又は24PinICソケット|1|2732を使った場合切り替え用|
||3Pトグルスイッチ|1|2732を使った場合の切り替え用|

　　　注1)J2又はJ3のどちらかを選択して取り付けてください。

　　　注2)秋月電子通商　AE-microSD-LLCNVのJ1ジャンパはショートしてください。

　　　注3)Arduino Pro MiniはA4、A5ピンも使っています。

　　　注4)MicroSD Card Adapterを使う場合

　　　　　J5に取り付けます。

　　　　　MicroSD Card Adapterについているピンヘッダを除去してハンダ付けするのが一番確実ですが、J5の穴にMicroSD Card Adapterをぴったりと押しつけ、裏から多めにハンダを流し込むことでハンダ付けをする方法もあります。なお、この方法の時にはしっかりハンダ付けが出来たかテスターで導通を確認しておいた方が安心です。

ハンダ付けに自信のない方はJ4の秋月電子通商　AE-microSD-LLCNVをお使いください。AE-microSD-LLCNVならパワーLED、アクセスLEDが付いています。

![MicroSD Card Adapter1](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/MicroSD%20Card%20Adapter.JPG)

![MicroSD Card Adapter2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/MicroSD%20Card%20Adapter2.JPG)

![MicroSD Card Adapter3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/MicroSD%20Card%20Adapter3.JPG)

## BOOT-ROMの差し替え
　FM-7_SDを使うにはBOOT-ROMの差し替えが必須になります。

　運用方法としては次の３つによりROMの差し替え方法が変わります。

　1　FM-7_SDとCMTだけが使えればよい。(DISK-BASIC、DOS-MODEは使わない)

　　　元のBOOT-ROMを読み出す必要はありません。FM-7_BOOTROM_SD.binをROMライター(TL866II Plus等)を使ってROM 2716のアドレス($0000～$01FF、$0400～$05FF)に書き込んでBOOT-ROMのICソケットに装着します。

　2　FM-7_SDとCMTに加えてDISK-BASICは使いたい。(DOS-MODEは使わない)

　　　元のBOOT-ROMの内容の後半DOS-MODE用の領域($0400～$05FF)をFM-7_BOOTROM_SD.binに差し替えたバイナリをROMライター(TL866II Plus等)を使ってROM 2716に書き込んでBOOT-ROMのICソケットに装着します。

　3　FM-7_SD、CMT、DISK-BASIC、DOS-MODEのすべてを使いたい。

　　　ROM 2732の前半に元のBOOT-ROMの内容、後半($0800～$09FF、$0C00～$0DFFのいずれか)にFM-7_BOOTROM_SD.binとしたバイナリをROMライター(TL866II Plus等)を使って書き込みます。2732変換基板又は24PinICソケットの21Pinを曲げてスイッチで5VとGNDを切り替えられるようにしてBOOT-ROMのICソケットに装着します。

　「FM-7_BOOTROM_SD.bin」はprogramフォルダ内bootromフォルダにあります。

### FM-7 BOOT-ROM
![boot-rom1](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/FM-7_BOOT-ROM_1.JPG)

![boot-rom2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/FM-7_BOOT-ROM_2.JPG)

### FM-NEW7 BOOT-ROM
![boot-rom3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/NEW-7_BOOT-ROM_1.JPG)

![boot-rom4](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/NEW-7_BOOT-ROM_2.JPG)

## SD-CARDアクセス初期設定プログラム
　programフォルダ内boot_iplフォルダの「@BOOT_IPL_FM-7.bin」をSD-CARDにコピーしてください。

　FM-7起動後に「EXEC &HFE02」を実行することでSD-CARDから「@BOOT_IPL_FM-7.bin」がテキストエリアの最初に読み込まれSD-CARDが使えるようBASICコマンドの追加、BIOSへのパッチあて、テキストエリアの再設定が行われます。

## Arduinoプログラム
　Arduino IDEを使ってArduinoフォルダのFM-7_SDフォルダ内FM-7_SD.inoを書き込みます。

　SdFatライブラリを使用しているのでArduino IDEメニューのライブラリの管理からライブラリマネージャを立ち上げて「SdFat」をインストールしてください。

　「SdFat」で検索すれば見つかります。「SdFat」と「SdFat - Adafruit Fork」が見つかりますが「SdFat」のほうを使っています。

注)Arduinoを基板に直付けしていてもFM-7本体から外していれば書き込めます。

### 電源が入ったFM-7本体とFM-7_SDを繋げたままArduinoを書き込む場合には、Arduinoに繋ぐシリアルコンバータから絶対に電源を供給しないでください。最悪FM-7本体が破壊される場合があります。

## 接続
　FM-7本体後ろの50Pin拡張端子から50Pinフラットケーブルで接続します。

![connect1](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/CONNECT_1.JPG)

![connect2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/CONNECT_2.JPG)

## SD-CARD
　FAT16又はFAT32が認識できます。

　ルートに置かれた拡張子が「.BIM」のCMTベタ形式ファイルのみ認識できます。(以外のファイル、フォルダも表示されますが読み込めません)

　ファイル名は拡張子を除いて32文字まで、ただし半角カタカナ、及び一部の記号はArduinoが認識しないので使えません。パソコンでファイル名を付けるときはアルファベット、数字および空白でファイル名をつけてください。

## T77ファイルの扱い方
　T77ファイルはそのまま使えません。

　Apolloさんが公開してくださっている「T77DEC」を使ってCMTベタ形式に変換して使います。

　http://retropc.net/apollo/

　変換例)T77DEC TEST.T77 -d[CR]

　を実行するとFULLDUMP.BINというファイルが出来上がるので拡張子を.bimに変えた好きなファイル名に変更して使います。

![batch_file](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/batch_file.jpg)

　こんなバッチファイルを作ると便利です。

　bimファイルをT77に戻すにはBET2T77フォルダ内の「BET2T77.exe」を使います。

　「BET2T77.exe」を起動し、開いたウィンドウにbimファイルをドロップすればT77ファイルが作成されます。

## 起動手順
　1　FM-7_SDを50Pinフラットケーブルでつなぎます。

　2　BOOT-ROMの差し替え方に合わせて本体後部のディップスイッチを切り替えます。

　3　電源を入れます。

　4　この時点ではCMTが使えるROM-BASICが起動しています。

　5　「EXEC &HFE02」を実行します。

　6　「FM-7_SD READY OK!」と表示されたらSD-CARDにアクセスできます。BASICのフリーエリアは30530Byteから29588Byteに減少します。

## 使い方
　BASICから以下のコマンドが使えます。
#### SETL "DOSファイル名"[CR]
指定した

F[CR]又はF 文字列[CR]
文字列を入力せずにF[CR]のみ入力するとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

文字列を付けて入力すればSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

10件表示したところで指示待ちになるので打ち切るならESC又は↑を入力すると打ち切られ、Bキーで前の10件に戻ります。それ以外のキーで次の10件を表示します。

　行頭に「*L 」を付加して表示してあるので実行したいファイルにカーソルキーを合わせて[CR]キーを押すだけでLOAD可能です。

　LOADの挙動については次のLコマンドの記述を参照してください。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

##### 例)
　　F[CR]

　　F S[CR]

　　F SP[CR]

#### L DOSファイル名[CR]
指定したDOSフィル名のファイルをSD-CARDからLOADします。

ファイル名の最後の「.P6T」「.CAS」は有っても無くても構いませんが、無い場合は「.P6T」が指定されたものとみなします。

　例)

　　L TEST.P6T -> DOSファイル名「TEST.P6T」を読み込みます。

　　L TEST.CAS -> DOSファイル名「TEST.CAS」を読み込みます。

　　L TEST -> DOSファイル名「TEST.P6T」を読み込みます。

　選択したファイルが「P6T」形式の場合、設定されたPagesで起動したうえで自動実行文字列を実行します。

　選択したファイルが「CAS」形式の場合、「How Many Pages?(1-4)」と聞いてくるので画面数を入力、次に「Auto Run?(y/n)」と聞いてくるので「y」とすれば起動直後にCLOAD[CR]RUN[CR]が実行され、「n」とすればCLOAD[CR]だけが実行されます。

#### 操作上の注意
　「SD-CARD INITIALIZE ERROR」と表示されたときは、SD-CARDが挿入されているか確認し、PC-6001本体をリセットしてください。Arduinoのみのリセットでは復旧しません。

　SD-CARDにアクセスしていない時に電源が入ったままで SD-CARDを抜いた後、再挿入しSD-CARDにアクセスすると「SD-CARD INITIALIZE ERROR」となる場合があります。再挿入した場合にはSD-CARDにアクセスする前にArduinoを必ずリセットしてください。

　SD-CARDの抜き差しは電源を切った状態で行うほうがより確実です。

### BASICコマンド
#### LOAD "DOSファイル名"[CR]
指定したDOSフィル名のBASICプログラムをSD-CARDからLOADします。

ファイル名は6文字以内で必須です。6文字以上入力された場合には7文字以降は無視されます。ファイル名を入力せずにCLOAD[CR]とすると暴走します。

ファイル名の前に"(ダブルコーテーション)は必須ですが、ファイル名の後ろに"(ダブルコーテーション)は有っても無くても構いません。

ファイル名の最後に「.CAS」は必要ありません。「.CAS」が指定されたものとみなします。

　例)

　　LOAD "TEST" -> DOSファイル名「TEST.CAS」を読み込みます。

　　LOAD "TESTTEST" -> DOSファイル名「TESTTE.CAS」を読み込みます。

　　LOAD "TEST.BAS.CMT" -> DOSファイル名「TEST.BA.CMT」を読み込みます。

#### SAVE "DOSファイル名"[CR]
BASICプログラムを指定したDOSフィル名でSD-CARDに上書きSAVEします。

ファイル名は6文字以内で必須です。6文字以上入力された場合には7文字以降は無視されます。

ファイル名の前に"(ダブルコーテーション)は必須ですが、ファイル名の後ろに"(ダブルコーテーション)は有っても無くても構いません。

ファイル名の最後の「.CAS」は必要ありません。「.CAS」が指定されたものとみなします。

　例)

　　SAVE "TEST" -> 「TEST.CAS」で保存される。

　　SAVE "TESTTEST" -> 「TESTTE.CAS」で保存される。

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございました。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM
