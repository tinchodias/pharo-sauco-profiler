Class {
	#name : #SPMFlameGraph,
	#superclass : #Object,
	#instVars : [
		'tallyNodeSelectBlock'
	],
	#category : #'SaucoPerfMeter-Roassal3'
}

{ #category : #building }
SPMFlameGraph >> addInnerLabelsTo: builder theme: theme [

	"Add labels to rectangles, when they fit inside."	
	builder shapes do: [ :shape |
		| location labelBuilder label |
		location := RSLocation new middle; inner; left; offset: 5@0; yourself.
		
		labelBuilder := RSMultilineLabelBuilder new
			wrapStrategy: (RSWrapEllipsisStrategy new wrapMaxWidth: shape width - 10);
			yourself.
		
		labelBuilder labelShape color: (shape model report colorMap labelColorAt: shape model).
		
		label := labelBuilder shapeFor: shape model methodNode fullName.

		location stick: label on: shape.

		(label width > 25 and: [ (label width+5) < shape width ]) ifTrue: [ 
			builder canvas addShape: label ] ].

]

{ #category : #building }
SPMFlameGraph >> canvasFor: tallyNodes report: aSPMReport [

	| builder theme border |
	theme := aSPMReport colorMap theme.
	
	builder := RSFlameGraph new.
	builder
		gap: 0@2; "Workaround to be more accurate: 
			when gap's x is non-zero, the children narrow on each level."
		graphWidth: 1000;
		leafWeight: #tally;
		from: (tallyNodes select: self tallyNodeSelectBlock)
			using: [ :n | n children select: self tallyNodeSelectBlock ].
	builder boxShape
		cornerRadius: 1.

	builder build.

	builder shapes
		addInteraction: (RSPopup text: [ :n | SPMConvenience multipleLineDescriptionFor: n ]);
		addInteraction: (RSHighlightable new
			highlightBorder: (RSBorder new width: 2; color: theme secondarySelectionColor);
			yourself).

	border := RSBorder new width: 0.25; color: theme textColor; yourself.
	builder shapes do: [ :shape | 
		shape
			border: border;
			color: shape model methodNode codeColor ].

	self addInnerLabelsTo: builder theme: theme.

	^ builder canvas
		color: theme backgroundColor;
		addInteraction: RSCanvasController new;
		yourself

]

{ #category : #accessing }
SPMFlameGraph >> tallyNodeSelectBlock [

	^ tallyNodeSelectBlock ifNil: [ tallyNodeSelectBlock := #isRelevant ]
]

{ #category : #accessing }
SPMFlameGraph >> tallyNodeSelectBlock: aUnaryBlockClosure [

	tallyNodeSelectBlock := aUnaryBlockClosure
]
