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
		do: [
			spec package: 'SaucoPerfMeter-Core'.
			spec package: 'SaucoPerfMeter-Spec2'.
			spec package: 'SaucoPerfMeter-Tests' ]
]
