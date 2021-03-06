layout-menu
layoutMenuPropertyString: aSymbol from: currentSetting 
	| onOff wording |
	onOff := aSymbol == currentSetting
				ifTrue: ['<on>']
				ifFalse: ['<off>'].
	""
	wording := String
				streamContents: [:stream | 
					| index |
					index := 1.
					aSymbol
						keysAndValuesDo: [:idx :ch | ch isUppercase
								ifTrue: [""
									stream nextPutAll: (aSymbol copyFrom: index to: idx - 1) asLowercase.
									stream nextPutAll: ' '.
									index := idx]].
					index < aSymbol size
						ifTrue: [stream nextPutAll: (aSymbol copyFrom: index to: aSymbol size) asLowercase]].
	""
	^ onOff , wording translated