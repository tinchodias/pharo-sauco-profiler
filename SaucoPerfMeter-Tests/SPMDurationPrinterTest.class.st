"
A SPMDurationPrinterTest is a test class for testing the behavior of SPMDurationPrinter
"
Class {
	#name : #SPMDurationPrinterTest,
	#superclass : #TestCase,
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #test }
SPMDurationPrinterTest >> assertPrinting: aDuration equals: aString [

	| output |
	output := printer print: aDuration.
	self assert: output equals: aString
]

{ #category : #running }
SPMDurationPrinterTest >> printerClass [
	"Answer the class of the printer being tested."

	^ self subclassResponsibility
]

{ #category : #running }
SPMDurationPrinterTest >> setUp [
	super setUp.
	
	printer := self printerClass new
]
