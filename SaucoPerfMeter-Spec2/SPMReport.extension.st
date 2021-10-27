Extension { #name : #SPMReport }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> gtInspectorCodeSunburstIn: composite [

	self flag: #todo.
"	<gtInspectorPresentationOrder: 0.4>
	^ composite roassal2
		title: 'Code sunburst';
		initializeView: [ RTSunburstBuilder new ];
		painting: [ :builder | 
			| colorMap |
			colorMap := SPMCodeColorMap forReport: self.
			
			builder shape fillColor: [:each | each == self ifTrue: [ Color black ] ifFalse: [colorMap colorAt: each] ].
			
			builder
				explore: self
				using: [ :each | 
					(each == self
						ifTrue: [ self allCategoryNodes ]
						ifFalse: [ each children ]) select: [ :c | c ratio > 0 ] ].
			builder
				weight: [ :each | 
					each == self
						ifTrue: [ 1.0 ]
						ifFalse: [ each ratio ] ].
			builder hasCenter: false.
			builder
				radialSpacing: 5;
				angularSpacing: 3 ]"
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> gtInspectorCodeTreeMapIn: composite [

	self flag: #todo.
"	<gtInspectorPresentationOrder: 0.5>
	^ composite roassal2
		title: 'Code tree map';
		initializeView: [ RTTreeMapBuilder new ];
		painting: [ :builder |
			| colorMap |
			colorMap := SPMCodeColorMap forReport: self.
			
			builder shape fillColor: [:each | each == self ifTrue: [ Color black ] ifFalse: [colorMap colorAt: each] ].
			builder inset: 8.
			builder
				explore: self
				using: [ :each | 
					(each == self
						ifTrue: [ self allCategoryNodes ]
						ifFalse: [ each children ]) select: [ :c | c ratio > 0 ] ].
			builder
				weight: [ :each | 
					each == self
						ifTrue: [ 1.0 ]
						ifFalse: [ each ratio ] ].
					 ]"
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> gtInspectorTallySunburstIn: composite [

self flag: #todo.
"	<gtInspectorPresentationOrder: 0.3>
	^ composite roassal2
		title: 'Tally sunburst';
		initializeView: [ RTSunburstBuilder new ];
		painting: [ :builder | 
			| colorMap |
			colorMap := SPMCodeColorMap forReport: self.
			builder shape
				fillColor: [ :each | 
					each == self
						ifTrue: [ Color black ]
						ifFalse: [ colorMap colorAt: each methodNode ] ].
			builder
				explore: self
				using: [ :each | 
					each == self
						ifTrue: [ self rootTallyNodes ]
						ifFalse: [ each children ] ].
			builder
				weight: [ :each | 
					each == self
						ifTrue: [ 1.0 ]
						ifFalse: [ each ratio ] ];
				hasCenter: false;
				radialSpacing: 0 ]"
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Behaviors'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self allBehaviorNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> inspectionForCategories: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Categories'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self allCategoryNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 3 title: 'Methods'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self allMethodNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMReport >> inspectionForTallyTree: aBuilder [
	<inspectorPresentationOrder: 0.1 title: 'Tally tree'>

	^ aBuilder newTreeTable
		hideColumnHeaders;
		roots: self rootTallyNodes;
		displayIcon: [ :each | SPMConvenience ratioIcon: each ratio ];
		display: [ :each | SPMConvenience tallyNodeMorphFor: each ];
		sortBlock: [ :a :b | a tally > b tally ];
		children: [ :each | each children sorted: [ :a :b | a tally > b tally ] ];
		expandAll;
		yourself

]
