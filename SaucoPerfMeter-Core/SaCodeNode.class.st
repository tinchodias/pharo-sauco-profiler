"
I represent a piece of code in the SaReport.
"
Class {
	#name : #SaCodeNode,
	#superclass : #Object,
	#instVars : [
		'name',
		'report',
		'cachedTotalTally'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SaCodeNode >> calculatedNetTally [
	^ self subclassResponsibility
]

{ #category : #accessing }
SaCodeNode >> children [
	^ self subclassResponsibility
]

{ #category : #accessing }
SaCodeNode >> codeColor [

	^ report colorMap colorAt: self
]

{ #category : #accessing }
SaCodeNode >> fullName [
	^ self subclassResponsibility
]

{ #category : #testing }
SaCodeNode >> hasChildren [

	^ self children notEmpty
]

{ #category : #testing }
SaCodeNode >> isRelevant [

	^ self ratio >= report minimumRelevantRatio
]

{ #category : #accessing }
SaCodeNode >> name [
	^ name
]

{ #category : #accessing }
SaCodeNode >> name: aString [

	name := aString
]

{ #category : #accessing }
SaCodeNode >> netTally [
	^ cachedTotalTally ifNil: [ cachedTotalTally := self calculatedNetTally ]
]

{ #category : #accessing }
SaCodeNode >> percentage [
	^ 100.0 * self ratio
]

{ #category : #printing }
SaCodeNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $(;
		nextPutAll: self fullName;
		nextPut: $)
]

{ #category : #accessing }
SaCodeNode >> ratio [
	"Answer the tally (or time) ratio of this node respect to report's total."

	^ self netTally asFloat / report totalTally
]

{ #category : #accessing }
SaCodeNode >> report [
	^ report
]

{ #category : #accessing }
SaCodeNode >> report: anObject [
	report := anObject
]

{ #category : #accessing }
SaCodeNode >> time [
	^ self report totalTime * self ratio
]
