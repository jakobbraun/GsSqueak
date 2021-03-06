setup
copyBitsRule41Test
	"Test possible use of rule 41, rgbComponentAlpha:with: Nothing to
	return, just set up some variables"
	| _gsSqueakTemp_gammaLookupTableOop _gsSqueakTemp_ungammaLookupTableOop |
	<inline: false>
	combinationRule = 41
		ifTrue: ["fetch the forecolor into componentAlphaModeColor."
			componentAlphaModeAlpha := 255.
			componentAlphaModeColor := 16777215.
			gammaLookupTable := nil.
			ungammaLookupTable := nil.
			interpreterProxy methodArgumentCount >= 2
				ifTrue: [componentAlphaModeAlpha := interpreterProxy stackIntegerValue: interpreterProxy methodArgumentCount - 2.
					interpreterProxy failed not
						ifFalse: [^ interpreterProxy primitiveFail].
					componentAlphaModeColor := interpreterProxy stackIntegerValue: interpreterProxy methodArgumentCount - 1.
					interpreterProxy failed not
						ifFalse: [^ interpreterProxy primitiveFail].
					interpreterProxy methodArgumentCount = 4
						ifTrue: [_gsSqueakTemp_gammaLookupTableOop := interpreterProxy stackObjectValue: 1.
							(interpreterProxy isBytes: _gsSqueakTemp_gammaLookupTableOop)
								ifTrue: [gammaLookupTable := interpreterProxy firstIndexableField: _gsSqueakTemp_gammaLookupTableOop].
							_gsSqueakTemp_ungammaLookupTableOop := interpreterProxy stackObjectValue: 0.
							(interpreterProxy isBytes: _gsSqueakTemp_ungammaLookupTableOop)
								ifTrue: [ungammaLookupTable := interpreterProxy firstIndexableField: _gsSqueakTemp_ungammaLookupTableOop]]]
				ifFalse: [interpreterProxy methodArgumentCount = 1
						ifTrue: [componentAlphaModeColor := interpreterProxy stackIntegerValue: 0.
							interpreterProxy failed not
								ifFalse: [^ interpreterProxy primitiveFail]]
						ifFalse: [^ interpreterProxy primitiveFail]]]