EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GNDD #PWR05
U 1 1 5DE6F2DF
P 5950 4400
F 0 "#PWR05" H 5950 4150 50  0001 C CNN
F 1 "GNDD" H 5954 4245 50  0000 C CNN
F 2 "" H 5950 4400 50  0001 C CNN
F 3 "" H 5950 4400 50  0001 C CNN
	1    5950 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R2
U 1 1 5DE8C4EE
P 4200 2850
F 0 "R2" V 4400 2800 50  0000 C CNN
F 1 "10k" V 4300 2850 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P15.24mm_Horizontal" H 4200 2850 50  0001 C CNN
F 3 "~" H 4200 2850 50  0001 C CNN
	1    4200 2850
	0    1    1    0   
$EndComp
$Comp
L power:GNDD #PWR03
U 1 1 5DE8FF2C
P 3950 3000
F 0 "#PWR03" H 3950 2750 50  0001 C CNN
F 1 "GNDD" H 3954 2845 50  0000 C CNN
F 2 "" H 3950 3000 50  0001 C CNN
F 3 "" H 3950 3000 50  0001 C CNN
	1    3950 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 2850 3950 2850
Wire Wire Line
	3950 2850 3950 3000
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5DE94C52
P 7800 1900
F 0 "#FLG0101" H 7800 1975 50  0001 C CNN
F 1 "PWR_FLAG" H 7800 2073 50  0000 C CNN
F 2 "" H 7800 1900 50  0001 C CNN
F 3 "~" H 7800 1900 50  0001 C CNN
	1    7800 1900
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5DE95686
P 8900 1900
F 0 "#FLG0104" H 8900 1975 50  0001 C CNN
F 1 "PWR_FLAG" H 8900 2150 50  0000 C CNN
F 2 "" H 8900 1900 50  0001 C CNN
F 3 "~" H 8900 1900 50  0001 C CNN
	1    8900 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR0101
U 1 1 5DE95977
P 7800 2050
F 0 "#PWR0101" H 7800 1800 50  0001 C CNN
F 1 "GNDD" H 7804 1895 50  0000 C CNN
F 2 "" H 7800 2050 50  0001 C CNN
F 3 "" H 7800 2050 50  0001 C CNN
	1    7800 2050
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR0104
U 1 1 5DE96AE6
P 8900 2150
F 0 "#PWR0104" H 8900 2000 50  0001 C CNN
F 1 "+5P" H 8915 2323 50  0000 C CNN
F 2 "" H 8900 2150 50  0001 C CNN
F 3 "" H 8900 2150 50  0001 C CNN
	1    8900 2150
	-1   0    0    1   
$EndComp
Wire Wire Line
	8900 1900 8900 2150
$Comp
L PICAXE:PICAXEM2 U1
U 1 1 6172F397
P 5950 2950
F 0 "U1" H 5950 3031 50  0000 C CNN
F 1 "PICAXEM2" H 5950 2940 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 5950 2950 50  0001 C CNN
F 3 "" H 5950 2950 50  0001 C CNN
	1    5950 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4050 5950 4200
Wire Wire Line
	6250 3050 5950 3050
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 6174466F
P 3200 3500
F 0 "J1" H 3118 3175 50  0000 C CNN
F 1 "Conn_01x03" H 3118 3266 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 3200 3500 50  0001 C CNN
F 3 "~" H 3200 3500 50  0001 C CNN
	1    3200 3500
	-1   0    0    1   
$EndComp
$Comp
L Transistor_FET:2N7000 Q1
U 1 1 6174AC5A
P 4350 4100
F 0 "Q1" H 4556 4146 50  0000 L CNN
F 1 "2N7000" H 4556 4055 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 4550 4025 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7000.pdf" H 4350 4100 50  0001 L CNN
	1    4350 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 3350 5250 3350
Wire Wire Line
	4900 2850 4900 3350
