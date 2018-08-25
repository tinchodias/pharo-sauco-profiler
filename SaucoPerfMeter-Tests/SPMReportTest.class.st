Class {
	#name : #SPMReportTest,
	#superclass : #TestCase,
	#instVars : [
		'methodZ',
		'methodY',
		'methodX',
		'categoryI',
		'categoryH',
		'behaviorQ',
		'behaviorP'
	],
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #running }
SPMReportTest >> behaviorP [
	^ behaviorP
		ifNil: [ behaviorP := SPMBehaviorNode new
				name: 'P';
				categoryNode: self categoryH;
				yourself ]
]

{ #category : #running }
SPMReportTest >> behaviorQ [
	^ behaviorQ
		ifNil: [ behaviorQ := SPMBehaviorNode new
				name: 'Q';
				categoryNode: self categoryI;
				yourself ]
]

{ #category : #running }
SPMReportTest >> categoryH [
	^ categoryH
		ifNil: [ categoryH := SPMCategoryNode new
				name: 'H';
				yourself ]
]

{ #category : #running }
SPMReportTest >> categoryI [
	^ categoryI
		ifNil: [ categoryI := SPMCategoryNode new
				name: 'I';
				yourself ]
]

{ #category : #running }
SPMReportTest >> methodX [
	^ methodX
		ifNil: [ methodX := SPMMethodNode new
				name: 'x';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : #running }
SPMReportTest >> methodY [
	^ methodY
		ifNil: [ methodY := SPMMethodNode new
				name: 'y';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : #running }
SPMReportTest >> methodZ [
	^ methodZ
		ifNil: [ methodZ := SPMMethodNode new
				name: 'z';
				behaviorNode: self behaviorQ;
				yourself ]
]

{ #category : #running }
SPMReportTest >> reportA [
	| report root |
	report := SPMReport new.
	root := SPMTallyNode
		report: report
		methodNode: self methodX
		tally: 1000
		children:
			{(SPMTallyNode
				report: report
				methodNode: self methodY
				tally: 600
				children:
					{(SPMTallyNode
						report: report
						methodNode: self methodY
						tally: 600
						children: #())}).
			(SPMTallyNode
				report: report
				methodNode: self methodZ
				tally: 400
				children:
					{(SPMTallyNode
						report: report
						methodNode: self methodZ
						tally: 300
						children:
							{(SPMTallyNode
								report: report
								methodNode: self methodZ
								tally: 200
								children:
									{(SPMTallyNode
										report: report
										methodNode: self methodZ
										tally: 100
										children: #())})})})}.
	^ report
		totalTally: 1000;
		totalTime: 2000 milliSeconds;
		rootTallyNodes: {root};
		yourself
]

{ #category : #testing }
SPMReportTest >> testAllBehaviorNodes [
	| report |
	report := self reportA.
	self
		assert: report allBehaviorNodes asSet
		equals:
			{self behaviorP.
			self behaviorQ} asSet
]

{ #category : #testing }
SPMReportTest >> testAllCategoryNodes [
	| report |
	report := self reportA.
	self
		assert: report allCategoryNodes asSet
		equals:
			{self categoryH.
			self categoryI} asSet
]

{ #category : #testing }
SPMReportTest >> testAllMethodNodes [
	| report |
	report := self reportA.
	self
		assert: report allMethodNodes asSet
		equals:
			{self methodX.
			self methodY.
			self methodZ} asSet
]
