EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr User 13780 9843
encoding utf-8
Sheet 1 1
Title "FM-7_SD"
Date "2022-01-14"
Rev "Rev1.1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Label 12600 3550 0    50   ~ 0
CS
Text Label 12600 3450 0    50   ~ 0
SCK
Text Label 12600 3350 0    50   ~ 0
MOSI
Text Label 12600 3250 0    50   ~ 0
MISO
Text Label 12600 3150 0    50   ~ 0
+5V
Text Label 12600 3050 0    50   ~ 0
GND
Text Label 11100 2500 0    50   ~ 0
CS
Text Label 11000 2400 0    50   ~ 0
MOSI
Text Label 11000 2300 0    50   ~ 0
MISO
Text Label 11000 2200 0    50   ~ 0
SCK
Wire Wire Line
	12850 3550 12600 3550
Wire Wire Line
	12850 3450 12600 3450
Wire Wire Line
	12850 3350 12600 3350
Wire Wire Line
	12850 3250 12600 3250
Wire Wire Line
	12850 3150 12600 3150
Wire Wire Line
	12850 3050 12600 3050
$Comp
L Connector_Generic:Conn_01x06 J5
U 1 1 62D11F48
P 13050 3250
F 0 "J5" H 13130 3242 50  0000 L CNN
F 1 "MicroSD Card Adapter" H 12450 2800 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 13050 3250 50  0001 C CNN
F 3 "~" H 13050 3250 50  0001 C CNN
	1    13050 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 4300 10050 4300
Wire Wire Line
	9950 2900 9950 4300
Wire Wire Line
	9550 6100 11600 6100
Wire Wire Line
	9550 4500 10050 4500
Wire Wire Line
	9550 4600 10050 4600
Wire Wire Line
	9550 4700 10050 4700
Wire Wire Line
	9550 4800 10050 4800
Wire Wire Line
	9550 4900 10050 4900
Wire Wire Line
	9550 5000 10050 5000
Wire Wire Line
	9550 5100 10050 5100
Wire Wire Line
	9550 5200 10050 5200
Wire Wire Line
	12300 4900 11250 4900
Wire Wire Line
	12300 3200 12300 4900
Wire Wire Line
	10800 3200 12300 3200
Wire Wire Line
	10800 2200 10800 3200
Wire Wire Line
	11400 2200 10800 2200
Wire Wire Line
	12200 5000 11250 5000
Wire Wire Line
	12200 3300 12200 5000
Wire Wire Line
	10900 3300 12200 3300
Wire Wire Line
	10900 2300 10900 3300
Wire Wire Line
	11400 2300 10900 2300
Wire Wire Line
	12100 5100 11250 5100
Wire Wire Line
	12100 3400 12100 5100
Wire Wire Line
	11000 3400 12100 3400
Wire Wire Line
	11000 2400 11000 3400
Wire Wire Line
	11400 2400 11000 2400
Wire Wire Line
	12000 5200 11250 5200
Wire Wire Line
	12000 3500 12000 5200
Wire Wire Line
	11100 3500 12000 3500
Wire Wire Line
	11100 2500 11100 3500
Wire Wire Line
	11400 2500 11100 2500
Wire Wire Line
	9550 3600 11700 3600
Wire Wire Line
	9550 3700 11600 3700
Wire Wire Line
	9550 3800 9900 3800
Wire Wire Line
	9550 3900 9800 3900
$Comp
L Memory_RAM2:Micro_SD_Card_Kit J4
U 1 1 6188B7C4
P 12300 2100
F 0 "J4" H 11800 2800 50  0000 L CNN
F 1 "Micro_SD_Card_Kit" H 12300 2800 50  0000 L CNN
F 2 "FM-7_SD:AE-microSD-LLCNV" H 13450 2400 50  0001 C CNN
F 3 "http://katalog.we-online.de/em/datasheet/693072010801.pdf" H 12300 2100 50  0001 C CNN
	1    12300 2100
	1    0    0    -1  
