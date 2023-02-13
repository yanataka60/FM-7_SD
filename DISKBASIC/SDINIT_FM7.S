;2023.2.11 リロケータブルに修正
;
			ORG		$6000
		
FILENO		EQU		$00BF	;ファイル番号
READ1		EQU		$00D2	;汎用読み込みルーチン
READ0		EQU		$00D8	;汎用読み込みルーチン、ポインタ移動無し
BIOSV		EQU		$00DE	;BIOSジャンプルーチン
EXTNUM		EQU		$0203	;拡張予約語の数
EXTTBL		EQU		$0204	;拡張予約語の綴りテーブルの先頭アドレス
EXTTRN		EQU		$0210	;Syntax Errorのアドレス
LBUF		EQU		$053F	;数値->文字列変換における文字列バッファ(ファイル名受信バッファとして使用)
ERRENT		EQU		$92A0	;Syntax Errorエントリ
GETSTR		EQU		$98F1	;文字列実効番地読み出し
AZLCNV		EQU		$C495	;英小文字->大文字変換ルーチン
LOUT1		EQU		$D90F	;文字列出力ルーチン
INPUT1		EQU		$DB54	;キーボード1Byte入力ルーチン
RETADD		EQU		$FBFA	;本来のBIOSジャンプルーチンエントリ
TEXTOP		EQU		$0033
NEW2		EQU		$8F39
READY		EQU		$8E72
PIOA		EQU		$FDF0
PIOB		EQU		$FDF1
PIOC		EQU		$FDF2
PIOR		EQU		$FDF3
*

TRNS	BSR		PIOINI			;PIO初期化
		LDU		TEXTOP			;U <- SDアクセスルーチンの転送先
		LEAX	START,PCR		;X <- SDアクセスルーチンの転送元
		LDY		#TBLEND-START	;転送するバイト数
TRNS1	LDA		,X+
		STA		,U+
		LEAY	-1,Y
		BNE		TRNS1
		
		LEAU	1,U
		PSHS	U

		BSR		START			;SDアクセス初期設定

		PULS	X
		
		STX		TEXTOP			;フリーエリア先頭アドレス再設定
		CLR		,X+
		JSR		NEW2
		JMP		READY

**** 8255初期化 ****
*PORTC下位BITをOUTPUT、上位BITをINPUT、PORTBをINPUT、PORTAをOUTPUT
PIOINI	LDA		#$8A
		STA		PIOR		;PIOR <- $8A
		CLRA
		STA		PIOA		;PIOA <- $00
		STA		PIOC		;PIOC <- $00
		RTS

*		ORG		$0B5B
START	
* 拡張コマンドテーブルを#NEWTBLにコピーして拡張コマンド「SDIR」「SETL」「SETS」「SDON」「CMT」を追加
		LDB		EXTNUM		;B <- 拡張コマンド数
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		LDX		EXTTBL		;X <- 旧拡張コマンドTBLアドレス
		LEAU	NEWTBL,PCR	;U <- 新拡張コマンドTBLアドレス
		STU		EXTTBL		;拡張コマンドTBLポインタ <- 新拡張コマンドTBLアドレス
*
COPY	LDA		,X+			;拡張コマンドTBLをコピー
		STA		,U+
		BPL		COPY		;BIT7が1になるまでループ
		DECB				;カウンタ-1
		BNE		COPY		;カウンタが0になるまでループ
*
		LDA		#'S			;「SDIR」コマンドを追加
		LDB		#'D
		STD		,U++
		LDA		#'I
		LDB		#'R+$80
		STD		,U++
*
		LDA		#'S			;「SETL」コマンドを追加
		LDB		#'E
		STD		,U++
		LDA		#'T
		LDB		#'L+$80
		STD		,U++
