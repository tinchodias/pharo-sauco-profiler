Class {
	#name : #BaselineOfSaucoPerfMeter,
	#superclass : #BaselineOf,
	#category : #BaselineOfSaucoPerfMeter
}

{ #category : #baselines }
BaselineOfSaucoPerfMeter >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				baseline: 'Roassal2'
				with: [ spec repository: 'github://ObjectProfile/Roassal2/src' ].
			spec package: 'SaucoPerfMeter-Core'.
			spec package: 'SaucoPerfMeter-GT'.
			spec package: 'SaucoPerfMeter-Tests' ]
]
