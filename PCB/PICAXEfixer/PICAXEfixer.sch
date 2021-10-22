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
Wire Wire Line
	5950 2750 5950 2500
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
F 2 "Resistor_THT:R_Axial_DIN0922_L20.0mm_D9.0mm_P25.40mm_Horizontal" H 4200 2850 50  0001 C CNN
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
P 8800 1050
F 0 "#FLG0101" H 8800 1125 50  0001 C CNN
F 1 "PWR_FLAG" H 8800 1223 50  0000 C CNN
F 2 "" H 8800 1050 50  0001 C CNN
F 3 "~" H 8800 1050 50  0001 C CNN
	1    8800 1050
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 5DE95686
P 9900 1050
F 0 "#FLG0104" H 9900 1125 50  0001 C CNN
F 1 "PWR_FLAG" H 9900 1300 50  0000 C CNN
F 2 "" H 9900 1050 50  0001 C CNN
F 3 "~" H 9900 1050 50  0001 C CNN
	1    9900 1050
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR0101
U 1 1 5DE95977
P 8800 1200
F 0 "#PWR0101" H 8800 950 50  0001 C CNN
F 1 "GNDD" H 8804 1045 50  0000 C CNN
F 2 "" H 8800 1200 50  0001 C CNN
F 3 "" H 8800 1200 50  0001 C CNN
	1    8800 1200
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR0104
U 1 1 5DE96AE6
P 9900 1300
F 0 "#PWR0104" H 9900 1150 50  0001 C CNN
F 1 "+5P" H 9915 1473 50  0000 C CNN
F 2 "" H 9900 1300 50  0001 C CNN
F 3 "" H 9900 1300 50  0001 C CNN
	1    9900 1300
	-1   0    0    1   
$EndComp
Wire Wire Line
	9900 1050 9900 1300
$Comp
L PICAXE:PICAXEM2 U1
U 1 1 6172F397
P 5950 2950
F 0 "U1" H 5950 3031 50  0000 C CNN
F 1 "PICAXEM2" H 5950 2940 50  0000 C CNN
F 2 "" H 5950 2950 50  0001 C CNN
F 3 "" H 5950 2950 50  0001 C CNN
	1    5950 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4050 5950 4400
Wire Wire Line
	5950 2500 6250 2500
Wire Wire Line
	6250 2500 6250 3050
Wire Wire Line
	6250 3050 5950 3050
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 6174466F
P 3200 3500
F 0 "J1" H 3118 3175 50  0000 C CNN
F 1 "Conn_01x03" H 3118 3266 50  0000 C CNN
F 2 "" H 3200 3500 50  0001 C CNN
F 3 "~" H 3200 3500 50  0001 C CNN
	1    3200 3500
	-1   0    0    1   
$EndComp
$Comp
L power:GNDD #PWR?
U 1 1 6174521D
P 3650 4750
F 0 "#PWR?" H 3650 4500 50  0001 C CNN
F 1 "GNDD" H 3654 4595 50  0000 C CNN
F 2 "" H 3650 4750 50  0001 C CNN
F 3 "" H 3650 4750 50  0001 C CNN
	1    3650 4750
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 617470D3
P 3350 4600
F 0 "J2" H 3268 4275 50  0000 C CNN
F 1 "Conn_01x02" H 3268 4366 50  0000 C CNN
F 2 "" H 3350 4600 50  0001 C CNN
F 3 "~" H 3350 4600 50  0001 C CNN
	1    3350 4600
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
L power:GNDD #PWR?
U 1 1 61754125
P 3550 3800
F 0 "#PWR?" H 3550 3550 50  0001 C CNN
F 1 "GNDD" H 3554 3645 50  0000 C CNN
F 2 "" H 3550 3800 50  0001 C CNN
F 3 "" H 3550 3800 50  0001 C CNN
	1    3550 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR?
U 1 1 61754A38
P 7300 3900
F 0 "#PWR?" H 7300 3650 50  0001 C CNN
F 1 "GNDD" H 7304 3745 50  0000 C CNN
F 2 "" H 7300 3900 50  0001 C CNN
F 3 "" H 7300 3900 50  0001 C CNN
	1    7300 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR?
U 1 1 6175513A
P 3750 4250
F 0 "#PWR?" H 3750 4100 50  0001 C CNN
F 1 "+5P" H 3765 4423 50  0000 C CNN
F 2 "" H 3750 4250 50  0001 C CNN
F 3 "" H 3750 4250 50  0001 C CNN
	1    3750 4250
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 61755B63
P 8500 3400
F 0 "J3" H 8580 3392 50  0000 L CNN
F 1 "Conn_01x04" H 8580 3301 50  0000 L CNN
F 2 "" H 8500 3400 50  0001 C CNN
F 3 "~" H 8500 3400 50  0001 C CNN
	1    8500 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR?
U 1 1 6175652D
P 8050 3050
F 0 "#PWR?" H 8050 2900 50  0001 C CNN
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
	3550 4600 3650 4600
Wire Wire Line
	3650 4600 3650 4750
Wire Wire Line
	3550 4500 3750 4500
Wire Wire Line
	3750 4500 3750 4250
Wire Wire Line
	8300 3600 7300 3600
Wire Wire Line
	7300 3600 7300 3900
Wire Wire Line
	8300 3300 8050 3300
Wire Wire Line
	8050 3300 8050 3050
$Comp
L power:GNDD #PWR?
U 1 1 6175F7C3
P 4450 4650
F 0 "#PWR?" H 4450 4400 50  0001 C CNN
F 1 "GNDD" H 4454 4495 50  0000 C CNN
F 2 "" H 4450 4650 50  0001 C CNN
F 3 "" H 4450 4650 50  0001 C CNN
	1    4450 4650
	1    0    0    -1  
$EndComp
$Comp
L power:+5P #PWR?
U 1 1 6175FF0E
P 4450 3300
F 0 "#PWR?" H 4450 3150 50  0001 C CNN
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
F 2 "Resistor_THT:R_Axial_DIN0922_L20.0mm_D9.0mm_P25.40mm_Horizontal" H 4450 3600 50  0001 C CNN
F 3 "~" H 4450 3600 50  0001 C CNN
	1    4450 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	3400 3500 4000 3500
Wire Wire Line
	4000 3500 4000 4100
Wire Wire Line
	4000 4100 4150 4100
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
	6850 4950 5050 4950
Wire Wire Line
	5050 4950 5050 3850
Wire Wire Line
	5050 3850 4450 3850
Connection ~ 4450 3850
Wire Wire Line
	4450 3850 4450 3900
Wire Wire Line
	6650 3350 7300 3350
Wire Wire Line
	7300 3350 7300 3500
Wire Wire Line
	7300 3500 8300 3500
Wire Wire Line
	8300 3400 7500 3400
Wire Wire Line
	7500 3400 7500 2750
Wire Wire Line
	7500 2750 6450 2750
Wire Wire Line
	6450 2750 6450 2300
Wire Wire Line
	6450 2300 3700 2300
Wire Wire Line
	3700 2300 3700 3400
Wire Wire Line
	3700 3400 3400 3400
$Comp
L power:+5P #PWR06
U 1 1 5DE6DFB6
P 5950 2750
F 0 "#PWR06" H 5950 2600 50  0001 C CNN
F 1 "+5P" H 5965 2923 50  0000 C CNN
F 2 "" H 5950 2750 50  0001 C CNN
F 3 "" H 5950 2750 50  0001 C CNN
	1    5950 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2850 4900 2850
Wire Wire Line
	8800 1050 8800 1200
$EndSCHEMATC