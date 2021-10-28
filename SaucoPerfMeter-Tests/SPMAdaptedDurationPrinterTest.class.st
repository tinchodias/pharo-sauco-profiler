"
A SPMAdaptedDurationPrinterTest is a test class for testing the behavior of SPMAdaptedDurationPrinter
"
Class {
	#name : #SPMAdaptedDurationPrinterTest,
	#superclass : #SPMDurationPrinterTest,
	#instVars : [
		'printer'
	],
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #running }
SPMAdaptedDurationPrinterTest >> printerClass [
	"Answer the class of the printer being tested."

	^ SPMAdaptedDurationPrinter
]

{ #category : #test }
SPMAdaptedDurationPrinterTest >> testPrintMicroSeconds [

	self assertPrinting: 1000 nanoSeconds equals: '1us'.
	self assertPrinting: 10000 nanoSeconds equals: '10us'.
	self assertPrinting: 100000 nanoSeconds equals: '100us'.
	self assertPrinting: 999999 nanoSeconds equals: '999us'.
]

{ #category : #test }
SPMAdaptedDurationPrinterTest >> testPrintMilliSeconds [

	self assertPrinting: 1000000 nanoSeconds equals: '1ms'.
	self assertPrinting: 10000000 nanoSeconds equals: '10ms'.
	self assertPrinting: 100000000 nanoSeconds equals: '100ms'.
	self assertPrinting: 999999999 nanoSeconds equals: '999ms'.
]

{ #category : #test }
SPMAdaptedDurationPrinterTest >> testPrintMinutess [

	self assertPrinting: 60000000000 nanoSeconds equals: '1m'.
	self assertPrinting: 1 minute equals: '1m'.
	self assertPrinting: 10 minutes equals: '10m'.
	self assertPrinting: 59.99 minutes equals: '59m'.
]

{ #category : #test }
SPMAdaptedDurationPrinterTest >> testPrintNanoSeconds [

	self assertPrinting: 1 nanoSeconds equals: '1ns'.
	self assertPrinting: 10 nanoSeconds equals: '10ns'.
	self assertPrinting: 100 nanoSeconds equals: '100ns'.
	self assertPrinting: 999 nanoSeconds equals: '999ns'.

]

{ #category : #test }
SPMAdaptedDurationPrinterTest >> testPrintSeconds [

	self assertPrinting: 1000000000 nanoSeconds equals: '1s'.
	self assertPrinting: 1 second equals: '1s'.
	self assertPrinting: 10 seconds equals: '10s'.
	self assertPrinting: 59.99 seconds equals: '59s'.
]
