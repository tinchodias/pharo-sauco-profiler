Extension { #name : #SPMTallyNode }

{ #category : #'*SaucoPerfMeter-GT' }
SPMTallyNode >> gtInspectorBehaviorsIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Behaviors'
		display: [ self allBehaviorNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMTallyNode >> gtInspectorCategoriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Categories'
		display: [ self allCategoryNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMTallyNode >> gtInspectorMethodsIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ SPMConvenience
		gtInspectorCodeListIn: composite
		title: 'Methods'
		display: [ self allMethodNodes ]
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMTallyNode >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ methodNode gtInspectorSourceIn: composite
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMTallyNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $(.
	SPMConvenience printAbbreviatedDuration: self time on: aStream.
	aStream
		nextPutAll: ' - ';
		nextPutAll: methodNode fullName;
		nextPut: $)
]
