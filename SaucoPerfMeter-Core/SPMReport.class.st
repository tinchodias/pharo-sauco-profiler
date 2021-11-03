"
I represent a report of a profiling execution.
"
Class {
	#name : #SPMReport,
	#superclass : #Object,
	#instVars : [
		'totalTime',
		'totalTally',
		'rootTallyNodes',
		'durationPrinter',
		'colorMap'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #examples }
SPMReport class >> exampleAll: aBlock [
	| exampleSelector |
	exampleSelector := thisContext sender selector storeString.
	Smalltalk tools inspector
		"inspect: (self newWithASP2On: aBlock) label: exampleSelector , ' - AndreasSystemProfiler2';"
		inspect: (self newWithASPOn: aBlock) label: exampleSelector , ' - AndreasSystemProfiler';
		inspect: (self newWithMTOn: aBlock) label: exampleSelector , ' - MessageTally'
]

{ #category : #examples }
SPMReport class >> exampleBenchFib [
	self exampleAll: [ 32 benchFib ]
]

{ #category : #examples }
SPMReport class >> exampleDiskWrite [
	| baseName |
	baseName := 'exampleDiskWrite'.
	self
		exampleAll: [ (baseName , Time primUTCMicrosecondsClock asString) asFileReference
				writeStreamDo: [ :stream | 1 to: 200000 do: [ :each | each printOn: stream ] ] ].
	('.' asFileReference childrenMatching: baseName , '*') do: [ :each | each ensureDelete ]
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
SPMReport class >> exampleRandomNext [
	self
		exampleAll: [ | random |
			random := Random seed: 1.
			(1 to: 500000) collect: [ :each | random next ] ]
]

{ #category : #examples }
SPMReport class >> exampleReadFuelFiles [
	"Inspect instances of SPMReport stored in fuel files"

	('.' asFileReference childrenMatching: 'profile_report.*.fuel')
		do: [ :each | 
			Smalltalk tools inspector
				inspect: (FLMaterializer materializeFromFileNamed: each pathString)
				label: each basename ]
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
	| profiler semaphore spmReport |
	semaphore := Semaphore new.
	profiler := AndreasSystemProfiler new.
	[ "We fork just to cut stack trace: the ASP report will start at this method context"
	profiler startProfiling.
	aBlock value.
	profiler stopProfiling.
	spmReport := profiler spmAsReport.
	semaphore signal ] fork.
	semaphore wait.
"	profiler doReport."
	^ spmReport
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

{ #category : #converting }
SPMReport >> asFuelByteArray [
	^ FLSerializer serializeToByteArray: self
]

{ #category : #accessing }
SPMReport >> colorMap [

	^ colorMap ifNil: [ colorMap := SPMCodeColorMap forReport: self ]
]

{ #category : #accessing }
SPMReport >> colorMap: aSPMColorMap [

	colorMap := aSPMColorMap
]

{ #category : #accessing }
SPMReport >> durationPrinter [

	^ durationPrinter ifNil: [ 
		  durationPrinter := SPMAdaptedDurationPrinter new ]
]

{ #category : #accessing }
SPMReport >> durationPrinter: anObject [

	durationPrinter := anObject
]

{ #category : #initialization }
SPMReport >> initializeNodes: aCollection totalTime: aDuration totalTally: anInteger [ 
	rootTallyNodes := aCollection.
	totalTime := aDuration.
	totalTally := anInteger.
]

{ #category : #accessing }
SPMReport >> methodNodeLeaves [

	^ (self tallyLeaves collect: #methodNode) asSet 
			sorted: [ :a :b | a netTally > b netTally ]
]

{ #category : #testing }
SPMReport >> minimumRelevantRatio [
	"Answer the minimum ratio for either a tally or a code node to be considered relevant."

	^ 0.03
]

{ #category : #printing }
SPMReport >> printOn: aStream [

	super printOn: aStream.
	aStream
		space;
		nextPut: $(.
	self durationPrinter print: self totalTime on: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
SPMReport >> rootTallyNodes [
	^ rootTallyNodes
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
SPMReport >> totalTime [
	^ totalTime
]
