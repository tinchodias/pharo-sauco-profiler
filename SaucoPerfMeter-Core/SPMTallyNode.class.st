"
I represent a tree node in the SPMReport.
"
Class {
	#name : #SPMTallyNode,
	#superclass : #Object,
	#instVars : [
		'methodNode',
		'tally',
		'children',
		'report'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #'instance creation' }
SPMTallyNode class >> report: aSPMReport methodNode: aSPMMethodNode tally: anInteger children: aSPMTallyNode [
	^ self new
		report: aSPMReport;
		methodNode: aSPMMethodNode;
		tally: anInteger;
		children: aSPMTallyNode;
		yourself
]

{ #category : #accessing }
SPMTallyNode >> allBehaviorNodes [
	^ self allMethodNodes collect: [ :each | each behaviorNode ] as: Set
]

{ #category : #accessing }
SPMTallyNode >> allCategoryNodes [
	^ self allBehaviorNodes collect: [ :each | each categoryNode ] as: Set
]

{ #category : #accessing }
SPMTallyNode >> allLeaves [
	^ children ifEmpty: [ {self} ] ifNotEmpty: [ children flatCollect: #allLeaves ]
]

{ #category : #accessing }
SPMTallyNode >> allMethodNodes [
	^ self withAllChildren collect: [ :each | each methodNode ] as: Set
]

{ #category : #accessing }
SPMTallyNode >> children [
	^ children
]

{ #category : #accessing }
SPMTallyNode >> children: aCollection [
	children := aCollection
]

{ #category : #accessing }
SPMTallyNode >> methodNode [
	^ methodNode
]

{ #category : #accessing }
SPMTallyNode >> methodNode: aSPMMethodNode [
	methodNode := aSPMMethodNode
]

{ #category : #accessing }
SPMTallyNode >> netPercentage [
	^ 100.0 * self netRatio
]

{ #category : #accessing }
SPMTallyNode >> netRatio [
	^ self netTally asFloat / self report totalTally
]

{ #category : #accessing }
SPMTallyNode >> netTally [
	^ tally - (children detectSum: #tally)
]

{ #category : #accessing }
SPMTallyNode >> netTime [
	^ self report totalTime * self netRatio
]

{ #category : #accessing }
SPMTallyNode >> percentage [
	^ 100.0 * self ratio
]

{ #category : #printing }
SPMTallyNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		space;
		nextPut: $(.
	SPMConvenience printAbbreviatedDuration: self time on: aStream.
	aStream
		nextPutAll: ' - ';
		nextPutAll: methodNode fullName;
		nextPut: $)
]

{ #category : #accessing }
SPMTallyNode >> ratio [
	^ tally asFloat / self report totalTally
]

{ #category : #accessing }
SPMTallyNode >> report [
	^ report
]

{ #category : #accessing }
SPMTallyNode >> report: aSPMReport [
	report := aSPMReport
]

{ #category : #accessing }
SPMTallyNode >> tally [
	^ tally
]

{ #category : #accessing }
SPMTallyNode >> tally: anInteger [
	tally := anInteger
]

{ #category : #accessing }
SPMTallyNode >> time [
	^ self report totalTime * self ratio
]

{ #category : #accessing }
SPMTallyNode >> withAllChildren [
	^ {self}, (children flatCollect: #withAllChildren)
]
