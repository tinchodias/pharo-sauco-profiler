Extension { #name : 'SaReport' }

{ #category : '*SaucoPerfMeter-Roassal3' }
SaReport >> asFlameGraph [

	^ SaFlameGraph new
	   report: self;
	   tallyNodes: rootTallyNodes;
	   build;
	   canvas
]

{ #category : '*SaucoPerfMeter-Roassal3' }
SaReport >> inspectionCodeSunburstIn: aBuilder [
"	<inspectorPresentationOrder: 0.6 title: 'Tally Distribution'>"
	
	self flag: #todo. "Delete? wasn't useful"
	
	^ (SaCodeSunburst new
			report: self;
			categoryNodes: self allCategoryNodes;
			build;
			canvas) asPresenter
]

{ #category : '*SaucoPerfMeter-Roassal3' }
SaReport >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Flame graph (prune irrelevant children)'>

	^ self asFlameGraph asPresenter
]
