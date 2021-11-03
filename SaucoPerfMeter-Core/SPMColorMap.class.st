Class {
	#name : #SPMColorMap,
	#superclass : #Object,
	#instVars : [
		'theme'
	],
	#category : #'SaucoPerfMeter-Core'
}

{ #category : #accessing }
SPMColorMap >> colorAt: aSPMCodeNode [

	^ self subclassResponsibility
]

{ #category : #initialization }
SPMColorMap >> initialize [

	super initialize.
	theme := Smalltalk ui theme.
]

{ #category : #accessing }
SPMColorMap >> labelColorAt: aSPMCodeNode [

	^ self theme textColor
]

{ #category : #accessing }
SPMColorMap >> theme [

	^ theme
]

{ #category : #accessing }
SPMColorMap >> theme: aUITheme [

	theme := aUITheme
]
