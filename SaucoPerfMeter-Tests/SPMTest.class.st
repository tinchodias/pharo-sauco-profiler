Class {
	#name : #SPMTest,
	#superclass : #TestCase,
	#instVars : [
		'methodZ',
		'methodY',
		'methodX',
		'categoryI',
		'categoryH',
		'behaviorQ',
		'behaviorP',
		'report',
		'root',
		'nodeAA',
		'nodeA',
		'nodeBAAA',
		'nodeBAA',
		'nodeBA',
		'nodeB'
	],
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #testing }
SPMTest class >> isAbstract [

	^ self = SPMTest
]

{ #category : #running }
SPMTest >> behaviorP [
	^ behaviorP ifNil: [
		behaviorP := SPMBehaviorNode new
				report: report;
				name: 'P';
				categoryNode: self categoryH;
				yourself ]
]

{ #category : #running }
SPMTest >> behaviorQ [
	^ behaviorQ ifNil: [
		behaviorQ := SPMBehaviorNode new
				report: report;
				name: 'Q';
				categoryNode: self categoryI;
				yourself ]
]

{ #category : #running }
SPMTest >> categoryH [
	^ categoryH ifNil: [
		categoryH := SPMCategoryNode new
				report: report;
				name: 'H';
				yourself ]
]

{ #category : #running }
SPMTest >> categoryI [
	^ categoryI ifNil: [
		categoryI := SPMCategoryNode new
				report: report;
				name: 'I';
				yourself ]
]

{ #category : #running }
SPMTest >> methodX [
	^ methodX ifNil: [
		methodX := SPMMethodNode new
				report: report;
				name: 'x';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : #running }
SPMTest >> methodY [
	^ methodY ifNil: [
		methodY := SPMMethodNode new
				report: report;
				name: 'y';
				behaviorNode: self behaviorP;
				yourself ]
]

{ #category : #running }
SPMTest >> methodZ [
	^ methodZ ifNil: [
		methodZ := SPMMethodNode new
				report: report;
				name: 'z';
				behaviorNode: self behaviorQ;
				yourself ]
]

{ #category : #running }
SPMTest >> setUp [

	super setUp.
	report := SPMReport new.
	root := SPMTallyNode
		report: report
		methodNode: self methodX
		tally: 1000
		children: { 
			nodeA := (SPMTallyNode
				report: report
				methodNode: self methodY
				tally: 600
				children: {
					nodeAA := (SPMTallyNode
						report: report
						methodNode: self methodY
						tally: 600
						children: #())}).
			nodeB := (SPMTallyNode
				report: report
				methodNode: self methodZ
				tally: 400
				children: {
					nodeBA := (SPMTallyNode
						report: report
						methodNode: self methodZ
						tally: 300
						children: {
							nodeBAA := (SPMTallyNode
								report: report
								methodNode: self methodZ
								tally: 200
								children: {
									nodeBAAA := (SPMTallyNode
										report: report
										methodNode: self methodZ
										tally: 100
										children: #())})})})}.
	report
		initializeNodes: {root}
		totalTime: 2000 milliSeconds
		totalTally: 1000
]
