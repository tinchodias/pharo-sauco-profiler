Class {
	#name : #SaBuilderTest,
	#superclass : #TestCase,
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #tests }
SaBuilderTest >> testAndreasSystemProfilerAsReport [
	| profiler report |
	"Profile"
	profiler := AndreasSystemProfiler new.
	profiler startProfiling.
	25 benchFib.
	profiler stopProfiling.
	"Asserts on resulting report"
	report := profiler saucoAsReport.
	self deny: report isNil.
	self deny: report rootTallyNodes isEmpty.
	report rootTallyNodes do: [ :each | 
		self assert: each parent isNil ].
]

{ #category : #tests }
SaBuilderTest >> testMessageTallyAsReport [
	| profiler report |
	"Profile"
	profiler := MessageTally new.
	profiler spyEvery: 1 on: [ 25 benchFib ].
	"Asserts on resulting report"
	report := profiler saucoAsReport.
	self deny: report isNil.
	self deny: report rootTallyNodes isEmpty.
	report rootTallyNodes do: [ :each | 
		self assert: each parent isNil ].
]