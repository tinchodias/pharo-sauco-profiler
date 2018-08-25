Extension { #name : #MessageTally }

{ #category : #'*SaucoPerfMeter-Core' }
MessageTally >> spmAsReport [
	^ SPMBuilder new
		tallyRoot: self;
		totalTime: time;
		build;
		report
]
