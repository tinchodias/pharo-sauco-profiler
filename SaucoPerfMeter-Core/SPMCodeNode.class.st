"
I represent a piece of code in the SPMReport.
"
Class {
	#name : #SPMCodeNode,
	#superclass : #Object,
	#instVars : [
		'name',
		'report',
		'cachedTotalTally'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SPMCodeNode >> calculatedNetTally [
	^ self subclassResponsibility
]

{ #category : #accessing }
SPMCodeNode >> children [
	^ self subclassResponsibility
]

{ #category : #accessing }
SPMCodeNode >> fullName [
	^ self subclassResponsibility
]

{ #category : #testing }
SPMCodeNode >> hasChildren [

	^ self children notEmpty
]

{ #category : #accessing }
SPMCodeNode >> name [
	^ name
]

{ #category : #accessing }
SPMCodeNode >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SPMCodeNode >> netTally [
	^ cachedTotalTally ifNil: [ cachedTotalTally := self calculatedNetTally ]
]

{ #category : #accessing }
SPMCodeNode >> percentage [
	^ 100.0 * self ratio
]

{ #category : #printing }
SPMCodeNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $(;
		nextPutAll: self fullName;
		nextPut: $)
]

{ #category : #accessing }
SPMCodeNode >> ratio [
	^ self netTally asFloat / self report totalTally
]

{ #category : #accessing }
SPMCodeNode >> report [
	^ report
]

{ #category : #accessing }
SPMCodeNode >> report: anObject [
	report := anObject
]

{ #category : #accessing }
SPMCodeNode >> time [
	^ self report totalTime * self ratio
]
