"
I help to build instances of SPMReport from instances of AndreasSystemProfiler or MessageTally.
"
Class {
	#name : #SPMBuilder,
	#superclass : #Object,
	#instVars : [
		'behaviorNodesMapping',
		'categoryNodesMapping',
		'methodNodesMapping',
		'rootTallyNodes',
		'totalTime',
		'report',
		'totalTally'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #building }
SPMBuilder >> build [
	report
		initializeNodes: rootTallyNodes
		totalTime: totalTime milliSeconds
		totalTally: totalTally
]

{ #category : #initialization }
SPMBuilder >> initialize [
	super initialize.
	categoryNodesMapping := IdentityDictionary new.
	behaviorNodesMapping := IdentityDictionary new.
	methodNodesMapping := IdentityDictionary new.
	report := SPMReport new
]

{ #category : #'registering nodes' }
SPMBuilder >> registerAllCodeNodesFor: method [
	"Ensures that code nodes at all levels are registered."

	self registerCategoryNodeFor: method.
	self registerBehaviorNodeFor: method.
	self registerMethodNodeFor: method
]

{ #category : #'registering nodes' }
SPMBuilder >> registerBehaviorNodeFor: method [
	| behavior |
	behavior := method origin.
	behaviorNodesMapping
		at: behavior
		ifAbsentPut: [ | categoryNode behaviorNode |
			categoryNode := categoryNodesMapping at: behavior category.
			behaviorNode := SPMBehaviorNode new
				name: behavior name asString;
				categoryNode: categoryNode;
				report: report;
				yourself.
			categoryNode addBehavior: behaviorNode.
			behaviorNode ]
]

{ #category : #'registering nodes' }
SPMBuilder >> registerCategoryNodeFor: method [
	| category |
	category := method origin category.
	categoryNodesMapping
		at: category
		ifAbsentPut: [ SPMCategoryNode new
				name: category asString;
				report: report;
				yourself ]
]

{ #category : #'registering nodes' }
SPMBuilder >> registerMethodNodeFor: method [
	methodNodesMapping
		at: method
		ifAbsentPut: [ | behaviorNode methodNode |
			behaviorNode := behaviorNodesMapping at: method origin.
			methodNode := SPMMethodNode new
				name: method selector asString;
				behaviorNode: behaviorNode;
				report: report;
				yourself.
			behaviorNode methodNodes add: methodNode.
			methodNode ]
]

{ #category : #accessing }
SPMBuilder >> report [
	^ report
]

{ #category : #visiting }
SPMBuilder >> tallyNodeFor: aQSystemTally [
	"Answers a new tally node for the argument. Important: It also registers code nodes."

	| childrenTallyNodes methodNode tallyNode |
	"Depth-first"
	childrenTallyNodes := (aQSystemTally sonsOver: 0)
		collect: [ :each | self tallyNodeFor: each ].
	tallyNode := SPMTallyNode new
		tally: aQSystemTally tally;
		children: childrenTallyNodes;
		report: report;
		yourself.
	"Handle root, which is an unreal tally with method = nil: children are the only important in such case."
	aQSystemTally method
		ifNotNil: [ "Ensure existence of category, behavior and method nodes."
			self registerAllCodeNodesFor: aQSystemTally method.
			methodNode := methodNodesMapping at: aQSystemTally method.
			methodNode tallyNodes add: tallyNode.
			tallyNode methodNode: methodNode ].
	^ tallyNode
]

{ #category : #accessing }
SPMBuilder >> tallyRoot: tallyRoot [
	totalTally := tallyRoot tally.
	"For AndreasSystemProfiler, the received root is a nil>>nil so we just keep it's children."
	rootTallyNodes := {(self tallyNodeFor: tallyRoot)}.
	(rootTallyNodes size = 1 and: [ rootTallyNodes anyOne methodNode isNil ])
		ifTrue: [ rootTallyNodes := rootTallyNodes anyOne children ]
]

{ #category : #accessing }
SPMBuilder >> totalTime: aNumber [
	totalTime := aNumber
]
