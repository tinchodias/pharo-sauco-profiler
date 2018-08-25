Extension { #name : #GLMFastTreeTablePresentation }

{ #category : #'*SaucoPerfMeter-GT' }
GLMFastTreeTablePresentation >> hideHeader [
	^ self parameters at: 'shouldShowHeader' put: false
]
