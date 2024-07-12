Extension { #name : #RSCanvas }

{ #category : #'*SaucoPerfMeter-Pharo11' }
RSCanvas >> asPresenter [
	"Added for Sauco, as a backgwards-compatibility extension."

	^ SpRoassal3InspectorPresenter new
		  canvas: self;
		  yourself
]
