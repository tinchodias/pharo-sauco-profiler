"
I represent a method in the SPMReport.
"
Class {
	#name : #SPMMethodNode,
	#superclass : #SPMCodeNode,
	#instVars : [
		'behaviorNode',
		'tallyNodes'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SPMMethodNode >> behaviorName [
	^ behaviorNode name
]

{ #category : #accessing }
SPMMethodNode >> behaviorNode [
	^ behaviorNode
]

{ #category : #accessing }
SPMMethodNode >> behaviorNode: anObject [
	behaviorNode := anObject
]

{ #category : #accessing }
SPMMethodNode >> calculatedNetTally [
	^ tallyNodes inject: 0 into: [ :sum :each | sum + each netTally ]
]

{ #category : #accessing }
SPMMethodNode >> categoryName [
	^ behaviorNode categoryName
]

{ #category : #accessing }
SPMMethodNode >> children [
	^ #()
]

{ #category : #accessing }
SPMMethodNode >> compiledMethodInCurrentImageIfPresent: presentBlock ifAbsent: absentBlock [
	(self class environment classOrTraitNamed: self behaviorName)
		ifNotNil: [ :behavior | 
			behavior 
				compiledMethodAt: name asSymbol 
				ifPresent: [ :method | ^ presentBlock value: method ] 
				ifAbsent: [  ] ].
	^ absentBlock value
]

{ #category : #accessing }
SPMMethodNode >> fullName [
	^ self behaviorName, '>>', name
]

{ #category : #initialization }
SPMMethodNode >> initialize [
	super initialize.
	tallyNodes := OrderedCollection new
]

{ #category : #accessing }
SPMMethodNode >> tallyNodes [
	^ tallyNodes
]

{ #category : #accessing }
SPMMethodNode >> tallyNodes: anObject [
	tallyNodes := anObject
]
