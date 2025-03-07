# FM-7にSD-CARDからロード、セーブ機能

![TITLE](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/TITLE.JPG)
![TITLE2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/TITLE2.jpg)
![TITLE3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/TITLE3.jpg)

　FM-8、FM-7、FM-77シリーズでSD-CARDからロード、セーブ機能を実現するものです。

　対応できるBASICのバージョンは、FM-8はF-BASICV1.0(ROM-BASIC、DISK-VERSIONとも)、FM-7以降はF-BASICV3.0(ROM-BASIC、DISK-VERSIONとも)です。

　対応機種はFM-8からFM-77AV40SXまで全てのFMシリーズとなりますが、基板のRevsionにより対応範囲が異なります。

　Rev1.1とRev2.0の違いはコネクタのみです。

　Rev1.1はFM-7、FM-NEW7なら50Pinフラットケーブルで接続できますが、FM-77以降は外部拡張インタフェースの仕様が変更となっており、アンフェノール フルピッチへ変換するケーブルの自作が必要です。

　Rev2.0は32Pin拡張スロット仕様でFM-7以降全ての機種に接続できますが、純正の32Pinコネクタ(FCN-365P032-AU)は製造が終了してしまったため入手困難です。手持ちにある方は利用できますが、無い方はOMRON XC5A-3282-1が代替品として使えますが、加工が必要です。

　FM-8に繋げることが出来るのはRev3.0のみです。また、Rev3.0はFM-8、FM-7、FM-NEW7なら50Pinフラットケーブルで接続できますが、FM-77は外部拡張インタフェースの仕様が変更となっており、アンフェノール フルピッチへ変換するケーブルの自作が必要です。

|Revsion|対応機種|基板側コネクタ|本体側コネクタ|備考|
| ------------ | ------------ | ------------ | ------------ | ------------ |
|Rev1.1|FM-7、FM-NEW7|フラットケーブルコネクタ 50ピン|同左||
|Rev1.1|FM-77|フラットケーブルコネクタ 50ピン|アンフェノール フルピッチ50Pin|ケーブルの自作が必要|
|Rev1.1|FM-77AV|フラットケーブルコネクタ 50ピン|アンフェノール フルピッチ36Pin|ケーブルの自作が必要|
|Rev1.1|FM-77AV20以降|フラットケーブルコネクタ 50ピン|アンフェノール フルピッチ50Pin|ケーブルの自作が必要|
|Rev2.0|FM-7以降のすべて|32Pin拡張スロット||コネクタの加工が必要|
|Rev3.0|FM-8、FM-7、FM-NEW7|フラットケーブルコネクタ 50ピン|同左||
|Rev3.0|FM-77|フラットケーブルコネクタ 50ピン|アンフェノール フルピッチ50Pin|ケーブルの自作が必要|

### FM-8、FM-7、FM-77で使うときはBOOT-ROMの差替え有無を選択します。FM-77以降はFDD標準搭載なのでFDからFM-7_SD初期設定プログラムを走らせるものとしています。

　　1)BOOT-ROMを差し替える

　　2)BOOT-ROMを差し替えない。電源投入時又はRESET時に毎回CMTからFM-7_SD初期設定プログラムを読み込む(約15秒)

　　3)BOOT-ROMを差し替えない。電源投入時又はRESET時に毎回FDからFM-7_SD初期設定プログラムを走らせる。

　対応しているCMT形式は、FM-7がCMTで読み書きするベタCMT形式(拡張子bimとしています)です。T77からbimへの変換、bimからT77への変換にはツールを使って変換します。

　CMTからの読み込み実行に数分掛かっていたゲームも数十秒で実行できます。

　なお、Arduino、ROMへ書き込むための機器が別途必要となります。

## 対応できないもの
　BIOSのCMT読み書きルーチンをフックすることでSD-CARDへのアクセスを実現していますのでBIOSをコールせず独自ルーチンでCMTからLOADするソフト（ちゃっくんぽっぷ等）は対応できないのでLOAD出来ません。

　市販ソフトの多くが独自ルーチン、特殊フォーマットを使っているようです。

