			ORG		$0790
		
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
SNDBYTE		EQU		$FE05	;(BOOTROM)Arduinoへ1Byte送信
RCVBYTE		EQU		$FE08	;(BOOTROM)Arduinoから1Byte受信
MOTOR		EQU		$FE0B	;(BOOTROM)BIOS[01]モーター制御
WRITE1BYTE	EQU		$FE0E	;(BOOTROM)BIOS[02]SD-CARDへ1Byte書き込み
READ1BYTE	EQU		$FE11	;(BOOTROM)BIOS[03]SD-CARDから1Byte読み込み
*
START	
* 拡張コマンドテーブルを#NEWTBLにコピーして拡張コマンド「SDIR」「SETL」「SETS」「SDON」「CMT」を追加
		LDB		EXTNUM		;B <- 拡張コマンド数
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		INC		EXTNUM		;拡張コマンド数+1
		LDX		EXTTBL		;X <- 旧拡張コマンドTBLアドレス
		LDU		#NEWTBL		;U <- 新拡張コマンドTBLアドレス
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

		LDX		#NEWTRN		;追加コマンド判定ルーチンアドレス
		STX		EXTTRN		;拡張コマンド判定後のジャンプ先アドレスポインタを追加コマンド判定ルーチンアドレスに書き換え

*BIOS CWRITE CREADフック
BIOSF	LDX		#BIOSR
		STX		BIOSV+1		;($DF) <- BIOSフック用ルーチンアドレス

*SD関連書き換え終了メッセージ
		CLR		<FILENO			;($00BF) <- 0 画面出力へ設定
		LDX		#MSG1
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
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		LBNE	ERRC

		JSR		READ0		;SDIRの次に文字列があるか?
		BNE		SDIR1		;あればSDIR1へ
		CLRA
		JSR		SNDBYTE		;継続指示
		LDA		#$01
		JSR		SNDBYTE		;なければ送信文字列数1文字として終了コード送信へ
		BRA		SDIR3
SDIR1	CMPA	#$22		;次の文字がダブルコーテーションでなかったらエラー
		LBNE	ERRNAME
		CLRA
		JSR		SNDBYTE		;継続指示
		JSR		GETSTR		;文字列取得
		PSHS	B
		PULS	A
		INCA
		JSR		SNDBYTE		;文字列数を送信
SDIR2	LDA		,X+
		JSR		AZLCNV		;文字列を1文字取得して大文字に変換
		JSR		SNDBYTE		;送信
		DECB
		BNE		SDIR2

SDIR3	CLRA
		JSR		SNDBYTE		;文字列送信終了コード送信

		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		LBNE	ERRC		;エラー処理へ
		
		CLR		<FILENO
DL1		LDY		#LBUF		;Arduinoから送られてくる文字列を#LBUFへ格納
DL2		JSR		RCVBYTE
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

DL4		JSR		RCVBYTE		;状態取得(00H=OK)して終了
		RTS

DL9		LDY		#LBUF		;文字列を取得してSETLしたことを表示
DL91	JSR		RCVBYTE		;#LBUFへ文字列格納
		STA		,Y+
		TSTA				;$00を受信するまで受信処理
		BNE		DL91
		LDX		#LBUF
		JSR		LOUT1
		LDX		#MSG3
		JSR		LOUT1		;SETLしたことを表示
		JSR		RCVBYTE		;状態取得読み飛ばし
		JSR		RCVBYTE		;状態取得読み飛ばし
		RTS
		
DL5		LDX		#MSGKEY		;一時停止して一文字入力待ち
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
DL8		JSR		SNDBYTE
		BRA		DL2
		
SDIR99	RTS

ERRNAME	PSHS	A
		LDA		#$FF
		JSR		SNDBYTE		;打ち切り指示
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
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		LBNE	ERRC
		JSR		READ0
		CMPA	#$22		;次の文字がダブルコーテーションでなかったらエラー
		BNE		ERRNAME
		CLRA
		JSR		SNDBYTE		;継続指示
		JSR		GETSTR		;文字列取得
		PSHS	B
		PULS	A
		INCA
		JSR		SNDBYTE		;文字列数送信

SETL1
		LDA		,X+			;文字列送信
		JSR		SNDBYTE
		DECB
		BNE		SETL1
		CLRA
		JSR		SNDBYTE

		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERRC
		
		CLR		<FILENO		;LOAD FILE SET OK!表示
		LDX		#MSG3
		JSR		LOUT1
		RTS

*「SETS」処理
SETS_PRG
		LDA		#$54
		JSR		SNDBYTE		;Aレジスタのコマンドコードを送信
		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERRC
		JSR		READ0
		CMPA	#$22		;次の文字がダブルコーテーションでなかったらエラー
		BNE		ERRNAME
		CLRA
		JSR		SNDBYTE		;継続指示
		JSR		GETSTR		;文字列取得
		PSHS	B
		PULS	A
		INCA
		JSR		SNDBYTE		;文字列数送信

SETS1
		LDA		,X+			;文字列送信
		JSR		SNDBYTE
		DECB
		BNE		SETS1
		CLRA
		JSR		SNDBYTE

		JSR		RCVBYTE		;状態取得(00H=OK)
		TSTA
		BNE		ERRC
		
		CLR		<FILENO		;SAVE FILE SET OK!表示
		LDX		#MSG4
		JSR		LOUT1
		RTS

*「SDON」処理
SDON_PRG

*BIOS CWRITE CREADフック	;CMTコマンドでBIOSフックをCMTに戻したときにSDへ再度変更する
		LDX		#BIOSR
		STX		BIOSV+1		;($DF) <- BIOSフック用ルーチンアドレス

		CLR		<FILENO		;SD ON OK!表示
		LDX		#MSG5
		JSR		LOUT1
		RTS

*「CMT」処理
CMT_PRG

*BIOS CWRITE CREADフック	;変更したBIOSフックを元にもどしてCMTを有効にする
		LDX		#$F17D
		STX		BIOSV+1		;($DF) <- BIOS通常処理へ

		CLR		<FILENO		;CMT ON OK!表示
		LDX		#MSG6
		JSR		LOUT1
		RTS

ERRC	CLR		<FILENO
		CMPA	#$F0
		BNE		ERR1
		LDX		#ERR_F0
		BRA		ERRR
ERR1	CMPA	#$F1
		BNE		ERR2
		LDX		#ERR_F1
		BRA		ERRR
ERR2	CMPA	#$F2
		BNE		ERR3
		LDX		#ERR_F2
		BRA		ERRR
ERR3	CMPA	#$F4
		BNE		ERR4
		LDX		#ERR_F4
		BRA		ERRR
ERR4	CMPA	#$F5
		BNE		ERR99
		LDX		#ERR_F5
		BRA		ERRR

ERR99	LDX		#ERR_F99

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

BIOSR1	JMP		MOTOR
BIOSR2	JMP		WRITE1BYTE
BIOSR3	JMP		READ1BYTE

MSG1	FCC		/FM-7_SD READY OK!/
		FCB		$0D,$0A,$00

MSG2	FCC		/SDIR TEST/
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

*新拡張コマンドTBL
NEWTBL	RMB		64
		FCC		/EN/

		END
