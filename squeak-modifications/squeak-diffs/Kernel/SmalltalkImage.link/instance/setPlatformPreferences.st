snapshot and quit
setPlatformPreferences
	"Set some platform specific preferences on system startup"
	| platform specs |
	Preferences automaticPlatformSettings ifFalse:[^self].
	platform := self platformName.
	specs := 	#().
	platform = 'Win32' ifTrue:[
		specs := #()].
	platform = 'Mac OS' ifTrue:[
		specs := #()].
	specs do:[:tuple|
		Preferences setPreference: tuple first toValue: (tuple last == true).
	].
