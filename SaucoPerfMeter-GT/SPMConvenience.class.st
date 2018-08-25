"
I just hold some utility methods (sorry!)
"
Class {
	#name : #SPMConvenience,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-GT'
}

{ #category : #'as yet unclassified' }
SPMConvenience class >> gtInspectorCodeListIn: composite title: title display: display [ 
	^ composite fastTable
		title: title;
		display: display;
		sortBlock: [ :a :b | a netTally > b netTally ];
		icon: [ :each | self ratioIcon: each ratio ];
		column: ''
			evaluated: [ :each | 
			'{1} [{2}]'
				format:
					{SPMConvenience printPercentage: each percentage.
					SPMConvenience printAbbreviatedDuration: each time} ]
			width: 150;
		column: 'Name' evaluated: [ :each | each fullName ]
]

{ #category : #printing }
SPMConvenience class >> printAbbreviatedDuration: aDuration [
	"Return a String with a human readable representation by:
	* truncating less significant part
	* using unit abbreviations 
	"

	^ String
		streamContents: [ :stream | self printAbbreviatedDuration: aDuration on: stream ]
]

{ #category : #printing }
SPMConvenience class >> printAbbreviatedDuration: aDuration on: stream [

	aDuration negative 
		ifTrue: [ 
			stream << '- '. 
			^ self printAbbreviatedDuration: aDuration abs on: stream ].
	#( (days 'd') 
		(hours 'h') 
		(minutes 'm') 
		(seconds 's') 
		(asMilliSeconds 'ms') 
		(asMicroseconds 'μs') 
		(asNanoSeconds 'ns')) do: [ :unit |
		| count |
		count := aDuration perform: unit first.
		count > 10 
			ifTrue: [
				count printWithCommasOn: stream.
				stream << unit second.
				^self  ] ].
	stream << '0ns'
]

{ #category : #printing }
SPMConvenience class >> printPercentage: aNumber [
	^ ((aNumber roundTo: 0.01) printShowingDecimalPlaces: 2), '%'
]

{ #category : #ui }
SPMConvenience class >> ratioBottomColor [
	^ Color green muchLighter
]

{ #category : #ui }
SPMConvenience class >> ratioColor: ratio [
	^ self ratioTopColor mixed: ratio with: self ratioBottomColor
]

{ #category : #ui }
SPMConvenience class >> ratioIcon: ratio [
	^ (FormCanvas extent: 16 @ 16)
		fillOval: (3 @ 3 extent: 11 @ 11)
			color: (self ratioColor: ratio)
			borderWidth: 0
			borderColor: Color transparent;
		form
]

{ #category : #ui }
SPMConvenience class >> ratioTopColor [
	^ Color red muchDarker
]
