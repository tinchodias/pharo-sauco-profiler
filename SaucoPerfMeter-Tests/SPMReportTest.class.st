Class {
	#name : #SPMReportTest,
	#superclass : #SPMTest,
	#category : #'SaucoPerfMeter-Tests'
}

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

{ #category : #testing }
SPMReportTest >> testTallyLeaves [

	self
		assert: (report tallyLeaves collect: [ :n | n methodNode ])
		equals: { 
				self methodY.
				self methodZ }
]
