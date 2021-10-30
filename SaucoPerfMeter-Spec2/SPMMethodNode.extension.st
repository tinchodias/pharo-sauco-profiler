Extension { #name : #SPMMethodNode }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMMethodNode >> inspectionForSource: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Source in current image'>

	^ self
		  compiledMethodInCurrentImageIfPresent: [ :method | 
			  method inspectionSource ]
		  ifAbsent: [ 
			  aBuilder newLabel
				  label: '-- Not found --';
				  yourself ]
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMMethodNode >> inspectionForTallyNodes: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Tally Nodes'>

	| topTen |
	topTen := tallyNodes sorted: [ :a :b | a netTally > b netTally ].

	^ aBuilder newTable
		items: topTen;
		addColumn: ((SpImageTableColumn
			evaluated: [ :each | SPMConvenience ratioIcon: each ratio ]) 
			beNotExpandable;
			yourself);
		addColumn: ((SpStringTableColumn 
			evaluated: [ :each | each relevanceDescription ])
			width: 150;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Net Tally'
			evaluated: [ :each | each netTally ]);
		addColumn: ((SpStringTableColumn 
			title: 'Name'
			evaluated: [ :each | SPMConvenience codeNameMorphFor: each methodNode ])
			width: 400;
			yourself);
		addColumn: (SpStringTableColumn
			title: 'Tags'
			evaluated: [ :each | ' ' join: each methodNode nameTags ]);
		addColumn: (SpStringTableColumn
			title: 'Is leaf?'
			evaluated: [ :each | each hasChildren ifTrue: [ 'No' ] ifFalse: [ 'Yes' ] ]);
		yourself
]

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMMethodNode >> nameTags [

	^ { self categoryName }
]
