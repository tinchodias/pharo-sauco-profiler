Extension { #name : #SPMMethodNode }

{ #category : #'*SaucoPerfMeter-GT' }
SPMMethodNode >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ (self
		compiledMethodInCurrentImageIfPresent: [ :method | method gtInspectorSourceIn: composite ]
		ifAbsent: [ composite display: [ '-- Not found --' ] ])
			title: 'Source in current image';
			yourself
]

{ #category : #'*SaucoPerfMeter-GT' }
SPMMethodNode >> gtNameTags [
	^ { self categoryName }
]
