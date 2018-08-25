Class {
	#name : #BaselineOfSaucoPerfMeter,
	#superclass : #BaselineOf,
	#category : #BaselineOfSaucoPerfMeter
}

{ #category : #baselines }
BaselineOfSaucoPerfMeter >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec 
			project: 'Roassal2' with: [
				spec
					className: #ConfigurationOfRoassal2;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ].
		spec package: 'SaucoPerfMeter'. ].

]
