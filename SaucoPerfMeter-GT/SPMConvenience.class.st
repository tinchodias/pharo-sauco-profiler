"
I just hold some utility methods (sorry!)
"
Class {
	#name : #SPMConvenience,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-GT'
}

{ #category : #ui }
SPMConvenience class >> codeIcon: aSPMCodeNode [
	| colorMap |
	colorMap := SPMCodeColorMap forReport: aSPMCodeNode report.	"TODO"

	^ (FormCanvas extent: 16 @ 16)
		fillRectangle: (3 @ 3 extent: 11 @ 11)
			color: (colorMap colorAt: aSPMCodeNode)
"			borderWidth: 0
			borderColor: Color transparent";
		form
]

{ #category : #ui }
SPMConvenience class >> codeNameMorphFor: aSPMCodeNode [
	^ EpMorphFactory default
		rowWithAll:
			{(self codeIcon: aSPMCodeNode) asMorph.
			((aSPMCodeNode report isIrrelevantCodeNode: aSPMCodeNode)
				ifFalse: [ aSPMCodeNode fullName asMorph ]
				ifTrue: [ self shadowedTextFor: aSPMCodeNode fullName ])}
]

{ #category : #'gt inspector' }
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
					{(SPMConvenience printPercentage: each percentage).
					(SPMConvenience printAbbreviatedDuration: each time)} ]
			width: 150;
		column: 'Name' evaluated: [ :each | self codeNameMorphFor: each ] width: 400;
		column: 'Tags' evaluated: [ :each | ' ' join: each gtNameTags "TODO" ]
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

{ #category : #ui }
SPMConvenience class >> shadowedTextFor: aString [
	^ EpMorphFactory default stringFor: aString color: EpMorphFactory default softerTextColor
]

{ #category : #ui }
SPMConvenience class >> tallyNodeMorphFor: aSPMTallyNode [
	| contents |
	contents := Array
		streamContents: [ :stream | 
			stream
				nextPut:
					('{1} ({2})'
						format:
							{(SPMConvenience printPercentage: aSPMTallyNode percentage).
							(SPMConvenience printAbbreviatedDuration: aSPMTallyNode time)}) asMorph.
			stream nextPut: (self codeNameMorphFor: aSPMTallyNode methodNode).
			aSPMTallyNode netTally > 0
				ifTrue: [ stream
						nextPut: ('[{1} net]' format: {(SPMConvenience printAbbreviatedDuration: aSPMTallyNode netTime)}) asMorph ] ].
	^ EpMorphFactory default rowWithAll: contents
]
