Class {
	#name : #BaselineOfSaucoPerfMeter,
	#superclass : #BaselineOf,
	#category : #BaselineOfSaucoPerfMeter
}

{ #category : #baselines }
BaselineOfSaucoPerfMeter >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			package: 'SaucoPerfMeter-Core';
			package: 'SaucoPerfMeter-Spec2'
				with: [ spec requires: #( 'SaucoPerfMeter-Core' ) ];
			package: 'SaucoPerfMeter-Roassal3'
				with: [ spec requires: #( 'SaucoPerfMeter-Spec2' ) ];
			package: 'SaucoPerfMeter-Tests'
				with: [ spec requires: #( 'SaucoPerfMeter-Core' ) ] ]

]