$EndComp
NoConn ~ 11400 1900
NoConn ~ 11400 2000
NoConn ~ 11400 2600
$Comp
L power:+5V #PWR07
U 1 1 625CD0DA
P 11250 1650
F 0 "#PWR07" H 11250 1500 50  0001 C CNN
F 1 "+5V" H 11265 1823 50  0000 C CNN
F 2 "" H 11250 1650 50  0001 C CNN
F 3 "" H 11250 1650 50  0001 C CNN
	1    11250 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1650 11250 1800
Wire Wire Line
	11250 1800 11400 1800
$Comp
L power:GND #PWR08
U 1 1 625DAB5A
P 11250 2750
F 0 "#PWR08" H 11250 2500 50  0001 C CNN
F 1 "GND" H 11255 2577 50  0000 C CNN
F 2 "" H 11250 2750 50  0001 C CNN
F 3 "" H 11250 2750 50  0001 C CNN
	1    11250 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	11400 2100 11250 2100
Wire Wire Line
	11250 2100 11250 2750
$Comp
L power:GND #PWR06
U 1 1 61B04D1B
P 1500 5250
F 0 "#PWR06" H 1500 5000 50  0001 C CNN
F 1 "GND" H 1505 5077 50  0000 C CNN
F 2 "" H 1500 5250 50  0001 C CNN
F 3 "" H 1500 5250 50  0001 C CNN
	1    1500 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C2
U 1 1 61AFFCD6
P 1500 4800
F 0 "C2" H 1615 4846 50  0000 L CNN
F 1 "100uF" H 1615 4755 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 1500 4800 50  0001 C CNN
F 3 "~" H 1500 4800 50  0001 C CNN
	1    1500 4800
	1    0    0    -1  
$EndComp
Connection ~ 1500 4650
Wire Wire Line
	1500 4650 1800 4650
Wire Wire Line
	1500 4550 1500 4650
$Comp
L power:+5V #PWR05
U 1 1 62901E30
P 1500 4550
F 0 "#PWR05" H 1500 4400 50  0001 C CNN
F 1 "+5V" H 1515 4723 50  0000 C CNN
F 2 "" H 1500 4550 50  0001 C CNN
F 3 "" H 1500 4550 50  0001 C CNN
	1    1500 4550
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 626B92AA
P 1800 4650
F 0 "#FLG01" H 1800 4725 50  0001 C CNN
F 1 "PWR_FLAG" H 1800 4823 50  0000 C CNN
F 2 "" H 1800 4650 50  0001 C CNN
F 3 "~" H 1800 4650 50  0001 C CNN
	1    1800 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	11450 4400 11450 4100
Wire Wire Line
	11250 4400 11450 4400
NoConn ~ 10050 4100
NoConn ~ 10050 4200
NoConn ~ 10050 4400
NoConn ~ 10550 5600
NoConn ~ 10650 5600
NoConn ~ 11250 4300
NoConn ~ 11250 4100
NoConn ~ 9550 6000
NoConn ~ 9550 5900
NoConn ~ 9550 5800
NoConn ~ 9550 5700
NoConn ~ 9550 5500
NoConn ~ 9550 5400
NoConn ~ 9550 4300
NoConn ~ 9550 4200
NoConn ~ 9550 4100
NoConn ~ 9550 4000
$Comp
L power:+5V #PWR010
U 1 1 621E99AD
P 11450 4100
F 0 "#PWR010" H 11450 3950 50  0001 C CNN
F 1 "+5V" H 11465 4273 50  0000 C CNN
F 2 "" H 11450 4100 50  0001 C CNN
F 3 "" H 11450 4100 50  0001 C CNN
	1    11450 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	11350 4200 11350 5400
Wire Wire Line
	11250 4200 11350 4200
$Comp
L power:GND #PWR09
U 1 1 621A9C99
P 11350 5400
F 0 "#PWR09" H 11350 5150 50  0001 C CNN
F 1 "GND" H 11355 5227 50  0000 C CNN
F 2 "" H 11350 5400 50  0001 C CNN
F 3 "" H 11350 5400 50  0001 C CNN
	1    11350 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	10850 5800 10850 5600
Wire Wire Line
	9800 5800 10850 5800
Wire Wire Line
	9800 3900 9800 5800
Wire Wire Line
	10750 5700 10750 5600
Wire Wire Line
	9900 5700 10750 5700
