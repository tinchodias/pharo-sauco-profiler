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
SPMReport >> gtInspectorCategoriesTreeMapIn: composite [
	<gtInspectorPresentationOrder: 0.5>
	^ composite roassal2
		title: 'Categories tree map';
		initializeView: [ RTTreeMapBuilder new ];
		painting: [ :view | 
			view shape fillColor: Color veryLightGray.
			view from: self allCategoryNodes using: [ #() ].
			view weight: [ :each | each ratio ] ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorCodeSunburstIn: composite [
	<gtInspectorPresentationOrder: 0.4>
	^ composite roassal2
		title: 'Code sunburst';
		initializeView: [ RTSunburstBuilder new ];
		painting: [ :builder | 
			builder
				explore: self
				using: [ :each | 
					(each == self
						ifTrue: [ self allCategoryNodes ]
						ifFalse: [ each children ]) select: [:c | c ratio > 0 ] ].
			builder
				weight: [ :each | 
					each == self
						ifTrue: [ 1.0 ]
						ifFalse: [ each ratio ] ].
			builder hasCenter: false.
			builder radialSpacing: 2 ]
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
SPMReport >> gtInspectorTallyListIn: composite [
"	<gtInspectorPresentationOrder: 0.2>"
	^ composite fastTable
		title: 'Tally list';
		display: [ self allTallyNodes ];
		icon: [ :each | SPMConvenience ratioIcon: each netRatio ];
		sortBlock: [ :a :b | a netTally > b netTally ];
		column: 'Net'
			evaluated: [ :each | 
			'{1} [{2}]'
				format:
					{SPMConvenience printPercentage: each netPercentage.
					SPMConvenience printAbbreviatedDuration: each netTime} ]
			width: 150;
		column: 'Total'
			evaluated: [ :each | 
			'{1} ({2})'
				format:
					{SPMConvenience printPercentage: each percentage.
					SPMConvenience printAbbreviatedDuration: each time} ]
			width: 150;
		column: 'Method' evaluated: [ :each | each methodNode fullName ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> gtInspectorTallySunburstIn: composite [
	<gtInspectorPresentationOrder: 0.3>
	^ composite roassal2
		title: 'Tally sunburst';
		initializeView: [ RTSunburstBuilder new ];
		painting: [ :builder | 
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
				radialSpacing: 0.
			builder shape
				if: [ :each | each ~~ self and: [ self shouldShadow: each ] ]
				fillColor: Color gray ]
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
		column: ''
			evaluated: [ :each | 
			| string |
			string := '{1} ({2}) [{3}] - {4}'
				format:
					{(SPMConvenience printPercentage: each percentage).
					(SPMConvenience printAbbreviatedDuration: each time).
					(SPMConvenience printAbbreviatedDuration: each netTime).
					each methodNode fullName}.
			(self shouldShadow: each)
				ifFalse: [ string ]
				ifTrue: [ SPMConvenience shadowedTextFor: string ] ]
			width: 5000
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

{ #category : #'*SaucoPerfMeter-GT' }
SPMReport >> shouldShadow: aTallyNode [
	^ aTallyNode netTally = 0
]
