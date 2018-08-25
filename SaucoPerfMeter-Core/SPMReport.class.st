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
SPMReport class >> exampleASP: aBlock [
	(self newWithASPOn: aBlock) inspect
]

{ #category : #examples }
SPMReport class >> exampleBenchFib [
	self exampleBoth: [ 38 benchFib ]
]

{ #category : #examples }
SPMReport class >> exampleBoth: aBlock [
	self exampleASP: aBlock.
	self exampleMT: aBlock.
]

{ #category : #examples }
SPMReport class >> exampleFactorial [
	self exampleBoth: [ 1000 timesRepeat: [ 1000 factorial ] ]
]

{ #category : #examples }
SPMReport class >> exampleForks [
	self
		exampleBoth: [ | semaphore numberOfForks |
			numberOfForks := 10.
			semaphore := Semaphore new.
			1 to: numberOfForks do: [ :index | 
				[ 35 benchFib.
				semaphore signal ] forkNamed: 'f' , index asString ].
			numberOfForks timesRepeat: [ semaphore wait ] ]
]

{ #category : #examples }
SPMReport class >> exampleMT: aBlock [
	(self newWithMessageTallyOn: aBlock) inspect
]

{ #category : #examples }
SPMReport class >> exampleNeoJson [
	self exampleBoth: [ NeoJSONTestObject2 benchmark200k ]
]

{ #category : #examples }
SPMReport class >> exampleWait [
	self exampleBoth: [ 3 seconds wait ]
]

{ #category : #examples }
SPMReport class >> exampleZincGet [
	self exampleBoth: [ ZnEasy get: 'http://pharo.org/' ]
]

{ #category : #convenience }
SPMReport class >> newWithASPOn: aBlock [
	| profiler semaphore |
	semaphore := Semaphore new.
	profiler := AndreasSystemProfiler new.
	[profiler startProfiling.
	aBlock value.
	profiler stopProfiling.
	semaphore signal ] fork.
	semaphore wait.
	^ profiler spmAsReport
]

{ #category : #convenience }
SPMReport class >> newWithMessageTallyOn: aBlock [
	| profiler semaphore |
	semaphore := Semaphore new.
	profiler := MessageTally new.
	profiler reportOtherProcesses: false.
	[ [ profiler spyEvery: 1 on: aBlock.
	semaphore signal ] fork.
	semaphore wait.
	^ profiler spmAsReport ]
		ensure: [ profiler close ]
]

{ #category : #accessing }
SPMReport >> allBehaviorNodes [
	^ rootTallyNodes flatCollect: #allBehaviorNodes
]

{ #category : #accessing }
SPMReport >> allCategoryNodes [
	^ rootTallyNodes flatCollect: #allCategoryNodes
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
