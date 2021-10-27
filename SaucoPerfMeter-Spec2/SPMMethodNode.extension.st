Extension { #name : #SPMMethodNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMMethodNode >> inspectionForSource: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Source in current image'>

	^ self
		  compiledMethodInCurrentImageIfPresent: [ :method | 
			  method inspectionSource ]
		  ifAbsent: [ 
			  aBuilder label
				  text: '-- Not found --';
				  yourself ]
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMMethodNode >> nameTags [

	^ { self categoryName }
]
