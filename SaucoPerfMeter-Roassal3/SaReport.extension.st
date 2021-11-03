Extension { #name : #SaReport }

{ #category : #'*SaucoPerfMeter-Roassal3' }
SaReport >> inspectionCodeSunburstIn: aBuilder [
	"<inspectorPresentationOrder: 0.6 title: 'Code Sunburst'>"
	
	self flag: #todo.  "DELETE?"

	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		canvas: (SaCodeSunburst new canvasFor: self allCategoryNodes);
		yourself
]

{ #category : #'*SaucoPerfMeter-Roassal3' }
SaReport >> inspectionForFlameGraph: aBuilder [
	<inspectorPresentationOrder: 0.5 title: 'Flame graph'>

	^ (aBuilder instantiate: SpRoassal3InspectorPresenter)
		  canvas: (SaFlameGraph new
				   report: self;
				   tallyNodes: rootTallyNodes;
				   build;
				   canvas);
		  yourself
]
