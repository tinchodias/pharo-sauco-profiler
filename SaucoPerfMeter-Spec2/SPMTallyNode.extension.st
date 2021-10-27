Extension { #name : #SPMTallyNode }

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
