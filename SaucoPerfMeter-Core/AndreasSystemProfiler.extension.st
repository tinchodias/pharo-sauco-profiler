Extension { #name : #AndreasSystemProfiler }

{ #category : #'*SaucoPerfMeter-Core' }
AndreasSystemProfiler >> spmAsReport [
	^ SPMBuilder new
		tallyRoot: tallyRoot;
		totalTime: totalTime;
		build;
		report
]