Wire Wire Line
	9900 3800 9900 5700
Wire Wire Line
	11600 4500 11250 4500
Wire Wire Line
	11600 3700 11600 4500
Wire Wire Line
	11700 4600 11250 4600
Wire Wire Line
	11700 3600 11700 4600
Wire Wire Line
	11700 4700 11250 4700
Wire Wire Line
	11700 6200 11700 4700
Wire Wire Line
	9700 6200 11700 6200
Wire Wire Line
	9700 5600 9700 6200
Wire Wire Line
	9550 5600 9700 5600
Wire Wire Line
	11600 4800 11250 4800
Wire Wire Line
	11600 6100 11600 4800
$Comp
L power:+5V #PWR03
U 1 1 61F63930
P 8850 3300
F 0 "#PWR03" H 8850 3150 50  0001 C CNN
F 1 "+5V" H 8865 3473 50  0000 C CNN
F 2 "" H 8850 3300 50  0001 C CNN
F 3 "" H 8850 3300 50  0001 C CNN
	1    8850 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 3300 8850 3300
Wire Wire Line
	8100 6550 8100 3300
Wire Wire Line
	8200 6550 8100 6550
Wire Wire Line
	8850 6500 8850 6550
Wire Wire Line
	8850 6550 8850 6600
Connection ~ 8850 6550
Wire Wire Line
	8500 6550 8850 6550
$Comp
L power:GND #PWR04
U 1 1 61F38F70
P 8850 6600
F 0 "#PWR04" H 8850 6350 50  0001 C CNN
F 1 "GND" H 8855 6427 50  0000 C CNN
F 2 "" H 8850 6600 50  0001 C CNN
F 3 "" H 8850 6600 50  0001 C CNN
	1    8850 6600
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 61F2D5C6
P 8350 6550
F 0 "C1" V 8200 6650 50  0000 C CNN
F 1 "0.1uF" V 8200 6400 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 8388 6400 50  0001 C CNN
F 3 "~" H 8350 6550 50  0001 C CNN
	1    8350 6550
	0    -1   -1   0   
$EndComp
Connection ~ 8850 3300
$Comp
L Interface:8255 U3
U 1 1 618A36EE
P 8850 4900
F 0 "U3" H 8450 6400 50  0000 C CNN
F 1 "8255" H 9250 6400 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm_LongPads" H 8850 5200 50  0001 C CNN
F 3 "http://aturing.umcs.maine.edu/~meadow/courses/cos335/Intel8255A.pdf" H 8850 5200 50  0001 C CNN
	1    8850 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7950 3600 8150 3600
Wire Wire Line
	7950 7000 7950 3600
$Comp
L Arduino:Arduino_Pro_Mini U4
U 1 1 61A254A8
P 10650 4700
F 0 "U4" H 10650 5589 60  0000 C CNN
F 1 "Arduino_Pro_Mini_5V" H 10650 5483 60  0000 C CNN
F 2 "FM-7_SD:Arduino_Pro_Mini" H 11450 3950 60  0001 C CNN
F 3 "https://www.sparkfun.com/products/11113" H 10850 3500 60  0001 C CNN
	1    10650 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 2900 2050 2900
Wire Wire Line
	1800 3000 2050 3000
Wire Wire Line
	1800 3100 2050 3100
Wire Wire Line
	1800 3200 2050 3200
Wire Wire Line
	1800 1900 2050 1900
Wire Wire Line
	1800 2100 2050 2100
Wire Wire Line
	1800 2300 2050 2300
Wire Wire Line
	1800 2500 2050 2500
Wire Wire Line
	1050 4000 1300 4000
Wire Wire Line
	1800 1800 2050 1800
Wire Wire Line
	1050 2800 1300 2800
Wire Wire Line
	1050 3900 1300 3900
Wire Wire Line
	1800 2800 2050 2800
Wire Wire Line
	1050 2900 1300 2900
Wire Wire Line
	1000 3000 1300 3000
Wire Wire Line
	1000 3100 1300 3100
Wire Wire Line
	1000 3200 1300 3200
Wire Wire Line
	1000 3300 1300 3300
Wire Wire Line
	1800 2000 2050 2000