*
		LDA		#'S			;「SETS」コマンドを追加
		LDB		#'E
		STD		,U++
		LDA		#'T
		LDB		#'S+$80
		STD		,U++

		LDA		#'S			;「SDON」コマンドを追加
		LDB		#'D
		STD		,U++
		LDA		#'O
		LDB		#'N+$80
		STD		,U++

		LDA		#'C			;「CMT」コマンドを追加
		LDB		#'M
		STD		,U++
		LDA		#'T+$80
		LDB		#$00
		STD		,U+

		LEAX	NEWTRN,PCR		;追加コマンド判定ルーチンアドレス
		STX		EXTTRN		;拡張コマンド判定後のジャンプ先アドレスポインタを追加コマンド判定ルーチンアドレスに書き換え

*BIOS CWRITE CREADフック
BIOSF	LEAX	BIOSR,PCR
		STX		BIOSV+1		;($DF) <- BIOSフック用ルーチンアドレス

*SD関連書き換え終了メッセージ
		CLR		<FILENO			;($00BF) <- 0 画面出力へ設定
		LEAX	MSG1,PCR
		JSR		LOUT1			;「FM-7_SD READY OK!」を表示

		RTS						;BASICへ戻る
		
*
ERR02	JMP		ERRENT

*追加コマンド判定ルーチン
NEWTRN	CMPA	#$F4		;「SDIR」判定
		BNE		NEWTRN2
		JSR		READ1		;入力コマンド解釈ポインタ+1
		BRA		SDIR_PRG
NEWTRN2	CMPA	#$F5		;「SETL」判定
		BNE		NEWTRN3
		JSR		READ1		;入力コマンド解釈ポインタ+1
		LBRA		SETL_PRG
NEWTRN3	CMPA	#$F6		;「SETS」判定
		BNE		NEWTRN4
		JSR		READ1		;入力コマンド解釈ポインタ+1
		LBRA		SETS_PRG
NEWTRN4	CMPA	#$F7		;「SDON」判定
		BNE		NEWTRN5
		JSR		READ1		;入力コマンド解釈ポインタ+1
		LBRA		SDON_PRG
NEWTRN5	CMPA	#$F8		;「CMT」判定
		BNE		ERR02		;どれでもなければエラー
		JSR		READ1		;入力コマンド解釈ポインタ+1
		LBRA		CMT_PRG
*
*「SDIR」処理
SDIR_PRG
		LDA		#$52
		LBSR	SNDBYTE		;Aレジスタのコマンドコードを送信
		LBSR	RCVBYTE		;状態取得(00H=OK)
		TSTA
		LBNE	ERRC

		JSR		READ0		;SDIRの次に文字列があるか?
		BNE		SDIR1		;あればSDIR1へ
		CLRA
		LBSR	SNDBYTE		;継続指示
		LDA		#$01
		LBSR	SNDBYTE		;なければ送信文字列数1文字として終了コード送信へ
		BRA		SDIR3
SDIR1	CMPA	#$22		;次の文字がダブルコーテーションでなかったらエラー
		LBNE	ERRNAME
		CLRA
		LBSR	SNDBYTE		;継続指示
		JSR		GETSTR		;文字列取得
		PSHS	B
		PULS	A
		INCA
		LBSR	SNDBYTE		;文字列数を送信
SDIR2	LDA		,X+
		JSR		AZLCNV		;文字列を1文字取得して大文字に変換
		LBSR	SNDBYTE		;送信
		DECB
		BNE		SDIR2

SDIR3	CLRA
		LBSR	SNDBYTE		;文字列送信終了コード送信

		LBSR	RCVBYTE		;状態取得(00H=OK)
		TSTA
		LBNE	ERRC		;エラー処理へ
		
		CLR		<FILENO
DL1		LDY		#LBUF		;Arduinoから送られてくる文字列を#LBUFへ格納
DL2		LBSR	RCVBYTE
		TSTA
		BEQ		DL3			;$00を受信するまでを一行とする
		CMPA	#$FF
		BEQ		DL4			;$FFを受信したら終了
		CMPA	#$FD
		BEQ		DL9			;$FD受信で文字列を取得してSETLしたことを表示
		CMPA	#$FE
		BEQ		DL5			;$FEを受信したら一時停止して一文字入力待ち
		STA		,Y+
		BRA		DL2
		
