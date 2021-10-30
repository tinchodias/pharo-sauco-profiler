Extension { #name : #SPMTallyNode }

{ #category : #'*SaucoPerfMeter-Roassal3' }
SPMTallyNode >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Flame graph'>

	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		canvas: (SPMFlameGraph new canvasFor: { self } report: report);
		yourself
]
