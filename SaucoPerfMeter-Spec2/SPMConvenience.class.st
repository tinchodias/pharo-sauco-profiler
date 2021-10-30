"
I just hold some utility methods (sorry!)
"
Class {
	#name : #SPMConvenience,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-Spec2'
}

{ #category : #ui }
SPMConvenience class >> codeIcon: aSPMCodeNode [

	^ (FormCanvas extent: 16 @ 16)
		fillRectangle: (3 @ 3 extent: 11 @ 11)
			color: aSPMCodeNode codeColor
"			borderWidth: 0
			borderColor: Color transparent";
		form
]

{ #category : #ui }
SPMConvenience class >> codeNameMorphFor: aSPMCodeNode [
	^ EpMorphFactory default rowWithAll: {
			(self codeIcon: aSPMCodeNode) asMorph.
			(aSPMCodeNode isRelevant
				ifTrue: [ aSPMCodeNode fullName asMorph ]
				ifFalse: [ self shadowedTextFor: aSPMCodeNode fullName ]) }
]

{ #category : #ui }
SPMConvenience class >> inspectionCodeList: aBuilder items: itemsCollection [

	^ aBuilder newTable
		items: itemsCollection asArray; "It doesn't work with Set, for example."
		sortingBlock: [ :a :b | a netTally > b netTally ];
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | self ratioIcon: each ratio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | self codeNameMorphFor: each ])
			width: 400;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :each | ' ' join: each nameTags ])
]

{ #category : #printing }
SPMConvenience class >> multipleLineDescriptionFor: aSPMTallyNode [ 

	^ '{1}
Method: {2}
Tags: {3}' format: {
		aSPMTallyNode relevanceDescription.
		aSPMTallyNode methodNode fullName.
		aSPMTallyNode methodNode nameTags asCommaString.
		}
]

{ #category : #printing }
SPMConvenience class >> printPercentage: aNumber [
	^ ((aNumber roundTo: 0.01) printShowingDecimalPlaces: 2), '%'
]

{ #category : #ratio }
SPMConvenience class >> ratioBottomColor [

	^ Color darkGray
]

{ #category : #ratio }
SPMConvenience class >> ratioIcon: ratio [

	^ (FormCanvas extent: 20 @ 10)
		fillColor: self ratioBottomColor;
		drawRectangle: (1 @ 1 extent: (ratio * 20) @ 10)
			color: self ratioTopColor
			borderWidth: 4
			borderColor: self ratioTopColor;
		form

]

{ #category : #ratio }
SPMConvenience class >> ratioTopColor [

	^ Color yellow
]

{ #category : #printing }
SPMConvenience class >> relevanceDescription: aNode [

	| output |
	output := '{1} [{2}]' format: { 
			  (self printPercentage: aNode percentage).
			  (aNode report durationPrinter print: aNode time) }.
	
	(aNode hasChildren and: [ aNode netTally > 0 ]) ifTrue: [
		output := output, ' ({1} net)' format: {
			aNode report durationPrinter print: aNode netTime } ].

	^ output

]

{ #category : #ui }
SPMConvenience class >> shadowedTextFor: aString [
	^ EpMorphFactory default stringFor: aString color: EpMorphFactory default softerTextColor
]

{ #category : #ui }
SPMConvenience class >> tallyNodeMorphFor: aSPMTallyNode [

	| contents |
	contents := {
		aSPMTallyNode relevanceDescription asMorph.
		(self codeNameMorphFor: aSPMTallyNode methodNode) }.

	^ EpMorphFactory default rowWithAll: contents
]