　bugfire2009さんのDumpListEditorにドロップしたときにファイルの大きさに比べて異様に小さなファイルしか解析できなかったり、(DAT)(unknown)と表示されるファイルが解析されるT77ファイルは独自ルーチン、特殊フォーマットを採用していると思います。

　市販ソフトがLOAD出来ればラッキーくらいに思って雑誌打ち込み系のLOADに活用してください。

## 回路図
### FM-7_SD Rev1.1基板
　KiCadフォルダ内Rev1.1フォルダのFM-7_SD_11.pdfを参照してください。

[回路図Rev1.1](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/Rev1.1/FM-7_SD_11.pdf)

![FM-7_SD_11](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/Rev1.1/FM-7_SD_11.jpg)

### FM-7_SD Rev2.0基板
　KiCadフォルダ内Rev2.0フォルダのFM-7_SD_20.pdfを参照してください。

[回路図Rev2.0](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/Rev2.0/FM-7_SD_20.pdf)

![FM-7_SD_20](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/Rev2.0/FM-7_SD_20.jpg)

### FM-7_SD Rev3.0基板
　KiCadフォルダ内Rev3.0フォルダのFM-7_SD_30.pdfを参照してください。

[回路図Rev3.0](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/Rev3.0/FM-7_SD_30.pdf)

![FM-7_SD_30](https://github.com/yanataka60/FM-7_SD/blob/main/KiCad/Rev3.0/FM-7_SD_30.jpg)

## 部品
### FM-7_SD Rev1.1基板
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J1|2x25ボックスヘッダ|1|共立エレショップ JS-1200R-50など、秋月電子通商 PH-2x40RGなどのピンヘッダでも代用可(注5)|
||J4、J5のいずれか(注1)|||
|J4|Micro_SD_Card_Kit|1|秋月電子通商 AE-microSD-LLCNV (注2)|
|J5|MicroSD Card Adapter|1|Arduino等に使われる5V電源に対応したもの (注6)|
|U1|74LS04|1||
|U2|74LS30|1||
|U3|8255|1||
|U4|Arduino_Pro_Mini_5V|1|Atmega328版を使用 168版は不可。(注3)|
|U5|74LS00|1||
|C1 C3 C4 C6|積層セラミックコンデンサ 0.1uF|4||
|C2|電解コンデンサ 16v100uF|1||
||ピンヘッダ|2Pin分|Arduino_Pro_MiniにはA4、A5用のピンヘッダが付いていないため別途調達が必要です 秋月電子通商 PH-1x40SGなど|
||ピンソケット(任意)|26Pin分|Arduino_Pro_Miniを取り外し可能としたい場合に調達します 秋月電子通商 FHU-1x42SGなど|
||本体内BOOT-ROMを差し替える場合|||
||ROM 2716又は2732|1|AT28C16、M2732Aなど|
||2732変換基板又は24PinICソケット|1|2732を使った場合の切り替え用|
||3Pトグルスイッチ|1|2732を使った場合の切り替え用|

### FM-7_SD Rev2.0基板
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J1|FCN-365P032-AU又はOMRON XC5A-3282-1|1|(注4)|
||J4、J5のいずれか(注1)|||
|J4|Micro_SD_Card_Kit|1|秋月電子通商 AE-microSD-LLCNV (注2)|
|J5|MicroSD Card Adapter|1|Arduino等に使われる5V電源に対応したもの (注6)|
|U1|74LS04|1||
|U2|74LS30|1||
|U3|8255|1||
|U4|Arduino_Pro_Mini_5V|1|Atmega328版を使用 168版は不可。(注3)|
|U5|74LS00|1||
|C1 C3 C4 C6|積層セラミックコンデンサ 0.1uF|4||
|C2|電解コンデンサ 16v100uF|1||
||ピンヘッダ|2Pin分|Arduino_Pro_MiniにはA4、A5用のピンヘッダが付いていないため別途調達が必要です 秋月電子通商 PH-1x40SGなど|
||ピンソケット(任意)|26Pin分|Arduino_Pro_Miniを取り外し可能としたい場合に調達します 秋月電子通商 FHU-1x42SGなど|
||本体内BOOT-ROMを差し替える場合|||
||ROM 2716又は2732|1|AT28C16、M2732Aなど|
||2732変換基板又は24PinICソケット|1|2732を使った場合の切り替え用|
||3Pトグルスイッチ|1|2732を使った場合の切り替え用|

### FM-7_SD Rev3.0基板
|番号|品名|数量|備考|
| ------------ | ------------ | ------------ | ------------ |
|J1|2x25ボックスヘッダ|1|共立エレショップ JS-1200R-50など、秋月電子通商 PH-2x40RGなどのピンヘッダでも代用可(注5)|
||J4、J5のいずれか(注1)|||
|J4|Micro_SD_Card_Kit|1|秋月電子通商 AE-microSD-LLCNV (注2)|
|J5|MicroSD Card Adapter|1|Arduino等に使われる5V電源に対応したもの (注6)|
|U1 U7|74LS04|2||
|U2 U6|74LS30|2||
|U3|8255|1||
|U4|Arduino_Pro_Mini_5V|1|Atmega328版を使用 168版は不可。(注3)|
|U5|74LS00|1||
|C1 C3 C4 C5 C6 C7|積層セラミックコンデンサ 0.1uF|6||
|C2|電解コンデンサ 16v100uF|1||
||ピンヘッダ|2Pin分|Arduino_Pro_MiniにはA4、A5用のピンヘッダが付いていないため別途調達が必要です 秋月電子通商 PH-1x40SGなど|
||ピンソケット(任意)|26Pin分|Arduino_Pro_Miniを取り外し可能としたい場合に調達します 秋月電子通商 FHU-1x42SGなど|
||本体内BOOT-ROMを差し替える場合|||
||ROM 2716又は2732|1|AT28C16、M2732Aなど|
||2732変換基板又は24PinICソケット|1|2732を使った場合の切り替え用|
||3Pトグルスイッチ|1|2732を使った場合の切り替え用|

　　　注1)J4又はJ5のどちらかを選択して取り付けてください。

