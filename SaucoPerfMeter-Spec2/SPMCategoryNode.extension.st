Extension { #name : #SPMCategoryNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMCategoryNode >> inspectionForBehaviors: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Behaviors'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self behaviorNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMCategoryNode >> nameTags [

	^ #(  )
]