DL3
		LDA		#$0D		;$00を受信したら一行分を表示して改行
		STA		,Y+
		LDA		#$0A
		STA		,Y+
		
		CLRA
		STA		,Y+
		LDX		#LBUF
		JSR		LOUT1
DL33	BRA		DL1

DL4		LBSR	RCVBYTE		;状態取得(00H=OK)して終了
		RTS

DL9		LDY		#LBUF		;文字列を取得してSETLしたことを表示
DL91	LBSR	RCVBYTE		;#LBUFへ文字列格納
		STA		,Y+
		TSTA				;$00を受信するまで受信処理
		BNE		DL91
		LDX		#LBUF
		JSR		LOUT1
		LEAX	MSG3,PCR
		JSR		LOUT1		;SETLしたことを表示
		LBSR	RCVBYTE		;状態取得読み飛ばし
		LBSR	RCVBYTE		;状態取得読み飛ばし
		RTS
		
DL5		LEAX	MSGKEY,PCR		;一時停止して一文字入力待ち
		JSR		LOUT1		;HIT ANT KEY表示
DL6		JSR		INPUT1
		CMPA	#$1B
		BEQ		DL7			;ESCで打ち切り
		CMPA	#$30		;数字0～9ならそのままArduinoへ送信してSETL処理へ
		BLO		DL61
		CMPA	#$3A
		BLO		DL8			
DL61	CMPA	#$42
		BEQ		DL8			;「B」で前ページ
		CMPA	#$62
		BEQ		DL62		;「b」で前ページ
		CLRA
		BRA		DL8			;それ以外で継続
DL62	LDA		#$42		;b->B
		BRA		DL8
DL7		LDA		#$FF
DL8		LBSR	SNDBYTE
		BRA		DL2
		
SDIR99	RTS

ERRNAME	PSHS	A
		LDA		#$FF
		LBSR	SNDBYTE		;打ち切り指示
		PULS	A
		TSTA				;$00ならポインタを進めない SETL SETSのみはERROR
		BEQ		ERRNM2
ERRNM1	JSR		READ1		;入力コマンド解釈ポインタ+1
		TSTA
		BNE		ERRNM1
ERRNM2	LDA		#$F5		;NOT DOUBLE QUOTATION表示
		LBRA	ERRC

*「SETL」処理
SETL_PRG
		LDA		#$53
		LBSR	SNDBYTE		;Aレジスタのコマンドコードを送信
		LBSR	RCVBYTE		;状態取得(00H=OK)
		TSTA
		LBNE	ERRC
		JSR		READ0
		CMPA	#$22		;次の文字がダブルコーテーションでなかったらエラー
		BNE		ERRNAME
		CLRA
		LBSR	SNDBYTE		;継続指示
		JSR		GETSTR		;文字列取得
		PSHS	B
		PULS	A
		INCA
		LBSR	SNDBYTE		;文字列数送信

SETL1
		LDA		,X+			;文字列送信
		LBSR	SNDBYTE
		DECB
		BNE		SETL1
		CLRA
		LBSR	SNDBYTE

		LBSR	RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERRC
		
		CLR		<FILENO		;LOAD FILE SET OK!表示
		LEAX	MSG3,PCR
		JSR		LOUT1
		RTS

*「SETS」処理
SETS_PRG
		LDA		#$54
		LBSR	SNDBYTE		;Aレジスタのコマンドコードを送信
		LBSR	RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERRC
		JSR		READ0
		CMPA	#$22		;次の文字がダブルコーテーションでなかったらエラー
		BNE		ERRNAME
		CLRA
		LBSR	SNDBYTE		;継続指示
		JSR		GETSTR		;文字列取得
		PSHS	B
		PULS	A
		INCA
		LBSR	SNDBYTE		;文字列数送信

