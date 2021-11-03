Extension { #name : #SaCodeNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SaCodeNode >> nameTags [

	^ self subclassResponsibility
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SaCodeNode >> relevanceDescription [

	^ '{1} [{2}]' format: { 
			  (SaConvenience printPercentage: self percentage).
			  (report durationPrinter print: self time) }
]
