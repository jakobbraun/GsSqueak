instance creation
addDarkButtons: theme
	"self createDark apply."
	theme
		set: #borderColor for: #PluggableButtonMorph to: self darkContentSecondary;
		set: #color for: #PluggableButtonMorph to: self darkBackgroundHighlights;
		set: #textColor for: #PluggableButtonMorph to: self darkContentEmphasizedMore;

		set: #selectionModifier for: #PluggableButtonMorph to: [ [:c | c adjustBrightness: -0.1] ];
		set: #hoverModifier for: #PluggableButtonMorph to: [ [:c | c adjustBrightness: -0.1] ];
		set: #feedbackModifier for: #PluggableButtonMorph to: [ [:c | c adjustBrightness: -0.3] ].
	
	"And the plus-version."
	theme set: #disabledTextColor for: #PluggableButtonMorphPlus to: self darkContentSecondary.
