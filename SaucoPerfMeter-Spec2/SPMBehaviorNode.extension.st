Extension { #name : #SPMBehaviorNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMBehaviorNode >> inspectionForMethods: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Methods'>

	^ SPMConvenience
		inspectionCodeList: aBuilder
		items: self methodNodes
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMBehaviorNode >> nameTags [

	^ { self categoryName }
]
