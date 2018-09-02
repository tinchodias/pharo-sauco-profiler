"
I am initialized for a register and generate colors for each of its code nodes.
"
Class {
	#name : #SPMCodeColorMap,
	#superclass : #Object,
	#instVars : [
		'colorByCodeMap'
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
			self deepRegister: code children colors: (self gradient: code children size from: color to: color muchDarker) ]
]

{ #category : #private }
SPMCodeColorMap >> gradient: count from: base to: next [
	^ (1 to: count) collect: [ :each | (base mixed: each / count with: next) darker ]
]

{ #category : #accessing }
SPMCodeColorMap >> initialize [
	super initialize.
	colorByCodeMap := Dictionary new
]

{ #category : #accessing }
SPMCodeColorMap >> initializeForReport: aReport [
	| colors categories relevantCount irrelevantCount |
	self initialize.
	categories := aReport allCategoryNodes.
	relevantCount := categories count: [ :each | each ratio > 0.03 ]. "TODO"
	irrelevantCount := categories size - relevantCount.
	colors := (Color wheel: relevantCount), (Array new: irrelevantCount withAll: Color gray).
	self deepRegister: categories colors: colors.
]