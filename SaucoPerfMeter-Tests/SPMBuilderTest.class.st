Class {
	#name : #SPMBuilderTest,
	#superclass : #TestCase,
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #tests }
SPMBuilderTest >> testAndreasSystemProfilerAsReport [
	| profiler report |
	"Profile"
	profiler := AndreasSystemProfiler new.
	profiler startProfiling.
	25 benchFib.
	profiler stopProfiling.
	"Asserts on resulting report"
	report := profiler spmAsReport.
	self deny: report isNil.
	self deny: report rootTallyNodes isEmpty
]

{ #category : #tests }
SPMBuilderTest >> testMessageTallyAsReport [
	| profiler report |
	"Profile"
	profiler := MessageTally new.
	profiler spyEvery: 1 on: [ 25 benchFib ].
	"Asserts on resulting report"
	report := profiler spmAsReport.
	self deny: report isNil.
	self deny: report rootTallyNodes isEmpty
]
