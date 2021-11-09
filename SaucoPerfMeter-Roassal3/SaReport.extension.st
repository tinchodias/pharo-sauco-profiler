Extension { #name : #SaReport }

{ #category : #'*SaucoPerfMeter-Roassal3' }
SaReport >> inspectionCodeSunburstIn: aBuilder [
"	<inspectorPresentationOrder: 0.6 title: 'Tally Distribution'>"
	
	self flag: #todo. "Delete? wasn't useful"
	
	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		canvas: (SaCodeSunburst new
			report: self;
			categoryNodes: self allCategoryNodes;
			build;
			canvas);
		yourself
]

{ #category : #'*SaucoPerfMeter-Roassal3' }
SaReport >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Flame graph (prune irrelevant children)'>

	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		  canvas: (SaFlameGraph new
				   report: self;
				   tallyNodes: rootTallyNodes;
				   build;
				   canvas);
		  yourself
]
