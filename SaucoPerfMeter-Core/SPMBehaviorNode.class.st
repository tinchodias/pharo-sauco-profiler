"
I represent a class or trait (instance or class side) in the SPMReport.
"
Class {
	#name : #SPMBehaviorNode,
	#superclass : #SPMCodeNode,
	#instVars : [
		'categoryNode',
		'methodNodes'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SPMBehaviorNode >> addMethod: aMethodNode [
	methodNodes add: aMethodNode
]

{ #category : #accessing }
SPMBehaviorNode >> calculatedNetTally [
	^ methodNodes inject: 0 into: [ :sum :each | sum + each netTally ]
]

{ #category : #accessing }
SPMBehaviorNode >> categoryName [
	^ categoryNode name
]

{ #category : #accessing }
SPMBehaviorNode >> categoryNode [
	^ categoryNode
]

{ #category : #accessing }
SPMBehaviorNode >> categoryNode: anObject [
	categoryNode := anObject
]

{ #category : #accessing }
SPMBehaviorNode >> children [
	^ methodNodes
]

{ #category : #accessing }
SPMBehaviorNode >> fullName [
	^ name
]

{ #category : #initialization }
SPMBehaviorNode >> initialize [
	super initialize.
	methodNodes := OrderedCollection new
]

{ #category : #accessing }
SPMBehaviorNode >> methodNodes [
	^ methodNodes
]

{ #category : #accessing }
SPMBehaviorNode >> methodNodes: anObject [
	methodNodes := anObject
]