Wire Wire Line
	1800 2200 2050 2200
Wire Wire Line
	1800 2400 2050 2400
Wire Wire Line
	1800 2600 2050 2600
Wire Wire Line
	1000 4100 1300 4100
Wire Wire Line
	1000 1700 1300 1700
Wire Wire Line
	1800 3900 2100 3900
Wire Wire Line
	1800 4000 2100 4000
Wire Wire Line
	1800 4100 2100 4100
Text Label 1900 2900 0    50   ~ 0
AB0
Text Label 1900 3000 0    50   ~ 0
AB2
Text Label 1900 3100 0    50   ~ 0
AB4
Text Label 1900 3200 0    50   ~ 0
AB6
Text Label 1900 1900 0    50   ~ 0
DB0
Text Label 1900 2100 0    50   ~ 0
DB2
Text Label 1900 2300 0    50   ~ 0
DB4
Text Label 1900 2500 0    50   ~ 0
DB6
Text Label 1050 4000 0    50   ~ 0
EQ
Text Label 1800 1800 0    50   ~ 0
EIOCS
Text Label 1050 2800 0    50   ~ 0
ERW
Text Label 1050 3900 0    50   ~ 0
+5V
Text Label 1900 2800 0    50   ~ 0
GND
Text Label 1050 2900 0    50   ~ 0
GND
Text Label 1000 3000 0    50   ~ 0
AB1
Text Label 1000 3100 0    50   ~ 0
AB3
Text Label 1000 3200 0    50   ~ 0
AB5
Text Label 1000 3300 0    50   ~ 0
AB7
Text Label 1900 2000 0    50   ~ 0
DB1
Text Label 1900 2200 0    50   ~ 0
DB3
Text Label 1900 2400 0    50   ~ 0
DB5
Text Label 1900 2600 0    50   ~ 0
DB7
Text Label 1050 4100 0    50   ~ 0
EE
Text Label 1000 1700 0    50   ~ 0
ERESET
Text Label 1950 3900 0    50   ~ 0
+5V
Text Label 1950 4000 0    50   ~ 0
GND
Text Label 1950 4100 0    50   ~ 0
GND
$Comp
L 74xx:74LS04 U1
U 3 1 63BED191
P 3450 5900
F 0 "U1" H 3450 6217 50  0000 C CNN
F 1 "74LS04" H 3450 6126 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 3450 5900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 5900 50  0001 C CNN
	3    3450 5900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 1 1 63BEDCC1
P 3450 4400
F 0 "U1" H 3450 4717 50  0000 C CNN
F 1 "74LS04" H 3450 4626 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 3450 4400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 4400 50  0001 C CNN
	1    3450 4400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 2 1 63BEE86B
P 3450 4900
F 0 "U1" H 3450 5217 50  0000 C CNN
F 1 "74LS04" H 3450 5126 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 3450 4900 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 4900 50  0001 C CNN
	2    3450 4900
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 4 1 63BEF65A
P 3450 6400
F 0 "U1" H 3450 6717 50  0000 C CNN
F 1 "74LS04" H 3450 6626 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 3450 6400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 6400 50  0001 C CNN
	4    3450 6400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 5 1 63BEFFF1
P 7450 7000
F 0 "U1" H 7450 7317 50  0000 C CNN
F 1 "74LS04" H 7450 7226 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 7450 7000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 7450 7000 50  0001 C CNN
	5    7450 7000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS04 U1
U 7 1 63BF0AB6
P 3100 8050
F 0 "U1" H 3330 8096 50  0000 L CNN
F 1 "74LS04" H 3330 8005 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 3100 8050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3100 8050 50  0001 C CNN
	7    3100 8050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS30 U2
U 1 1 63BF1663
P 5000 3150
F 0 "U2" H 5000 3675 50  0000 C CNN
F 1 "74LS30" H 5000 3584 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5000 3150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 5000 3150 50  0001 C CNN
	1    5000 3150
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS30 U2
U 2 1 63BF2FAD
P 4250 8050
F 0 "U2" H 4480 8096 50  0000 L CNN
F 1 "74LS30" H 4480 8005 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4250 8050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS30" H 4250 8050 50  0001 C CNN
	2    4250 8050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 2750 3200 2750
