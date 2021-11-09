Class {
	#name : #SaGraphBuilder,
	#superclass : #Object,
	#instVars : [
		'builder',
		'report'
	],
	#category : #'SaucoPerfMeter-Roassal3'
}

{ #category : #building }
SaGraphBuilder >> build [

	^ self subclassResponsibility
]

{ #category : #accessing }
SaGraphBuilder >> canvas [
	"Answer a RSCanvas, that was built previously by sending #build (precondition)."

	^ builder canvas
]

{ #category : #private }
SaGraphBuilder >> highlightInteraction [

	^ RSHighlightable new
		  highlightBorder: (RSBorder new
				   width: 1;
				   color: self theme textColor);
		  yourself
]

{ #category : #private }
SaGraphBuilder >> popupInteraction [

	| popup |
	popup := RSPopup new.

	popup shapeBuilder textBlock: [ :n | 
		SaConvenience multipleLineDescriptionFor: n ].

	popup shapeBuilder labelBuilder labelShape color: Color black.
	self flag: #todo. 
		"Popup doesn't allow custom background so owe cant use here 'self theme textColor'
		See: https://github.com/ObjectProfile/Roassal3/issues/423".

	^ popup
]

{ #category : #accessing }
SaGraphBuilder >> report [

	^ report
]

{ #category : #accessing }
SaGraphBuilder >> report: aSaReport [

	report := aSaReport
]

{ #category : #private }
SaGraphBuilder >> theme [

	^ report colorMap theme
]