　　　注2)秋月電子通商　AE-microSD-LLCNVのJ1ジャンパはショートしてください。

　　　注3)Arduino Pro MiniはA4、A5ピンも使っています。

　　　注4)FCN-365P032-AUは入手困難、OMRON XC5A-3282-1は加工が必要

　　　　　OMRON XC5A-3282-1は、ハウジング内の凸型に出っ張ている部分を台形に近付けるように削ってください。

![OMRON XC5A32821](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/OMRON%20XC5A32821.JPG)

　　　注5)ピンヘッダで代用するときは、基板から若干浮かせてピンヘッダをハンダ付けするとフラットケーブをスムーズに抜き差しできます。

　　　注6)MicroSD Card Adapterを使う場合

　　　　　J5に取り付けます。

　　　　　MicroSD Card Adapterについているピンヘッダを除去してハンダ付けするのが一番確実ですが、J5の穴にMicroSD Card Adapterをぴったりと押しつけ、裏から多めにハンダを流し込むことでハンダ付けをする方法もあります。なお、この方法の時にはしっかりハンダ付けが出来たかテスターで導通を確認しておいた方が安心です。

ハンダ付けに自信のない方はJ4の秋月電子通商　AE-microSD-LLCNVをお使いください。AE-microSD-LLCNVならパワーLED、アクセスLEDが付いています。

![MicroSD Card Adapter1](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/MicroSD%20Card%20Adapter.JPG)

![MicroSD Card Adapter2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/MicroSD%20Card%20Adapter2.JPG)

![MicroSD Card Adapter3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/MicroSD%20Card%20Adapter3.JPG)

## BOOT-ROMの差し替えを選択した場合
　FM-8、FM-7、FM-NEW7でBOOT-ROMの差し替えを選択した場合には、programフォルダ内bootromフォルダにある「FM-7_BOOTROM_SD.bin」を使いますが、Disk-Basicを使うか、使わないかでROMの差し替え方法が変わります。

　FM-8は「FM-7_BOOTROM_SD.bin」をbootrom_FM8フォルダにある「FM-8_BOOTROM_SD.bin」に読み替えてください。

