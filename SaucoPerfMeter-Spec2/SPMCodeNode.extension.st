Extension { #name : #SPMCodeNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMCodeNode >> nameTags [

	^ self subclassResponsibility
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMCodeNode >> relevanceDescription [

	^ '{1} [{2}]' format: { 
			  (SPMConvenience printPercentage: self percentage).
			  (report durationPrinter print: self time) }
]
