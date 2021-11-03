Extension { #name : #SPMCategoryPrefixColorMap }

{ #category : #'*SaucoPerfMeter-Spec2' }
SPMCategoryPrefixColorMap >> inspectionForColorAssociations: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Colors'>

	^ aBuilder newTable
		  items: self colorAssociations;
		  addColumn: ((SpImageTableColumn evaluated: [ :each | 
					    (Form extent: 16 asPoint depth: 32)
						    fillWithColor: each value;
						    yourself ])
				   beNotExpandable;
				   yourself);
		  addColumn:
		  (SpStringTableColumn
			   title: 'Category'
			   evaluated: [ :each | each key ]);
		  yourself
]
