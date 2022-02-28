Class {
	#name : #SaSmokeTest,
	#superclass : #TestCase,
	#category : #'SaucoPerfMeter-Tests'
}

{ #category : #tests }
SaSmokeTest >> assertValidReport: aSaReport [

	self assert: aSaReport totalTally > 0.
	self assert: aSaReport totalTime > 0 seconds.
	self deny: aSaReport rootTallyNodes isEmpty.
	self deny: aSaReport tallyLeaves isEmpty

]

{ #category : #tests }
SaSmokeTest >> testNewWithASPFor [

	self assertValidReport: (SaReport newWithASPFor: 200 milliSeconds)
]

{ #category : #tests }
SaSmokeTest >> testNewWithASPOn [

	self assertValidReport: (SaReport newWithASPOn: [ 32 benchFib ])
]

{ #category : #tests }
SaSmokeTest >> testNewWithMTFor [

	self assertValidReport: (SaReport newWithMTFor: 200 milliSeconds)
]

{ #category : #tests }
SaSmokeTest >> testNewWithMTOn [

	self assertValidReport: (SaReport newWithMTOn: [ 32 benchFib ])
]
