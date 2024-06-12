Extension { #name : 'SaTallyNode' }

{ #category : '*SaucoPerfMeter-Roassal3' }
SaTallyNode >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Children flame graph (no pruning)'>

	^ (SaFlameGraph new
		   considerAllNodes;
		   report: report;
		   tallyNodes: { self };
		   build;
		   canvas) asPresenter
]
