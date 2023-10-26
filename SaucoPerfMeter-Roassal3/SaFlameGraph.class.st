Class {
	#name : #SaFlameGraph,
	#superclass : #SaGraphBuilder,
	#instVars : [
		'tallyNodeSelectBlock',
		'tallyNodes',
		'borderForBox'
	],
	#category : #'SaucoPerfMeter-Roassal3'
}

{ #category : #private }
SaFlameGraph >> addInnerLabels [
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
SaFlameGraph >> borderForBox [

	^ borderForBox ifNil: [
		borderForBox := RSBorder new
		  width: 0.25;
		  color: self theme textColor;
		  yourself ]

]

{ #category : #building }
SaFlameGraph >> build [

	builder := RSFlameGraph new.
	builder
		gap: 0 @ 2;
		"Workaround to be more accurate: 
			when gap's x is non-zero, the children narrow on each level."
		graphWidth: 2000;
		modelWeight: [ :tallyNode | tallyNode tally ].

	builder boxShape
		cornerRadius: 1;
		border: self borderForBox;
		addInteraction: self popupInteraction;
		addInteraction: self highlightInteraction;
		when: RSMouseDoubleClick
			do: [ :e | e shape model inspect ]
			"for: self".

	builder
		from: (self nodesToShow: tallyNodes)
			using: [ :n | self nodesToShow: n children ];
		build.

	builder shapes do: [ :shape |
		shape color: shape model methodNode codeColor ].

	self addInnerLabels.

	builder canvas
		color: self theme backgroundColor;
		addInteraction: RSCanvasController new
]

{ #category : #accessing }
SaFlameGraph >> considerAllNodes [

	self tallyNodeSelectBlock: [ :_ | true ]
]

{ #category : #private }
SaFlameGraph >> nodesToShow: someNodes [
	"Answer a filtered and sorted list of SPMTallyNodes.
	They are sorted by #fullName to help comparing visually one profile run with another."

	^ (someNodes select: self tallyNodeSelectBlock) 
		sorted: [ :a :b | a methodNode fullName < b methodNode fullName ]

]

{ #category : #accessing }
SaFlameGraph >> tallyNodeSelectBlock [

	^ tallyNodeSelectBlock ifNil: [ tallyNodeSelectBlock := #isRelevant ]
]

{ #category : #accessing }
SaFlameGraph >> tallyNodeSelectBlock: aUnaryBlockClosure [

	tallyNodeSelectBlock := aUnaryBlockClosure
]

{ #category : #accessing }
SaFlameGraph >> tallyNodes [

	^ tallyNodes
]

{ #category : #accessing }
SaFlameGraph >> tallyNodes: aCollectionOfSaTallyNodes [

	tallyNodes := aCollectionOfSaTallyNodes
]
