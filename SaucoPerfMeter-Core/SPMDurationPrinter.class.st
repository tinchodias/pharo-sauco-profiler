"
I know how to convert a Duration to a String.

"
Class {
	#name : #SPMDurationPrinter,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #printing }
SPMDurationPrinter >> print: aDuration [

	^ String streamContents: [ :stream | 
		  self print: aDuration on: stream ]
]

{ #category : #printing }
SPMDurationPrinter >> print: aDuration on: stream [

	^ self subclassResponsibility
]
