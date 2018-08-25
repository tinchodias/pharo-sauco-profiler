Extension { #name : #SPMCategoryNode }

{ #category : #'*SaucoPerfMeter-GT' }
SPMCategoryNode >> gtInspectorBehaviorsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Behaviors'
		display: [ self behaviorNodes ]
]
