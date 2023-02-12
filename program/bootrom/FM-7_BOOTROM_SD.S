		ORG		$FE00
*
STOPF	EQU		$FD04
RS232D	EQU		$FD06
RS232E	EQU		$FD24
PIOA	EQU		$FDF0
PIOB	EQU		$FDF1
PIOC	EQU		$FDF2
PIOR	EQU		$FDF3
*
TEXTOP	EQU		$0033
NEW2	EQU		$8F39
READY	EQU		$8E72
LOUT1	EQU		$D90F
BSRES	EQU		$FBFC
ROMENT	EQU		$FBFE
BOTSTK	EQU		$FC7F

*
BOTENT	EQU		*
		BRA		STARTS		;STARTへ
*
SDINI	JMP		SDINIT		;SD-CARDから@BOOT_IPL_FM-7.binを読み込み、読み込みサイズに合わせてBASICフリーエリアを再設定後、実行
DWRITE	JMP		SNDBYTE		;Arduinoへ1Byte送信ルーチン
DREAD	JMP		RCVBYTE		;Arduinoから1Byte受信ルーチン
MOT		JMP		MOTOR		;BIOS[01] モーター制御
W1BYTE	JMP		WRITE1BYTE	;BIOS[02] SD-CARDへ1Byte書き込み
R1BYTE	JMP		READ1BYTE	;BIOS[03] SD-CARDから1Byte読み出し

STARTS	EQU		*			;BOOT時処理スタート
		LDA		#$FD
		TFR		A,DP		;DPレジスタを$FDに設定
		LDS		#BOTSTK		;スタックポインタをBOTSTK($FC7F)に設定
		LDB		STOPF
		BITB	#$02		;BREAK KEYチェック
		BNE		DISKV		;押されていなければDISKVへ
		LDX		BSRES		;押されていればインデックスレジスタXにBASICホットスタートアドレス($FBFC)をセット
		BRA		SYSJMP		;SYSJMPへ
*
DISKV	EQU		*
		LDA		PIOA		;FM-7_SD存在チェック
		LSRA
		BCS		NONDSK		;C=1なら接続されていないのでNONDSKへ
*
*最初はここにSDINIT処理を入れようと思っていた名残り
*今は意味はない、修正するのを忘れていた
*
NONDSK	LDX		ROMENT		;インデックスレジスタXにBASICコールドスタートアドレス($FBFE)をセット
SYSJMP	CLRA				;アキュムレータAクリア
		JMP		IUSART		;IUSARTへ
		
MOTOR
		LDA		2,X			;BIOS[01] モーター制御
		CMPA	#$FF
		BEQ		MOTORON		;$FFならMOTOR ON、違うならMOTOR OFF
		
MOTOROFF
		LDA		#$59
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR
		BRA		RET1

MOTORON
		LDA		#$58
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR
		BRA		RET1

*WRITE1BYTE					;BIOS[02] SD-CARDへ1Byte書き込み
WRITE1BYTE
		LDA		#$57
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR
		
		LDA		2,X
		JSR		SNDBYTE		;1Byte送信

RET1	PULS	CC,D,DP,X,Y,U	;BIOS正常終了
		CLR		1,X
		RTS

ERR11	CLR		<$00BF			;BIOS異常終了
		LDX		#ERR_F5
		JSR		LOUT1			;MOTOR ON、READ1BYTEでFILEOPENされていなかったときにメッセージを表示

ERR		PULS	CC,D,DP,X,Y,U
		LDA		#$52
		STA		1,X				;エラーコードとキャリーをセットして終了、ただしF-BASIC側ではエラー処理なし
		ORCC	#$01
		RTS

ERR_F5	FCC		/READ FILE IS NOT SET or FILE END/
		FCB		$0D,$0A,$00

*READ1BYTE					;BIOS[03] SD-CARDから1Byte読み込み
READ1BYTE
		LDA		#$56
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERR11
		
		JSR		RCVBYTE
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

*
*	USART	Initialize	and
*
IUSART	EQU		*			;USART(8251)イニシャライズルーチン
		TFR		A,DP		;DP <- $00
		LDU		#RS232D
		BSR		I8251
		LDU		#RS232E
		LDA		#4
INITLP	BSR		I8251
		LEAU	2,U
		DECA
		BNE		INITLP
		JMP		,X
*
I8251	CLR		1,U
		CLR		1,U
		CLR		1,U
		LDB		#$40
		STB		1,U
		RTS

SDINIT	LDX		TEXTOP		;X <- @BOOT_IPL_FM-7.binの書込先セット
		BSR		PIOINI		;PIO初期化
		LDA		#$50		;ArduinoへSD-CARDから@BOOT_IPL_FM-7.binを読み出して送信するよう指示
		BSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		BSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		INI1		;異常ならそのまま終了
		
		BSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		INI1		;異常ならそのまま終了

		BSR		RCVBYTE		;読み込み上位Byte数受信
		EXG		A,B
		BSR		RCVBYTE		;読み込み下位Byte数受信
		EXG		D,Y			;読み込みByte数をループ回数としてセット

LOP1	BSR		RCVBYTE		;1Byte受信
		STA		0,X			;(X) <- A
		LEAX	1,X			;X <- X+1
		LEAY	-1,Y		;Y <- Y-1
		BNE		LOP1
		LEAX	1,X			;X <- X+1
		PSHS	X
		LDX		TEXTOP
		JSR		,X
		PULS	X

INI1	STX		TEXTOP		;テキストエリア開始位置を再セット
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

		ORG		$FFE0
		
		FCB		$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
		FCB		$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
		FCB		$FE,$00
		
		END		BOTENT
