Class {
	#name : #SPMFlameGraph,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-Roassal3'
}

{ #category : #building }
SPMFlameGraph >> canvasFor: tallyNodes report: aSPMReport [

	| builder |
	builder := RSFlameGraph new.
	builder
"		graphWidth: 1000;"
		leafWeight: #tally;
		from: tallyNodes using: #children.
	builder boxShape
		cornerRadius: 0.
	builder build.

	builder shapes
		addInteraction: (RSPopup text: [ :n | SPMConvenience multipleLineDescriptionFor: n ])";
		addInteraction: (RSHighlightable new highlightBorder: (RSBorder new color: Color black); yourself)".

	builder shapes do: [ :shape | 
		shape color: shape model methodNode codeColor ].

	^ builder canvas
		color: (aSPMReport colorMap theme backgroundColor);
		addInteraction: RSCanvasController new;
		yourself

]