Wire Wire Line
	3800 2750 4500 2750
Wire Wire Line
	4500 2750 4500 3350
Wire Wire Line
	4500 3350 4700 3350
Wire Wire Line
	4100 3400 4100 3150
Wire Wire Line
	4100 3150 4700 3150
Wire Wire Line
	4200 3050 4700 3050
Wire Wire Line
	4300 2950 4700 2950
Wire Wire Line
	2900 4400 3150 4400
Wire Wire Line
	4400 2850 4700 2850
Text Label 2900 2750 0    50   ~ 0
EIOCS
Text Label 2900 3250 0    50   ~ 0
AB7
Text Label 2900 3400 0    50   ~ 0
AB6
Text Label 2900 3550 0    50   ~ 0
AB5
Text Label 2900 3950 0    50   ~ 0
AB4
Text Label 2900 4400 0    50   ~ 0
AB3
$Comp
L 74xx:74LS04 U1
U 6 1 63BEC41D
P 3500 2750
F 0 "U1" H 3500 3067 50  0000 C CNN
F 1 "74LS04" H 3500 2976 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 3500 2750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3500 2750 50  0001 C CNN
	6    3500 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 3250 4700 3250
Wire Wire Line
	2900 3400 4100 3400
Wire Wire Line
	2900 3550 4200 3550
Wire Wire Line
	4200 3550 4200 3050
Wire Wire Line
	3150 4900 2900 4900
Text Label 2900 4900 0    50   ~ 0
AB2
Wire Wire Line
	4300 2950 4300 3950
Wire Wire Line
	4400 2850 4400 4400
Wire Wire Line
	4400 4400 3750 4400
Wire Wire Line
	4700 3450 4500 3450
Wire Wire Line
	4500 3450 4500 4900
Wire Wire Line
	4500 4900 3750 4900
Wire Wire Line
	4700 3550 4600 3550
Wire Wire Line
	4600 3550 4600 2500
$Comp
L power:+5V #PWR01
U 1 1 63C2EF44
P 4600 2500
F 0 "#PWR01" H 4600 2350 50  0001 C CNN
F 1 "+5V" H 4615 2673 50  0000 C CNN
F 2 "" H 4600 2500 50  0001 C CNN
F 3 "" H 4600 2500 50  0001 C CNN
	1    4600 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6850 3150 6850 3900
Wire Wire Line
	6850 3900 8150 3900
Wire Wire Line
	7750 7000 7950 7000
Wire Wire Line
	7150 7000 6950 7000
Wire Wire Line
	6950 7000 6950 2900
Wire Wire Line
	6950 2900 9950 2900
Wire Wire Line
	6950 7000 6250 7000
Connection ~ 6950 7000
Text Label 6250 7000 0    50   ~ 0
ERESET
Wire Wire Line
	8150 4400 6300 4400
Wire Wire Line
	8150 4500 6300 4500
Wire Wire Line
	8150 4800 6300 4800
Wire Wire Line
	8150 4900 6300 4900
Wire Wire Line
	8150 5000 6300 5000
Wire Wire Line
	8150 5100 6300 5100
Wire Wire Line
	8150 5200 6300 5200
Wire Wire Line
	8150 5300 6300 5300
Wire Wire Line
	8150 5400 6300 5400
Wire Wire Line
	8150 5500 6300 5500
