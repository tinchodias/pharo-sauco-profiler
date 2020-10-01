"
I am initialized for a register and generate colors for each of its code nodes.
"
Class {
	#name : #SPMCodeColorMap,
	#superclass : #Object,
	#instVars : [
		'colorByCodeMap',
		'theme'
	],
	#category : #'SaucoPerfMeter-GT'
}

{ #category : #'instance creation' }
SPMCodeColorMap class >> forReport: aSPMReport [
	^ self basicNew
		initializeForReport: aSPMReport;
		yourself
]

{ #category : #accessing }
SPMCodeColorMap >> colorAt: aCode [
	^ colorByCodeMap at: aCode
]

{ #category : #private }
SPMCodeColorMap >> deepRegister: aCodeCollection colors: colors [
	aCodeCollection ifEmpty: [ ^ self ].
	colors
		withIndexDo: [ :color :index | 
			| code |
			code := aCodeCollection at: index.
			colorByCodeMap at: code put: color.
			self
				deepRegister: code children
				colors: (self gradient: code children size from: color to: (color alpha: 0.5)) ]
]

{ #category : #private }
SPMCodeColorMap >> gradient: count from: base to: next [
	^ (1 to: count) collect: [ :each | (base mixed: each / count with: next) alpha: 0.75 ]
]

{ #category : #accessing }
SPMCodeColorMap >> initialize [
	super initialize.
	colorByCodeMap := Dictionary new.
	theme := Smalltalk ui theme.
]

{ #category : #accessing }
SPMCodeColorMap >> initializeForReport: aReport [
	| colors categories relevantCount irrelevantCount |
	self initialize.
	categories := aReport allCategoryNodes.
	relevantCount := categories count: [ :each | (aReport isIrrelevantCodeNode: each) not ].
	irrelevantCount := categories size - relevantCount.
	colors := (Color wheel: relevantCount), (Array new: irrelevantCount withAll: theme disabledTextColor).
	self deepRegister: categories colors: colors.
]
