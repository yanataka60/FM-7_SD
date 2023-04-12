PIOA	EQU		$FDF0
PIOB	EQU		$FDF1
PIOC	EQU		$FDF2
PIOR	EQU		$FDF3

		ORG		$7000
		
*
START	
		PSHS	X,Y			;一応X,Yを保存
		LDA		$FFE5		;$FFE5が$00以外ならFDが接続されているのでST1へ
		CMPA	#$00
		BNE		ST1
		LDX		#$FFE8		;SDモードで起動されているなら$FFE8からにEXAS-FM起動コードをコピー
		LEAY	DATA,PCR	;EXAS-FM起動コード
		LDB		#$06
DA1		LDA		,Y+
		STA		,X+
		DECB
		BNE		DA1
		
ST1		BSR		READ1BYTE	;SDから1Byte読み込み
		CMPA	#$16		;EXAS-FMコンパイラ本体最初の$16を読むまで読み飛ばし
		BNE		ST1
		STA		$FD0F		;$8000～裏RAMに切り替え
		LDX		#$9000		;書き込みSTART位置
		CMPA	,X			;既に書き込みがあれば読み出しをスキップして$9000へジャンプ
		BEQ		ST2
		LDY		#$5FFA		;読み込むバイト数
		STA		,X+			;裏RAMへ書き込んでX+1
		LEAY	-1,Y		;読み込むバイト数-1

LP1		BSR		READ1BYTE	;SDから1Byte読み込み
		STA		,X+			;裏RAMへ書き込んでX+1
		LEAY	-1,Y		;読み込むバイト数-1
		BNE		LP1			;読み込むバイト数がゼロになるまでループ
ST2		PULS	X,Y			;終わったらX,Yを戻す。
		JMP		$9000		;裏RAM$9000へジャンプ

READ1BYTE
		LDA		#$56
		BSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		BSR		RCVBYTE		;状態取得(00H=OK)
		BSR		RCVBYTE
		RTS

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

****** EXAS-FM起動コード *********
DATA	STA		$FD0F		;裏RAM切替
		JMP		$9000		;EXAS-FM起動

		END