Text Label 6300 4500 0    50   ~ 0
AB1
Text Label 6300 4400 0    50   ~ 0
AB0
Text Label 6300 4800 0    50   ~ 0
DB0
Text Label 6300 4900 0    50   ~ 0
DB1
Text Label 6300 5000 0    50   ~ 0
DB2
Text Label 6300 5100 0    50   ~ 0
DB3
Text Label 6300 5200 0    50   ~ 0
DB4
Text Label 6300 5300 0    50   ~ 0
DB5
Text Label 6300 5400 0    50   ~ 0
DB6
Text Label 6300 5500 0    50   ~ 0
DB7
$Comp
L 74xx:74LS00 U5
U 2 1 63E639FF
P 4350 6000
F 0 "U5" H 4350 6325 50  0000 C CNN
F 1 "74LS00" H 4350 6234 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4350 6000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 4350 6000 50  0001 C CNN
	2    4350 6000
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U5
U 4 1 63E66A6A
P 5100 6100
F 0 "U5" H 5100 6425 50  0000 C CNN
F 1 "74LS00" H 5100 6334 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5100 6100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 5100 6100 50  0001 C CNN
	4    5100 6100
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U5
U 3 1 63E68ECE
P 5100 5500
F 0 "U5" H 5100 5825 50  0000 C CNN
F 1 "74LS00" H 5100 5734 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5100 5500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 5100 5500 50  0001 C CNN
	3    5100 5500
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U5
U 1 1 63E6ACEF
P 4350 5400
F 0 "U5" H 4350 5725 50  0000 C CNN
F 1 "74LS00" H 4350 5634 50  0000 C CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 4350 5400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 4350 5400 50  0001 C CNN
	1    4350 5400
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 U5
U 5 1 63E6C791
P 5450 8050
F 0 "U5" H 5680 8096 50  0000 L CNN
F 1 "74LS00" H 5680 8005 50  0000 L CNN
F 2 "Package_DIP:DIP-14_W7.62mm_LongPads" H 5450 8050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 5450 8050 50  0001 C CNN
	5    5450 8050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 5300 3950 5300
Wire Wire Line
	3150 5900 2900 5900
Wire Wire Line
	3150 6400 2900 6400
Wire Wire Line
	4050 5500 3950 5500
Wire Wire Line
	3950 5500 3950 5300
Connection ~ 3950 5300
Wire Wire Line
	3950 5300 3100 5300
Wire Wire Line
	3750 5900 4050 5900
Wire Wire Line
	4050 6100 3900 6100
Wire Wire Line
	3900 6100 3900 6400
Wire Wire Line
	3900 6400 3750 6400
Wire Wire Line
	4650 6000 4700 6000
Wire Wire Line
	3100 5300 3100 6800
Wire Wire Line
	3100 6800 4700 6800
Wire Wire Line
	4700 6800 4700 6200
Wire Wire Line
	4700 6200 4800 6200
Connection ~ 3100 5300
Wire Wire Line
	3100 5300 2900 5300
Wire Wire Line
	4700 6000 4700 5600
Wire Wire Line
	4700 5600 4800 5600
Connection ~ 4700 6000
Wire Wire Line
	4700 6000 4800 6000
Wire Wire Line
	4650 5400 4800 5400
Wire Wire Line
	5400 5500 5600 5500
Wire Wire Line
	5600 5500 5600 4100
Wire Wire Line
	5600 4100 8150 4100
Wire Wire Line
	5400 6100 5700 6100
Wire Wire Line
	5700 6100 5700 4000
Wire Wire Line
	5700 4000 8150 4000
Text Label 2900 5300 0    50   ~ 0
ERW
Text Label 2900 5900 0    50   ~ 0
EQ
Text Label 2900 6400 0    50   ~ 0
EE
Wire Wire Line
	1500 5200 1800 5200
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 63C589D6
P 1800 5200
F 0 "#FLG0101" H 1800 5275 50  0001 C CNN
F 1 "PWR_FLAG" H 1800 5373 50  0000 C CNN
F 2 "" H 1800 5200 50  0001 C CNN
F 3 "~" H 1800 5200 50  0001 C CNN
	1    1800 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 4950 1500 5200
Connection ~ 1500 5200
Wire Wire Line
	1500 5200 1500 5250
$Comp
L Device:C C3
U 1 1 63D59733
P 2700 8000
F 0 "C3" V 2550 8100 50  0000 C CNN
F 1 "0.1uF" V 2550 7850 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 2738 7850 50  0001 C CNN
F 3 "~" H 2700 8000 50  0001 C CNN
	1    2700 8000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 7850 2700 7450
Wire Wire Line
	2700 7450 3100 7450
Wire Wire Line
	3100 7450 3100 7550
Wire Wire Line
	2700 8150 2700 8650
Wire Wire Line
	2700 8650 3100 8650
Wire Wire Line
	3100 8650 3100 8550