$Comp
L power:GNDD #PWR0102
U 1 1 61754125
P 3550 3800
F 0 "#PWR0102" H 3550 3550 50  0001 C CNN
F 1 "GNDD" H 3554 3645 50  0000 C CNN
F 2 "" H 3550 3800 50  0001 C CNN
F 3 "" H 3550 3800 50  0001 C CNN
	1    3550 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR0103
U 1 1 61754A38
P 7300 3900
F 0 "#PWR0103" H 7300 3650 50  0001 C CNN
F 1 "GNDD" H 7304 3745 50  0000 C CNN
F 2 "" H 7300 3900 50  0001 C CNN
F 3 "" H 7300 3900 50  0001 C CNN
	1    7300 3900
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 61755B63
P 8500 3400
F 0 "J3" H 8580 3392 50  0000 L CNN
F 1 "Conn_01x04" H 8580 3301 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 8500 3400 50  0001 C CNN
F 3 "~" H 8500 3400 50  0001 C CNN
	1    8500 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR0105
U 1 1 6175652D
P 8050 3050
F 0 "#PWR0105" H 8050 2900 50  0001 C CNN
F 1 "+5P" H 8065 3223 50  0000 C CNN
F 2 "" H 8050 3050 50  0001 C CNN
F 3 "" H 8050 3050 50  0001 C CNN
	1    8050 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 3800 3550 3600
Wire Wire Line
	3550 3600 3400 3600
Wire Wire Line
	8300 3600 7300 3600
Wire Wire Line
	7300 3600 7300 3900
Wire Wire Line
	8300 3300 8050 3300
Wire Wire Line
	8050 3300 8050 3050
$Comp
L power:GNDD #PWR0106
U 1 1 6175F7C3
P 4450 4650
F 0 "#PWR0106" H 4450 4400 50  0001 C CNN
F 1 "GNDD" H 4454 4495 50  0000 C CNN
F 2 "" H 4450 4650 50  0001 C CNN
F 3 "" H 4450 4650 50  0001 C CNN
	1    4450 4650
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR0107
U 1 1 6175FF0E
P 4450 3300
F 0 "#PWR0107" H 4450 3150 50  0001 C CNN
F 1 "+5P" H 4465 3473 50  0000 C CNN
F 2 "" H 4450 3300 50  0001 C CNN
F 3 "" H 4450 3300 50  0001 C CNN
	1    4450 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R1
U 1 1 6176291C
P 4450 3600
F 0 "R1" V 4650 3550 50  0000 C CNN
F 1 "10k" V 4550 3600 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P15.24mm_Horizontal" H 4450 3600 50  0001 C CNN
F 3 "~" H 4450 3600 50  0001 C CNN
	1    4450 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	4450 4300 4450 4650
Wire Wire Line
	4450 3700 4450 3850
Wire Wire Line
	4450 3300 4450 3500
Wire Wire Line
	6650 3500 6850 3500
Wire Wire Line
	6850 3500 6850 4950
Wire Wire Line
	5050 4950 5050 3850
Wire Wire Line
	5050 3850 4450 3850
Connection ~ 4450 3850
Wire Wire Line
	4450 3850 4450 3900
Wire Wire Line
	7300 3350 7300 3500
Wire Wire Line
	7300 3500 8300 3500
Wire Wire Line
	8300 3400 7500 3400
Wire Wire Line
	3700 2300 3700 3400
Wire Wire Line
	3700 3400 3400 3400
$Comp
L power:+5P #PWR06
U 1 1 5DE6DFB6
P 6250 2750
F 0 "#PWR06" H 6250 2600 50  0001 C CNN
F 1 "+5P" H 6265 2923 50  0000 C CNN
F 2 "" H 6250 2750 50  0001 C CNN
F 3 "" H 6250 2750 50  0001 C CNN
	1    6250 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2850 4900 2850
Wire Wire Line
	7800 1900 7800 2050