#### 2023.2.17修正 DOS-MODEからの起動は出来ませんでした。運用方法は２通りとなります。

　1)FM-7_SDとCMTだけが使えればよい。(DISK-BASIC、DOS-MODEは使わない)

　　　元のBOOT-ROMを読み出す必要はありません。FM-7_BOOTROM_SD.binをROMライター(TL866II Plus等)を使ってROM 2716のアドレス$0000～$01FFに書き込んでBOOT-ROMのICソケットに装着します。

　2)FM-7_SDとCMTに加えてDISK-BASICは使いたい又は、FM-7_SD、CMT、DISK-BASIC、DOS-MODEのすべてを使いたい。

　　　ROM 2732の前半に元のBOOT-ROMの内容、後半の$0800～$09FFにFM-7_BOOTROM_SD.binとしたバイナリをROMライター(TL866II Plus等)を使って書き込みます。2732変換基板又は24PinICソケットの21Pinを曲げてスイッチで5VとGNDを切り替えられるようにしてBOOT-ROMのICソケットに装着します。

### FM-7 BOOT-ROMの場所
![boot-rom1](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/FM-7_BOOT-ROM_1.JPG)

![boot-rom2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/FM-7_BOOT-ROM_2.JPG)

### FM-NEW7 BOOT-ROMの場所
![boot-rom3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/NEW-7_BOOT-ROM_1.JPG)

![boot-rom4](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/NEW-7_BOOT-ROM_2.JPG)

### FM-8 BOOT-ROMの場所
電源ユニットの下です。
![boot-rom5](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/FM8_BOOT-ROM_1.JPG)

![boot-rom6](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/FM8_BOOT-ROM_2.JPG)

## SD-CARDアクセス初期設定プログラム
### BOOT-ROMを差し替えた場合
　programフォルダ内boot_iplフォルダの「@BOOT_IPL_FM-7.bin」をSD-CARDにコピーしてください。

　FM-8の場合は、boot_ipl_FM8フォルダ内の「@BOOT_IPL_FM-8.bin」をSD-CARDにコピーします。なお、「@BOOT_IPL_FM-7.bin」と「@BOOT_IPL_FM-8.bin」の両方がSD-CARDにコピーしてあっても大丈夫です。

　FM-7起動後に「EXEC &HFE02」(又は「EXEC -510」)を実行することでSD-CARDから「@BOOT_IPL_FM-7.bin」がテキストエリアの最初に読み込まれSD-CARDが使えるようBASICコマンドの追加、BIOSへのパッチあて、テキストエリアの再設定が行われます。

### BOOT-ROMを差し替えない場合
#### FDから起動
　DISKBASICフォルダのSDINIT_FM7.D77ディスクイメージをFDに書き込むか、SDINIT_FM7.binをFDに書き込んでください。

#### CMTから起動
　CMTLOADフォルダのSDINIT_FM7.wav(FM8は、SDINIT_FM8.wav)をCMTからロードして実行します。

## Arduinoプログラム
　Arduino IDEを使ってArduinoフォルダのFM-7_SDフォルダ内FM-7_SD.inoを書き込みます。FM-8も共通のプログラムを使用しています。

　SdFatライブラリを使用しているのでArduino IDEメニューのライブラリの管理からライブラリマネージャを立ち上げて「SdFat」をインストールしてください。

　「SdFat」で検索すれば見つかります。「SdFat」と「SdFat - Adafruit Fork」が見つかりますが「SdFat」のほうを使っています。

注)Arduinoを基板に直付けしていてもFM-7本体から外していれば書き込めます。

#### 電源が入ったFM-7本体とFM-7_SDを繋げたままArduinoを書き込む場合には、Arduinoに繋ぐシリアルコンバータから絶対に電源を供給しないでください。最悪FM-7本体が破壊される場合があります。

## 接続
　Rev1.1、Rev3.0をFM-8、FM-7、FM-NEW7で使う場合には本体後ろの50Pin拡張端子から50Pinフラットケーブルで接続します。

![connect1](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/CONNECT_1.JPG)

![connect2](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/CONNECT_2.JPG)

