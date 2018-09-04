Extension { #name : #SPMBehaviorNode }

{ #category : #'*SaucoPerfMeter-GT' }
SPMBehaviorNode >> gtInspectorMethodsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Methods'
		display: [ self methodNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMBehaviorNode >> gtNameTags [
	^ { self categoryName }
]
