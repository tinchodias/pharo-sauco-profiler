Extension { #name : #SPMReport }

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorBehaviorsIn: composite [
	<gtInspectorPresentationOrder: 1.2>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Behaviors'
		display: [ self allBehaviorNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorCategoriesIn: composite [
	<gtInspectorPresentationOrder: 1.1>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Categories'
		display: [ self allCategoryNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorCodeSunburstIn: composite [
	<gtInspectorPresentationOrder: 0.4>
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
				angularSpacing: 3 ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorCodeTreeMapIn: composite [
	<gtInspectorPresentationOrder: 0.5>
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
					 ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorMethodsIn: composite [
	<gtInspectorPresentationOrder: 1.3>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Methods'
		display: [ self allMethodNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorTallySunburstIn: composite [
	<gtInspectorPresentationOrder: 0.3>
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
				radialSpacing: 0 ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorTallyTreeIn: composite [
	<gtInspectorPresentationOrder: 0.1>
	^ composite fastTreeTable
		hideHeader;
		title: 'Tally tree';
		display: [ self rootTallyNodes ];
		icon: [ :each | SPMConvenience ratioIcon: each ratio ];
		sortBlock: [ :a :b | a tally > b tally ];
		children: [ :each | each children sorted: [ :a :b | a tally > b tally ] ];
		shouldExpandToLevel: 15;
		column: '' evaluated: [ :each | SPMConvenience tallyNodeMorphFor: each ] width: 5000
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> isIrrelevantCodeNode: aNode [
	^ aNode ratio < 0.03
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> isIrrelevantTallyNode: aNode [
	^ aNode netRatio < 0.03
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $(.
	SPMConvenience printAbbreviatedDuration: self totalTime on: aStream.
	aStream nextPut: $)
]
