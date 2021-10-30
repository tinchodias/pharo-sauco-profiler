Class {
	#name : #SPMCodeSunburst,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-Roassal3'
}

{ #category : #building }
SPMCodeSunburst >> canvasFor: categoryNodes [

	| builder |
	builder := RSSunburstBuilder new.

	builder sliceShape 
		withBorder;
		segmentSpacing: 1.
	
	builder strategy
		hasCenter: false;
		radialSpacing: 5.

	builder
		weight: [ :shape |
			shape model 
				ifNil: [ categoryNodes sum: #ratio ] "Workaround: virtual node is added by builder"
				ifNotNil: [ shape model ratio ] ];
		from: (categoryNodes select: [:e | e ratio > 0 ])
			using: [ :node |
				node children select: [:e | e ratio > 0 ] ].

	^ builder build
		addInteraction: RSCanvasController new;
		canvas

]
