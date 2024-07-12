Extension { #name : #RSTAnnounceable }

{ #category : #'*SaucoPerfMeter-Pharo11' }
RSTAnnounceable >> when: event do: aBlock for: aSubscriber [
	"Sauco extension for backwards-compatibility on Pharo 11"

	^ self when: event do: aBlock
]