SETS1
		LDA		,X+			;文字列送信
		LBSR	SNDBYTE
		DECB
		BNE		SETS1
		CLRA
		LBSR	SNDBYTE

		LBSR	RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERRC
		
		CLR		<FILENO		;SAVE FILE SET OK!表示
		LEAX	MSG4,PCR
		JSR		LOUT1
		RTS

*「SDON」処理
SDON_PRG

*BIOS CWRITE CREADフック	;CMTコマンドでBIOSフックをCMTに戻したときにSDへ再度変更する
		LEAX	BIOSR,PCR
		STX		BIOSV+1		;($DF) <- BIOSフック用ルーチンアドレス

		CLR		<FILENO		;SD ON OK!表示
		LEAX	MSG5,PCR
		JSR		LOUT1
		RTS

*「CMT」処理
CMT_PRG

*BIOS CWRITE CREADフック	;変更したBIOSフックを元にもどしてCMTを有効にする
		LDX		#$F17D
		STX		BIOSV+1		;($DF) <- BIOS通常処理へ

		CLR		<FILENO		;CMT ON OK!表示
		LEAX	MSG6,PCR
		JSR		LOUT1
		RTS

ERRC	CLR		<FILENO
		CMPA	#$F0
		BNE		ERR1
		LEAX	ERR_F0,PCR
		BRA		ERRR
ERR1	CMPA	#$F1
		BNE		ERR2
		LEAX	ERR_F1,PCR
		BRA		ERRR
ERR2	CMPA	#$F2
		BNE		ERR3
		LEAX	ERR_F2,PCR
		BRA		ERRR
ERR3	CMPA	#$F4
		BNE		ERR4
		LEAX	ERR_F4,PCR
		BRA		ERRR
ERR4	CMPA	#$F5
		BNE		ERR99
		LEAX	ERR_F5,PCR
		BRA		ERRR

ERR99	LEAX	ERR_F99,PCR

ERRR	JSR		LOUT1
		RTS

*BIOS CWRITE CREADフック
BIOSR	PSHS	U,Y,X,DP,D,CC
		LDB		,X				;B <- RQNO
		CMPB	#1
		BEQ		BIOSR1
		CMPB	#2				;RQNOが2なら1Byte書出し処理へ
		BEQ		BIOSR2
		CMPB	#3				;RQNOが3なら1Byte読み込み処理へ
		BEQ		BIOSR3
		PULS	CC,D,DP,X,Y,U
		JMP		[RETADD]		;以外なら本来のBIOS処理継続

BIOSR1	LBRA	MOTOR
BIOSR2	LBRA	WRITE1BYTE
BIOSR3	LBRA	READ1BYTE

MSG1	FCC		/FM-7_SD READY OK!/
		FCB		$0D,$0A,$00

MSG3	FCC		/LOAD FILE SET OK!/
		FCB		$0D,$0A,$00

MSG4	FCC		/SAVE FILE SET OK!/
		FCB		$0D,$0A,$00

MSG5	FCC		/SD ON OK!/
		FCB		$0D,$0A,$00

MSG6	FCC		/CMT ON OK!/
		FCB		$0D,$0A,$00

MSGKEY	FCC		/SELECT:0-9 NEXT:ANY BACK:B BREAK:ESC/
		FCB		$0D,$0A,$00

ERR_F0	FCC		/SD CARD INITIATE ERROR/
		FCB		$0D,$0A,$00

ERR_F1	FCC		/FILE NOT FOUND/
		FCB		$0D,$0A,$00

ERR_F2	FCC		/FILE OPEN ERROR/
		FCB		$0D,$0A,$00

ERR_F4	FCC		/CMD ERROR/
		FCB		$0D,$0A,$00

