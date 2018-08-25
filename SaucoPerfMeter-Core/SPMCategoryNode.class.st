"
I represent a category in the SPMReport.
"
Class {
	#name : #SPMCategoryNode,
	#superclass : #SPMCodeNode,
	#instVars : [
		'behaviorNodes'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SPMCategoryNode >> addBehavior: aBehaviorNode [
	behaviorNodes add: aBehaviorNode
]

{ #category : #accessing }
SPMCategoryNode >> behaviorNodes [
	^ behaviorNodes
]

{ #category : #accessing }
SPMCategoryNode >> behaviorNodes: anObject [
	behaviorNodes := anObject
]

{ #category : #accessing }
SPMCategoryNode >> calculatedNetTally [
	^ behaviorNodes inject: 0 into: [ :sum :each | sum + each netTally ]
]

{ #category : #accessing }
SPMCategoryNode >> children [
	^ behaviorNodes
]

{ #category : #accessing }
SPMCategoryNode >> fullName [
	^ name
]

{ #category : #initialization }
SPMCategoryNode >> initialize [
	super initialize.
	behaviorNodes := OrderedCollection new
]
