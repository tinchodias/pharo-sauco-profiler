Extension { #name : #SPMTallyNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMTallyNode >> inspectionForAllParents: aBuilder [
	<inspectorPresentationOrder: 1.5 title: 'Stack'>

	^ aBuilder newTable
		items: self withAllParents;
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | SPMConvenience ratioIcon: each ratio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | SPMConvenience codeNameMorphFor: each methodNode ])
			width: 400;
			yourself);
		yourself
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMTallyNode >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Behaviors'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self allBehaviorNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMTallyNode >> inspectionForCategories: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Categories'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self allCategoryNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMTallyNode >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 3 title: 'Methods'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self allMethodNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMTallyNode >> inspectionForSource: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Source in current image'>

	^ methodNode inspectionForSource: aBuilder
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMTallyNode >> relevanceDescription [

	| output |
	output := '{1} [{2}]' format: { 
			  (SPMConvenience printPercentage: self percentage).
			  (report durationPrinter print: self time) }.
	
	(self hasChildren and: [ self netTally > 0 ]) ifTrue: [
		output := output, ' ({1} net)' format: {
			self report durationPrinter print: self netTime } ].

	^ output

]
