Class {
	#name : #SPMCategoryPrefixColorMap,
	#superclass : #SPMColorMap,
	#instVars : [
		'colorAssociations',
		'defaultColor'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SPMCategoryPrefixColorMap >> colorAssociations [

	^ colorAssociations
]

{ #category : #accessing }
SPMCategoryPrefixColorMap >> colorAt: aSPMCodeNode [

	^ self colorForCategory: aSPMCodeNode categoryName 
]

{ #category : #accessing }
SPMCategoryPrefixColorMap >> colorForCategory: aString [ 

	^ (self colorAssociations
		detect: [ :each | aString beginsWith: each key ]
		ifNone: [ defaultColor ]) value

]

{ #category : #initialization }
SPMCategoryPrefixColorMap >> initialize [

	super initialize.

	colorAssociations := #().
	defaultColor := Color veryDarkGray "theme textColor alpha: 0.1.".

]

{ #category : #accessing }
SPMCategoryPrefixColorMap >> labelColorAt: aSPMCodeNode [

	^ (self colorAt: aSPMCodeNode) luminance < 0.5
		  ifTrue: [ Color white ]
		  ifFalse: [ Color black ]
]

{ #category : #initialization }
SPMCategoryPrefixColorMap >> mapPrefixes: aCollectionOfStrings from: aColor [

	| anotherColor minHueIncrement |
	minHueIncrement := 5.
	anotherColor := Color
		h: aColor hue + (minHueIncrement * aCollectionOfStrings size)
		s: aColor saturation * 0.7
		v: aColor brightness * 1.3.
	
	self mapPrefixes: aCollectionOfStrings from: aColor to: anotherColor
]

{ #category : #initialization }
SPMCategoryPrefixColorMap >> mapPrefixes: aCollectionOfStrings from: aColor to: anotherColor [

	| colorRamp |
	colorRamp := aColor 
		mix: anotherColor
		shades: aCollectionOfStrings size.

	colorAssociations := colorAssociations, 
		(aCollectionOfStrings
			collectWithIndex: [ :each :index |
				each -> (colorRamp at: index) ]).

]