ERR_F5	FCC		/NOT DOUBLE QUOTATION/
		FCB		$0D,$0A,$00

ERR_F99	FCC		/UNKNOWN ERROR/
		FCB		$0D,$0A,$00


MOTOR
		LDA		2,X			;BIOS[01] モーター制御
		CMPA	#$FF
		BEQ		MOTORON		;$FFならMOTOR ON、違うならMOTOR OFF
		
MOTOROFF
		LDA		#$59
		LBSR	SNDBYTE		;Aレジスタのコマンドコードを送信
		BSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR
		BRA		RET1

MOTORON
		LDA		#$58
		LBSR	SNDBYTE		;Aレジスタのコマンドコードを送信
		BSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR
		BRA		RET1

*WRITE1BYTE					;BIOS[02] SD-CARDへ1Byte書き込み
WRITE1BYTE
		LDA		#$57
		BSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		BSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR
		
		LDA		2,X
		BSR		SNDBYTE		;1Byte送信

RET1	PULS	CC,D,DP,X,Y,U	;BIOS正常終了
		CLR		1,X
		RTS

ERR11	CLR		<$00BF			;BIOS異常終了
		LEAX	ERR_F6,PCR
		JSR		LOUT1			;MOTOR ON、READ1BYTEでFILEOPENされていなかったときにメッセージを表示

ERR		PULS	CC,D,DP,X,Y,U
		LDA		#$52
		STA		1,X				;エラーコードとキャリーをセットして終了、ただしF-BASIC側ではエラー処理なし
		ORCC	#$01
		RTS

ERR_F6	FCC		/READ FILE IS NOT SET or FILE END/
		FCB		$0D,$0A,$00

*READ1BYTE					;BIOS[03] SD-CARDから1Byte読み込み
READ1BYTE
		LDA		#$56
		BSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		BSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR11
		
		BSR		RCVBYTE
		STA		2,X			;受信した1Byteをセットして終了
		BRA		RET1

**** BUSYをCHECK(1) ****
;PORTC BIT7が1になるまでLOOP
F1CHK	LDA		PIOC
		ANDA	#$80		;PORTC BIT7 = 1?
		BEQ		F1CHK
		RTS

**** BUSYをCHECK(0) ****
;PORTC BIT7が0になるまでLOOP
F2CHK	LDA		PIOC
		ANDA	#$80		;PORTC BIT7 = 0?
		BNE		F2CHK
		RTS

**** 1BYTE受信****
*受信データをアキュムレータAにセットしてリターン
RCVBYTE	BSR		F1CHK		;PORTC BIT7が1になるまでLOOP
		LDA		PIOB		;PORTB -> A
		PSHS	A
		LDA		#$05
		STA		PIOR		;PORTC BIT2 <- 1
		BSR		F2CHK		;PORTC BIT7が0になるまでLOOP
		LDA		#$04
		STA		PIOR		;PORTC BIT2 <- 0
		PULS	A
		RTS

**** 1BYTE送信 ****
*アキュムレータAの内容をPORTA下位4BITに4BITずつ送信
SNDBYTE
		PSHS	A
		LSRA
		LSRA
		LSRA
		LSRA
		ANDA	#$0F
		BSR		SND4BIT
		PULS	A
		ANDA	#$0F
		BSR		SND4BIT
		RTS

**** 4BIT送信 ****
*アキュムレータA下位4ビットを送信する
SND4BIT
		STA		PIOA
		LDA		#$05
		STA		PIOR			;PORTC BIT2 <- 1
		BSR		F1CHK			;PORTC BIT7が1になるまでLOOP
		LDA		#$04
		STA		PIOR			;PORTC BIT2 <- 0
		BSR		F2CHK
		RTS

*新拡張コマンドTBL
NEWTBL	RMB		64
TBLEND
		FCC		/END/		;NEWTBL領域の終わり位置、RMBだけだとコードが生成されないので一応
		END
