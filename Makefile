# MPLAB IDE generated this makefile for use with GNU make.
# Project: interrupt.mcp
# Date: Wed Oct 01 22:58:30 2014

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

interrupt.cof : main.o
	$(CC) /p18F4520 "main.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"interrupt.cof" /M"interrupt.map" /W

main.o : main.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P18F4520.inc
	$(AS) /q /p18F4520 "main.asm" /l"main.lst" /e"main.err" /o"main.o" /d__DEBUG=1

clean : 
	$(CC) "main.o" "main.err" "main.lst" "interrupt.cof" "interrupt.hex"

