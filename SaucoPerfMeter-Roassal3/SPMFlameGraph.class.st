Class {
	#name : #SPMFlameGraph,
	#superclass : #Object,
	#instVars : [
		'tallyNodeSelectBlock',
		'builder',
		'tallyNodes',
		'report',
		'borderForBox'
	],
	#category : #'SaucoPerfMeter-Roassal3'
}

{ #category : #private }
SPMFlameGraph >> addInnerLabels [
	"Add labels to each rectangle, when they fit inside."	

	builder shapes do: [ :shape |
		| location labelBuilder label |
		location := RSLocation new middle; inner; left; offset: 5@0; yourself.
		
		labelBuilder := RSMultilineLabelBuilder new
			wrapStrategy: (RSWrapEllipsisStrategy new wrapMaxWidth: shape width - 10);
			yourself.
		
		labelBuilder labelShape color: (report colorMap labelColorAt: shape model).
		
		label := labelBuilder shapeFor: shape model methodNode fullName.

		location stick: label on: shape.

		(label width > 25 and: [ (label width+5) < shape width ]) ifTrue: [ 
			builder canvas addShape: label ] ].

]

{ #category : #private }
SPMFlameGraph >> borderForBox [

	^ borderForBox ifNil: [
		borderForBox := RSBorder new
		  width: 0.25;
		  color: self theme textColor;
		  yourself ]

]

{ #category : #building }
SPMFlameGraph >> build [

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
		addInteraction: self popupInteraction;
		addInteraction: self highlightInteraction.

	builder shapes do: [ :shape | 
		shape
			border: self borderForBox;
			color: shape model methodNode codeColor ].

	self addInnerLabels.

	builder canvas
		color: self theme backgroundColor;
		addInteraction: RSCanvasController new

]

{ #category : #accessing }
SPMFlameGraph >> canvas [
	"Answerr the RSCanvas that was built previously by sending #build."

	^ builder canvas
]

{ #category : #accessing }
SPMFlameGraph >> considerAllNodes [

	self tallyNodeSelectBlock: [ :_ | true ]
]

{ #category : #private }
SPMFlameGraph >> highlightInteraction [

	^ RSHighlightable new
		  highlightBorder: (RSBorder new
				   width: 2;
				   color: self theme secondarySelectionColor);
		  yourself
]

{ #category : #private }
SPMFlameGraph >> popupInteraction [

	| popup |
	popup := RSPopup new.

	popup shapeBuilder textBlock: [ :n | 
		SPMConvenience multipleLineDescriptionFor: n ].

	popup shapeBuilder labelBuilder labelShape color: self theme textColor.

	^ popup
]

{ #category : #accessing }
SPMFlameGraph >> report [

	^ report
]

{ #category : #accessing }
SPMFlameGraph >> report: aSPMReport [

	report := aSPMReport
]

{ #category : #accessing }
SPMFlameGraph >> tallyNodeSelectBlock [

	^ tallyNodeSelectBlock ifNil: [ tallyNodeSelectBlock := #isRelevant ]
]

{ #category : #accessing }
SPMFlameGraph >> tallyNodeSelectBlock: aUnaryBlockClosure [

	tallyNodeSelectBlock := aUnaryBlockClosure
]

{ #category : #accessing }
SPMFlameGraph >> tallyNodes [

	^ tallyNodes
]

{ #category : #accessing }
SPMFlameGraph >> tallyNodes: aCollectionOfSPMTallyNodes [

	tallyNodes := aCollectionOfSPMTallyNodes
]

{ #category : #private }
SPMFlameGraph >> theme [

	^ report colorMap theme
]