　50Pinフラットケーブルは、コネクタのボッチとケーブルの返しが両方上になる側のコネクタを本体に嵌めます。

![Cable3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/Cable3.JPG)

![Cable3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/Cable1.JPG)

　逆側のコネクタを本体に嵌めると一見嵌っているように見えてもケーブルの返しが基板に当たっていてちゃんと嵌っておらず接触不良を起こしていることがあります。

#### 悪い例です
![Cable3](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/Cable2.JPG)

　Rev1.1をFM-77以降、Rev3.0をFM-77で使う場合にはアンフェノール フルピッチへ変換するケーブルの自作が必要です。

　接続ピンは、はせりんさんのサイトが参考になります。

　http://haserin09.la.coocan.jp/difference.html

## SD-CARD
　出来れば8GB以下のSDカードを用意してください。

　ArduinoのSdFatライブラリは、SD規格(最大2GB)、SDHC規格(2GB～32GB)に対応していますが、SDXC規格(32GB～2TB)には対応していません。

　また、SDHC規格のSDカードであっても32GB、16GBは相性により動作しないものがあるようです。

　FAT16又はFAT32が認識できます。NTFSは認識できません。

　ルートに置かれた拡張子が「.BIM」のCMTベタ形式ファイルのみLOAD、SAVEできます。(以外のファイル、フォルダも表示されますが読み書き出来ません)

　ファイル名は拡張子を除いて32文字まで、ただし半角カタカナ、及び一部の記号はArduinoが認識しないので使えません。パソコンでファイル名を付けるときはアルファベット、数字および空白でファイル名をつけてください。

## T77ファイルの扱い方
　T77ファイルはそのまま使えません。

　Apolloさんが公開してくださっている「T77DEC」を使ってCMTベタ形式に変換して使います。

　http://retropc.net/apollo/

　変換例)T77DEC TEST.T77 -d[CR]

　を実行するとFULLDUMP.BINというファイルが出来上がるので拡張子を.bimに変えて使います。

