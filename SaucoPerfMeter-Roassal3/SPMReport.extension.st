Extension { #name : #SPMReport }

{ #category : #'*SaucoPerfMeter-Roassal3' }
SPMReport >> inspectionCodeSunburstIn: aBuilder [
	"<inspectorPresentationOrder: 0.6 title: 'Code Sunburst'>"
	
	self flag: #todo.  "DELETE?"

	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		canvas: (SPMCodeSunburst new canvasFor: self allCategoryNodes);
		yourself
]

{ #category : #'*SaucoPerfMeter-Roassal3' }
SPMReport >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Flame graph'>

	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		  canvas: (SPMFlameGraph new
				   report: self;
				   tallyNodes: rootTallyNodes;
				   build;
				   canvas);
		  yourself
]
