EESchema Schematic File Version 4
LIBS:backplane-cache
EELAYER 29 0
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
L power:GND #PWR0101
U 1 1 5CD9D487
P 5550 5050
F 0 "#PWR0101" H 5550 4800 50  0001 C CNN
F 1 "GND" H 5555 4877 50  0000 C CNN
F 2 "" H 5550 5050 50  0001 C CNN
F 3 "" H 5550 5050 50  0001 C CNN
	1    5550 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 5050 5550 5050
Connection ~ 5550 5050
Wire Wire Line
	5600 4950 5600 5050
Wire Wire Line
	5550 4950 5600 4950
Wire Wire Line
	5550 5050 5550 4950
Text Label 5600 4950 0    50   ~ 0
GND
Text GLabel 5550 5000 0    50   Input ~ 0
GND
$EndSCHEMATC