$Comp
L Device:C C4
U 1 1 63DBB94D
P 3850 8000
F 0 "C4" V 3700 8100 50  0000 C CNN
F 1 "0.1uF" V 3700 7850 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 3888 7850 50  0001 C CNN
F 3 "~" H 3850 8000 50  0001 C CNN
	1    3850 8000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 7850 3850 7450
Wire Wire Line
	3850 7450 4250 7450
Wire Wire Line
	3850 8150 3850 8650
Wire Wire Line
	3850 8650 4250 8650
$Comp
L Device:C C6
U 1 1 63DD9FF3
P 5050 8000
F 0 "C6" V 4900 8100 50  0000 C CNN
F 1 "0.1uF" V 4900 7850 50  0000 C CNN
F 2 "Capacitor_THT:C_Rect_L4.0mm_W2.5mm_P2.50mm" H 5088 7850 50  0001 C CNN
F 3 "~" H 5050 8000 50  0001 C CNN
	1    5050 8000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 7850 5050 7450
Wire Wire Line
	5050 8150 5050 8650
Wire Wire Line
	5450 7450 5450 7550
Wire Wire Line
	5450 8550 5450 8650
Wire Wire Line
	4250 7450 4250 7550
Wire Wire Line
	4250 8550 4250 8650
Wire Wire Line
	3100 7450 3850 7450
Connection ~ 3100 7450
Connection ~ 3850 7450
Connection ~ 4250 7450
Wire Wire Line
	3100 8650 3850 8650
Connection ~ 3100 8650
Connection ~ 3850 8650
Connection ~ 4250 8650
$Comp
L power:GND #PWR0102
U 1 1 63F23F54
P 2700 8650
F 0 "#PWR0102" H 2700 8400 50  0001 C CNN
F 1 "GND" H 2705 8477 50  0000 C CNN
F 2 "" H 2700 8650 50  0001 C CNN
F 3 "" H 2700 8650 50  0001 C CNN
	1    2700 8650
	1    0    0    -1  
$EndComp
Connection ~ 2700 8650
$Comp
L power:+5V #PWR0103
U 1 1 63F5B3F1
P 2700 7450
F 0 "#PWR0103" H 2700 7300 50  0001 C CNN
F 1 "+5V" H 2715 7623 50  0000 C CNN
F 2 "" H 2700 7450 50  0001 C CNN
F 3 "" H 2700 7450 50  0001 C CNN
	1    2700 7450
	1    0    0    -1  
$EndComp
Connection ~ 2700 7450
Wire Wire Line
	5300 3150 6850 3150
Wire Wire Line
	2900 3950 4300 3950
Wire Wire Line
	4250 7450 5050 7450
Wire Wire Line
	4250 8650 5050 8650
Connection ~ 5050 7450
Wire Wire Line
	5050 7450 5450 7450
Connection ~ 5050 8650
Wire Wire Line
	5050 8650 5450 8650
$Comp
L Connector_Generic:Conn_02x25_Odd_Even J1
U 1 1 63C49484
P 1500 2900
F 0 "J1" H 1550 4317 50  0000 C CNN
F 1 "FM-7_BUS" H 1550 4226 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x25_P2.54mm_Horizontal" H 1500 2900 50  0001 C CNN
F 3 "~" H 1500 2900 50  0001 C CNN
	1    1500 2900
	1    0    0    -1  
$EndComp
NoConn ~ 1800 2700
NoConn ~ 1800 3300
NoConn ~ 1800 3400
NoConn ~ 1800 3500
NoConn ~ 1800 3600
NoConn ~ 1800 3700
NoConn ~ 1800 3800
NoConn ~ 1300 3800
NoConn ~ 1300 3700
NoConn ~ 1300 3600
NoConn ~ 1300 3500
NoConn ~ 1300 3400
NoConn ~ 1300 2700
NoConn ~ 1300 2600
NoConn ~ 1300 2500
NoConn ~ 1300 2400
NoConn ~ 1300 2300
NoConn ~ 1300 2200
NoConn ~ 1300 2100
NoConn ~ 1300 2000
NoConn ~ 1300 1900
NoConn ~ 1300 1800
NoConn ~ 1800 1700
$EndSCHEMATC
