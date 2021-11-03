Extension { #name : #SPMTallyNode }

{ #category : #'*SaucoPerfMeter-Roassal3' }
SPMTallyNode >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Children flame graph'>
	
	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		canvas: (SPMFlameGraph new
			tallyNodeSelectBlock:[:n | true ];
			canvasFor: { self } report: report);
		yourself
]
