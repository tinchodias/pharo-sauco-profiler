"
I represent a report of a profiling execution.
"
Class {
	#name : #SPMReport,
	#superclass : #Object,
	#instVars : [
		'totalTime',
		'totalTally',
		'rootTallyNodes'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #examples }
SPMReport class >> exampleAll: aBlock [
	| exampleSelector |
	exampleSelector := thisContext sender selector storeString.
	Smalltalk tools inspector
		inspect: (self newWithASPOn: aBlock) label: exampleSelector , ' - AndreasSystemProfiler';
		inspect: (self newWithMTOn: aBlock) label: exampleSelector , ' - MessageTally'
]

{ #category : #examples }
SPMReport class >> exampleBenchFib [
	self exampleAll: [ 32 benchFib ]
]

{ #category : #examples }
SPMReport class >> exampleFactorial [
	self exampleAll: [ 1000 timesRepeat: [ 1000 factorial ] ]
]

{ #category : #examples }
SPMReport class >> exampleFuelAllIcons [
	self exampleAll: [ | array |
		array := FLSerializer serializeToByteArray: Smalltalk ui icons. 
		FLMaterializer materializeFromByteArray: array ]
]

{ #category : #examples }
SPMReport class >> exampleNeoJson [
	self exampleAll: [ NeoJSONTestObject2 benchmark10k ]
]

{ #category : #examples }
SPMReport class >> exampleRandomNext [
	self
		exampleAll: [ | random |
			random := Random seed: 1.
			(1 to: 500000) collect: [ :each | random next ] ]
]

{ #category : #examples }
SPMReport class >> exampleUUID [
	self exampleAll: [ (1 to: 100000) collect: [ :each | UUID new ] ]
]

{ #category : #examples }
SPMReport class >> exampleWait [
	self exampleAll: [ 3 seconds wait ]
]

{ #category : #examples }
SPMReport class >> exampleZincGet [
	self exampleAll: [ ZnEasy get: 'http://pharo.org/' ]
]

{ #category : #convenience }
SPMReport class >> newWithASPOn: aBlock [
	| profiler semaphore |
	semaphore := Semaphore new.
	profiler := AndreasSystemProfiler new.
	[ "We fork just to cut stack trace: the ASP report will start at this method context"
	profiler startProfiling.
	aBlock value.
	profiler stopProfiling.
	semaphore signal ] fork.
	semaphore wait.
	^ profiler spmAsReport
]

{ #category : #convenience }
SPMReport class >> newWithMTOn: aBlock [
	| profiler |
	profiler := MessageTally new.
	profiler reportOtherProcesses: false.
	[ profiler spyEvery: 1 on: aBlock.
	^ profiler spmAsReport ]
		ensure: [ "Send of #close must be done at the end because it nilizes the instance variables" profiler close ]
]

{ #category : #accessing }
SPMReport >> allBehaviorNodes [
	^ rootTallyNodes flatCollect: #allBehaviorNodes
]

{ #category : #accessing }
SPMReport >> allCategoryNodes [
	^ (rootTallyNodes flatCollect: #allCategoryNodes) sorted: [:a :b | a ratio > b ratio ]
]

{ #category : #accessing }
SPMReport >> allMethodNodes [
	^ rootTallyNodes flatCollect: #allMethodNodes
]

{ #category : #accessing }
SPMReport >> allTallyNodes [
	^ rootTallyNodes flatCollect: #withAllChildren
]

{ #category : #accessing }
SPMReport >> rootTallyNodes [
	^ rootTallyNodes
]

{ #category : #accessing }
SPMReport >> rootTallyNodes: anObject [
	rootTallyNodes := anObject
]

{ #category : #accessing }
SPMReport >> tallyLeaves [
	^ rootTallyNodes flatCollect: #allLeaves
]

{ #category : #accessing }
SPMReport >> totalTally [
	^ totalTally
]

{ #category : #accessing }
SPMReport >> totalTally: anObject [
	totalTally := anObject
]

{ #category : #accessing }
SPMReport >> totalTime [
	^ totalTime
]

{ #category : #accessing }
SPMReport >> totalTime: aDuration [
	totalTime := aDuration
]
