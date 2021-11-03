"
I just hold some utility methods (sorry!)
"
Class {
	#name : #SaConvenience,
	#superclass : #Object,
	#category : #'SaucoPerfMeter-Spec2'
}

{ #category : #ui }
SaConvenience class >> codeIcon: aSaCodeNode [

	^ (FormCanvas extent: 16 @ 16)
		fillRectangle: (3 @ 3 extent: 11 @ 11)
			color: aSaCodeNode codeColor
"			borderWidth: 0
			borderColor: Color transparent";
		form
]

{ #category : #ui }
SaConvenience class >> codeNameMorphFor: aSaCodeNode [
	^ EpMorphFactory default rowWithAll: {
			(self codeIcon: aSaCodeNode) asMorph.
			aSaCodeNode fullName asMorph.
			"(aSaCodeNode isRelevant
				ifTrue: [ aSaCodeNode fullName asMorph ]
				ifFalse: [ self shadowedTextFor: aSaCodeNode fullName ])" }
]

{ #category : #ui }
SaConvenience class >> inspectionCodeList: aBuilder items: itemsCollection [

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
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | self codeIcon: each ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | each fullName ])
			width: 400;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :each | ' ' join: each nameTags ])
]

{ #category : #printing }
SaConvenience class >> multipleLineDescriptionFor: aSaTallyNode [ 

	^ '{1}
Method: 		{2}
Category: 	{3}' format: {
		aSaTallyNode relevanceDescription.
		aSaTallyNode methodNode fullName.
		aSaTallyNode methodNode nameTags asCommaString.
		}
]

{ #category : #printing }
SaConvenience class >> printPercentage: aNumber [
	^ ((aNumber roundTo: 0.01) printShowingDecimalPlaces: 2), '%'
]

{ #category : #ratio }
SaConvenience class >> ratioBottomColor [

	^ Color darkGray
]

{ #category : #ratio }
SaConvenience class >> ratioIcon: ratio [

	^ (FormCanvas extent: 20 @ 10)
		fillColor: self ratioBottomColor;
		drawRectangle: (1 @ 1 extent: (ratio * 20) @ 10)
			color: self ratioTopColor
			borderWidth: 4
			borderColor: self ratioTopColor;
		form

]

{ #category : #ratio }
SaConvenience class >> ratioTopColor [

	^ Color yellow
]

{ #category : #printing }
SaConvenience class >> relevanceDescription: aNode [

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
SaConvenience class >> shadowedTextFor: aString [
	^ EpMorphFactory default stringFor: aString color: EpMorphFactory default softerTextColor
]

{ #category : #ui }
SaConvenience class >> tallyNodeMorphFor: aSaTallyNode [

	| contents |
	contents := {
		aSaTallyNode relevanceDescription asMorph.
		(self codeNameMorphFor: aSaTallyNode methodNode) }.

	^ EpMorphFactory default rowWithAll: contents
]
