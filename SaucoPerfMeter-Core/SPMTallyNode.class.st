"
I represent a tree node in the SPMReport.

My collaborators are:

	- methodNode: Represents the method that was observed by the profiler, belonging to a context stack. N:1 relation.
	- tally: The number of times this method was observed as part of a context stack.
	- parent: Either nil for root nodes, or another node when I'm a children. See #children:. N:1 relation.
	- children: A collection of other tally nodes. Obviously, I'm a leaf node when it's empty. 1:N relation.
	

"
Class {
	#name : #SPMTallyNode,
	#superclass : #Object,
	#instVars : [
		'methodNode',
		'tally',
		'children',
		'report',
		'parent'
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
SPMTallyNode >> children: aCollectionOfTallyNodes [
	"Set the children nodes. We let parents the responsability of keeping the bi-directional relationshipup-to-date (see #parent:)."

	children ifNotNil: [
		children do: [ :each |
			each parent: nil ] ].

	children := aCollectionOfTallyNodes.

	aCollectionOfTallyNodes do: [ :each |
		each parent: self ].
]

{ #category : #testing }
SPMTallyNode >> hasChildren [

	^ self children notEmpty
]

{ #category : #testing }
SPMTallyNode >> isRelevant [

	^ self ratio >= report minimumRelevantRatio
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
	^ tally - (children sum: #tally)
]

{ #category : #accessing }
SPMTallyNode >> netTime [
	"Answer the net time (respect to children time)."

	^ self report totalTime * self netRatio
]

{ #category : #accessing }
SPMTallyNode >> parent [

	^ parent
]

{ #category : #accessing }
SPMTallyNode >> parent: anotherTallyNodeOrNil [
	"Set the parent. We let parents the responsability of keeping the bi-directional relationship up-to-date (see #children:)."
	
	parent := anotherTallyNodeOrNil
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
	report durationPrinter print: self time on: aStream.
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
	^ report totalTime * self ratio
]

{ #category : #accessing }
SPMTallyNode >> withAllChildren [
	^ {self}, (children flatCollect: #withAllChildren)
]

{ #category : #accessing }
SPMTallyNode >> withAllParents [

	^ parent
		  ifNil: [ { self } ]
		  ifNotNil: [ { self } , parent withAllParents ]
]
