"
A SPMTallyNodeTest is a test class for testing the behavior of SPMTallyNode
"
Class {
	#name : #SPMTallyNodeTest,
	#superclass : #SPMTest,
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #testing }
SPMTallyNodeTest >> testWithAllChildren [

	self assert: nodeB withAllChildren equals: { 
			nodeBAAA.
			nodeBAA.
			nodeBA.
			nodeB } reversed.
	self assert: nodeBAAA withAllChildren equals: { nodeBAAA }
]

{ #category : #testing }
SPMTallyNodeTest >> testWithAllParents [

	self assert: root withAllParents equals: { root }.
	self assert: nodeB withAllParents equals: { nodeB. root }.
	self assert: nodeBAAA withAllParents equals: { nodeBAAA. nodeBAA. nodeBA. nodeB. root }
]
