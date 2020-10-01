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
		'behaviorP',
		'report'
	],
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #running }
SPMReportTest >> behaviorP [
	^ behaviorP ifNil: [
		behaviorP := SPMBehaviorNode new
				report: report;
				name: 'P';
				categoryNode: self categoryH;
				yourself ]
]

{ #category : #running }
SPMReportTest >> behaviorQ [
	^ behaviorQ ifNil: [
		behaviorQ := SPMBehaviorNode new
				report: report;
				name: 'Q';
				categoryNode: self categoryI;
				yourself ]
]

{ #category : #running }
SPMReportTest >> categoryH [
	^ categoryH ifNil: [
		categoryH := SPMCategoryNode new
				report: report;
				name: 'H';
				yourself ]
]

{ #category : #running }
SPMReportTest >> categoryI [
	^ categoryI ifNil: [
		categoryI := SPMCategoryNode new
				report: report;
				name: 'I';
				yourself ]
]

{ #category : #running }
SPMReportTest >> methodX [
	^ methodX ifNil: [
		methodX := SPMMethodNode new
				report: report;
				name: 'x';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : #running }
SPMReportTest >> methodY [
	^ methodY ifNil: [
		methodY := SPMMethodNode new
				report: report;
				name: 'y';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : #running }
SPMReportTest >> methodZ [
	^ methodZ ifNil: [
		methodZ := SPMMethodNode new
				report: report;
				name: 'z';
				behaviorNode: self behaviorQ;
				yourself ]
]

{ #category : #running }
SPMReportTest >> setUp [
	| root |
	super setUp.
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
	report
		initializeNodes: {root}
		totalTime: 2000 milliSeconds
		totalTally: 1000
]

{ #category : #testing }
SPMReportTest >> testAllBehaviorNodes [
	self
		assert: report allBehaviorNodes asSet
		equals:
			{self behaviorP.
			self behaviorQ} asSet
]

{ #category : #testing }
SPMReportTest >> testAllCategoryNodes [
	self
		assert: report allCategoryNodes asSet
		equals:
			{self categoryH.
			self categoryI} asSet
]

{ #category : #testing }
SPMReportTest >> testAllMethodNodes [
	self
		assert: report allMethodNodes asSet
		equals:
			{self methodX.
			self methodY.
			self methodZ} asSet
]