![batch_file](https://github.com/yanataka60/FM-7_SD/blob/main/jpeg/batch_file.jpg)

　こんなバッチファイルを作ると便利です。

　bimファイルをT77に戻すにはBET2T77フォルダ内の「BET2T77.exe」を使います。

　「BET2T77.exe」を起動し、開いたウィンドウにbimファイルをドロップすればT77ファイルが作成されます。

## 起動手順
### ROM-BASIC(BOOT-ROM差し替え済の場合)
　1　電源を入れます。

　2　この時点ではCMTが使えるROM-BASICが起動しています。

　3　「EXEC &HFE02」(又は「EXEC -510」)を実行します。

　4　「FM-7_SD READY OK!」と表示されたらSD-CARDにアクセスできます。BASICのフリーエリアは947Byte程減少します。

### DISK-BASIC
　1　電源を入れ、DISK-BASICを起動します。

　2　作成したFDの中にある「SDINIT」をロードし、実行します。

　　　LOADM"SDINIT"してからEXEC &H6000又はLOADM"SDINIT",,R

　3　「FM-7_SD READY OK!」と表示されたらSD-CARDにアクセスできます。

　4　LOADM"SDINIT",,RをSTARTUPとして保存し、AUTOUTYで自動実行を設定すれば手間が省けます。

　5　SDからLOAD、SAVEする場合にはファイルデスクリプタ「CAS0:」が必ず必要になります。

## 使い方
　BASICから以下のコマンドが使えます。
### CMT[CR]
CMTを使いたい時に実行します。

BIOSのフックを元に戻してCMTが使えるようにします。ただし、SD-CARDアクセス用のプログラムは常駐したまま残っていますのでBASICのフリーエリアは減少したままです。

### SDON[CR]
CMTコマンドで戻してしまったBIOSのフックをSD-CARD用にフックし直します。

CMTコマンドと合わせて使えばCMTから読み込んでSD-CARDに保存することができます。

### SETL "DOSファイル名"[CR]
指定したDOSファイル名のファイルをSD-CARDからLOAD出来るようにセットします。ファイル名の前には必ずダブルコーテーションをつけてください。後ろのダブルコーテーションは有っても無くても構いません。

ファイル名の最後の「.bim」は有っても無くても構いません。

SETLを実行することでカセットテープをセットして読み込む準備をしたことになります。

### LOAD
F-BASICのLOADコマンドと同じ使い方になります。

#### 例)
　　LOAD[CR]

　　LOAD "TEST"[CR]

　　LOAD "CAS0:TEST"[CR]

　　LOAD "TEST",R[CR]

ROM-BASICの場合には、ファイルデスクリプタ「CAS0:」は有っても無くても構いません。DISK-BASICの場合にSDからLOADするには必ず必要です。

カセットテープと同じようにLOAD命令等で読み込みが行われる度にDOSファイル名で指定したファイルに保存されているプログラム又はデータが先頭から一つずつ読み込まれます。

カセットデッキのように巻き戻しは無いので戻りたい時にはもう一度SETLコマンドを実行すれば先頭のプログラム又はデータに戻ります。

### LOADM
F-BASICのLOADMコマンドと同じ使い方です。

### SETS "DOSファイル名"[CR]
指定したDOSファイル名のファイルをSD-CARDへSAVE出来るようにセットします。ファイル名の前には必ずダブルコーテーションをつけてください。後ろのダブルコーテーションは有っても無くても構いません。

ファイル名の最後の「.bim」は有っても無くても構いません。

指定したDOSファイル名のファイルがSD-ACRDに存在しない場合は新たに作成され、存在する場合にはそのファイルの続きに追記されます。

SETSを実行することでカセットテープをセットして書き込む準備をしたことになります。

なお、SETSを実行せずにSAVE、SAVEMコマンドを実行すると「DEFAULT.bim」というDOSファイル名のファイルに自動的に書き込まれます。

「DEFAULT.bim」でなく好きなDOSファイル名のファイルに書き込みたい時には事前にSETSコマンドを実行してください。

### SAVE
F-BASICのSAVEコマンドと同じ使い方になります。

#### 例)
　　SAVE "TEST"[CR]

　　SAVE "CAS0:TEST"[CR]

　　SAVE "TEST",A[CR]

　　SAVE "TEST",P[CR]

ROM-BASICの場合には、ファイルデスクリプタ「CAS0:」は有っても無くても構いません。DISK-BASICの場合にSDへSAVEするには必ず必要です。

### SAVEM
F-BASICのSAVEMコマンドと同じ使い方です。

### SDIR[CR] 又は SDIR "文字列"[CR]

文字列を指定するときは必ずダブルコーテーションをつけてください。後ろのダブルコーテーションは有っても無くても構いません。

文字列を入力せずにSDIR[CR]のみ入力するとSD-CARDルートディレクトリにあるファイルの一覧を表示します。

文字列を付けて入力すればSD-CARDルートディレクトリにあるその文字列から始まるファイルの一覧を表示します。

10件表示したところで指示待ちになるので打ち切るならESCを入力すると打ち切られ、Bキーで前の10件に戻ります。それ以外のキーで次の10件を表示します。

　行頭に0から9の数字を付加して表示してあるのでSETLしたいファイルの頭についている数字を入力するとSETLコマンドが実行されます。

　表示される順番は、登録順となりファイル名アルファベッド順などのソートした順で表示することはできません。

#### 例)
　　SDIR[CR]

　　SDIR "P"[CR]

### 操作上の注意
　~~「SD-CARD INITIALIZE ERROR」と表示されたときは、SD-CARDをいったん抜き再挿入したうえでArduinoをリセットしてください。~~

　~~SD-CARDにアクセスしていない時に電源が入ったままで SD-CARDを抜いた後、再挿入しSD-CARDにアクセスすると「SD-CARD INITIALIZE ERROR」となる場合があります。再挿入した場合にはSD-CARDにアクセスする前にArduinoを必ずリセットしてください。~~

　~~SD-CARDの抜き差しは電源を切った状態で行うほうがより確実です。~~

　(2024.3.12) SD-CARDにアクセスしていない時に電源が入ったままでSD-CARDを抜くと再度SD-CARDを挿入してもSD-CARDにアクセスできない問題を解消しました。(Arduinoを最新版に書き換えてください)

　再度SD-CARDを挿入した後、SDIR、SETL、SETS等でSD-CARDに3回ほどアクセスすれば復旧します。

　LOAD、LOADM、SAVE、SAVEMでは復旧しません。


## EXAS-FMコンパイラ起動プログラム
　月刊I/O '84/4月号に掲載されたEXAS-FMコンパイラをFM-7_SDから起動できるようにする起動プログラムです。

### EXAS-FMコンパイラSD起動用ファイルの作成
　まず、EXAS-FMコンパイラ本体のバイナリファイルを掲載のダンプリストどおりに打ち込みます。

　記事では「実際にROMに書き込むときには、8FFAの6バイトに次の物を入れ、8FFA-EFF9を書き込んでください。」となっています。この6バイトは付いていても付いていなくてもどちらでも構いません。

　バイナリエディタ等でEXAS-FM_BOOTフォルダにある「EXAS-FM_BOOT.bim」の後ろにEXAS-FMコンパイラ本体をくっつけ「EXAS-FM.bim」というファイル名で保存し、SD-CARDにコピーしてください。

　出来上がったEXAS-FMコンパイラSD起動用ファイルのサイズは、6バイトを付加していれば25304Byte、いなければ25298Byteとなるはずです。

### 起動方法
　FM-7を起動し、「EXEC&HFE02」を実行します。

　「clear,&h6FFF」でEXAS-FMコンパイラSD起動用プログラムの領域を確保します。

　「sdir」で「EXAS-FM」を選択します。

　「loadm」「exec&H7000」又は「loadm"EXAS-FM",,R」でEXAS-FMコンパイラが裏RAMに転送、実行されます。

　コンパイルでエラー等が発生し、ソースプログラムを修正したのちに再度コンパイルする場合には次の２通りの方法があります。

　　１　FM-7をSDモードで起動している場合には、「EXEC&HFFE8」でEXAS-FMコンパイラを起動できます。

　　２　DISK-BASICから起動してFM-7_SDを使っている場合には、「sdir」で「EXAS-FM」を選択後、「loadm」「exec&H7000」又は「loadm"EXAS-FM",,R」を再度実行してください。ただし、裏RAMにEXAS-FMコンパイラが既に転送されていますのでSDからEXAS-FMコンパイラの読み込みは行われずに起動します。

## 簡略版@BOOT_IPL_FM-7.bin、簡略版@BOOT_IPL_FM-8.bin
　ひぽぽ様より月刊I/O '82/2月号に掲載された「ALL CAST STAR TREK」がSDから読込めはしたものの実行するとOut Of Memoryで止まってしまうという情報を頂きました。

　記事中にも「メモリをフルに使用しており」との記載があり、フリーエリアぎりぎりまで使用しているため、@BOOT_IPL_FM-x.binの常駐によるフリーエリアの減少によりOut Of Memoryになってしまうようです。

　しかし、SDからLOADは出来ており、実行時に変数を割り当てた段階でOut Of Memoryになるのであればちょっと頑張れば実行できる可能性がありそうです。

　そこで@BOOT_IPL_FM-x.binで追加するコマンドを必要最低限の「SDIR」「SETS」のみとした簡略版を作成しました。

　今のところ「ALL CAST STAR TREK」も無事動いているようです。

　通常版との違いは以下のとおりですが、通常の運用にも困らないと思います。

　・CMT、SDON、SETLコマンドが使えない。

　・エラーメッセージ等のメッセージを簡略化。

　・追加CMDテーブルがギリギリサイズ。

### 使用方法
　EXTRA-programフォルダにある「@BOOT_IPL_FM-7.bin」「@BOOT_IPL_FM-8.bin」をSDカードにコピーし、既存の「@BOOT_IPL_FM-7.bin」「@BOOT_IPL_FM-8.bin」を上書きしてください。

## プログラム・ポシェット No.6掲載「PF-X」をFM-7_SDで使えるようにするIPSパッチ
　ひぽぽ様よりプログラム・ポシェット No.6掲載「PF-X」をFM-7_SDで使いたいとの要望がありました。

　「PF-X」もBASICにコマンドを追加することでPCGを実現しており、FM-7_SDのコマンド追加を上書きしてしまうため、FM-7_SDが正常に動作しなくなってしまいます。

　そこで「PF-X」の初期化ルーチンに手を入れ、FM-7_SDと両立できるIPSパッチを作成しました。

### PF-Xの準備
　PF-Xへのパッチ当てにあたり、PF-Xのバイナリファイルを用意してください。

　プログラム・ポシェット掲載のBASICプログラムは、DATA文を読み込み&H4000から機械語プログラム(&H4000～&H42CF 720Byte)を書き込み、エラーが無ければEXEC &H4000でPF-Xが使えるようになります。

　BASICプログラムのDATA文を見ながらバイナリファイル(&H4000～&H42CF 720Byte)が作成できる方はPF-X.bin等のファイル名を付けて保存します。

　そうでない方は、エミュレータ又は実機でPF-XのBASICプログラムを実行し、「READY !!」と表示された後に「SAVEM "PF-X",&H4000,&H42CF,&H4000」を実行してCMTに保存します。

　保存した機械語をDumpListEditor等を使い、ヘッダ等の無いバイナリファイル(&H4000～&H42CF 720Byte)として保存します。

### パッチ当て
　作成したPF-XのバイナリファイルにWinIPS等を使い、EXTRA-programフォルダにある「PF-X_SD.ips」のパッチを当ててください。

　「PF-X_SD.BIN」(2287Byte)というファイルが出来上がりますので「PF-X_SD.bim」にリネームしてSDカードにコピーします。

### PF-X_SDの実行
　SDIR等で「PF-X_SD」を選択し、LOADMで読み込み、EXEC &H4000で実行します。

　「PF-X READY OK!」と表示されれば終了です。

　FM-7_SDとしては、簡略版@BOOT_IPL_FM-7.binで起動しても通常版@BOOT_IPL_FM-7.binの機能が使えるようになってます。

　PF-Xの使い方は、プログラム・ポシェット No.6を参照願います。

## 謝辞
　基板の作成に当たり以下のデータを使わせていただきました。ありがとうございます。

　Arduino Pro Mini

　　https://github.com/g200kg/kicad-lib-arduino

　AE-microSD-LLCNV

　　https://github.com/kuninet/PC-8001-SD-8kRAM

　Apollo様、公開していただいているソフトを使わせていただきました。ありがとうございます。

　はせりん様のサイトにあるインタフェース仕様表が大変参考になりました。ありがとうございます。

　　http://haserin09.la.coocan.jp/difference.html

　AIGOU Yoshiaki様に少しの加工でOMRON XC5A-3282-1がFCN-365P032-AUの代替に使えると教えていただきました。ありがとうございます。

## 追記
2023.2.11 @BOOT_IPL_FM-7.binをリロケータブルに修正

2023.2.13 FDからFM-7_SDの初期設定を行うプログラムを追加

　　　　　FM-77、FM-77AVにおける動作状況を追記しました。

2023.2.15 CMTから読み込む方法も追加しました。

2023.2.17 DOS-MODEからの起動は出来ませんでした。BOOT-ROMの差し替え方は２通りとなります。

2023.2.18 50Pinフラットケーブルの嵌め方を追記しました。

2023.2.21 機種、コネクタの違いから基板3種(Rev1.1、Rev2.0、Rev3.0)を用意したため、Documentを全面修正しました。

2023.4.12 EXAS-FMコンパイラ起動用プログラムを追加しました。

2024.1.15 SDカードは8GB以下が望ましいことを追記。

2024.3.12 電源が入ったままでSD-CARDを抜くと再度SD-CARDを挿入してもSD-CARDにアクセスできない問題を解消した。

2024.5. 2 簡略版@BOOT_IPL_FM-7.bin、簡略版@BOOT_IPL_FM-8.binを公開しました。

　　　　　プログラム・ポシェット No.6掲載「PF-X」をFM-7_SDで使えるようにするIPSパッチを公開しました。

2025.1.29 コネクタの記述を修正しました。