$Comp
L Device:R_Small_US R3
U 1 1 61769851
P 5850 4950
F 0 "R3" V 6050 4900 50  0000 C CNN
F 1 "10k" V 5950 4950 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P15.24mm_Horizontal" H 5850 4950 50  0001 C CNN
F 3 "~" H 5850 4950 50  0001 C CNN
	1    5850 4950
	0    1    1    0   
$EndComp
Wire Wire Line
	5050 4950 5750 4950
Wire Wire Line
	5950 4950 6850 4950
Wire Wire Line
	3400 3500 4000 3500
Wire Wire Line
	4000 4100 4150 4100
Wire Wire Line
	4000 3500 4000 4100
$Comp
L power:+5P #PWR0108
U 1 1 6175513A
P 3600 4400
F 0 "#PWR0108" H 3600 4250 50  0001 C CNN
F 1 "+5P" H 3615 4573 50  0000 C CNN
F 2 "" H 3600 4400 50  0001 C CNN
F 3 "" H 3600 4400 50  0001 C CNN
	1    3600 4400
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 617470D3
P 3200 4750
F 0 "J2" H 3118 4425 50  0000 C CNN
F 1 "Conn_01x02" H 3118 4516 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Wuerth_6941xx301002" H 3200 4750 50  0001 C CNN
F 3 "~" H 3200 4750 50  0001 C CNN
	1    3200 4750
	-1   0    0    1   
$EndComp
$Comp
L power:GNDD #PWR0109
U 1 1 6174521D
P 3500 4900
F 0 "#PWR0109" H 3500 4650 50  0001 C CNN
F 1 "GNDD" H 3504 4745 50  0000 C CNN
F 2 "" H 3500 4900 50  0001 C CNN
F 3 "" H 3500 4900 50  0001 C CNN
	1    3500 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 3400 7500 2300
Wire Wire Line
	3700 2300 7500 2300
Wire Wire Line
	6250 2750 6250 3050
NoConn ~ 5250 3650
NoConn ~ 6650 3650
NoConn ~ 5250 3500
$Comp
L Device:R_Small_US R4
U 1 1 6177EB51
P 7150 3350
F 0 "R4" V 7350 3300 50  0000 C CNN
F 1 "10k" V 7250 3350 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P15.24mm_Horizontal" H 7150 3350 50  0001 C CNN
F 3 "~" H 7150 3350 50  0001 C CNN
	1    7150 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	7250 3350 7300 3350
Wire Wire Line
	6650 3350 7050 3350
$Comp
L Device:C_Small C2
U 1 1 61781CDD
P 6300 4200
F 0 "C2" V 6071 4200 50  0000 C CNN
F 1 "100nF" V 6162 4200 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D7.5mm_W5.0mm_P10.00mm" H 6300 4200 50  0001 C CNN
F 3 "~" H 6300 4200 50  0001 C CNN
	1    6300 4200
	0    1    1    0   
$EndComp
$Comp
L Device:CP C1
U 1 1 617830B4
P 3850 4700
F 0 "C1" H 3968 4746 50  0000 L CNN
F 1 "100uF" H 3968 4655 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P7.50mm" H 3888 4550 50  0001 C CNN
F 3 "~" H 3850 4700 50  0001 C CNN
	1    3850 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 4850 3850 4850
Connection ~ 3500 4850
Wire Wire Line
	3500 4850 3500 4900
Wire Wire Line
	3850 4550 3600 4550
Connection ~ 3600 4550
Wire Wire Line
	3600 4550 3600 4400
Wire Wire Line
	6200 4200 5950 4200
Connection ~ 5950 4200
Wire Wire Line
	5950 4200 5950 4400
Wire Wire Line
	6400 4200 6750 4200
Wire Wire Line
	6750 4200 6750 3050
Wire Wire Line
	6750 3050 6250 3050
Connection ~ 6250 3050
Wire Wire Line
	3400 4650 3500 4650
Wire Wire Line
	3500 4650 3500 4850
Wire Wire Line
	3400 4750 3600 4750
Wire Wire Line
	3600 4550 3600 4750
$EndSCHEMATC
