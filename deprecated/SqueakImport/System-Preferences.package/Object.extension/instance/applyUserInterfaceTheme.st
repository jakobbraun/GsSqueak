*System-Preferences
applyUserInterfaceTheme
	"A new UserInterfaceTheme has been asked to #apply itself onto the current desktop.  The receiver should do what is necessary to change its colors on the screen, update its fonts, form images, etc., if the current UserInterfaceTheme specifies overrides for those values.
	
	Only subclasses which implement new #themeProperties on the class-side should implement this method.
	Implementors of this method should not call 'super applyUserInterfaceTheme'.

	The default implementation does nothing."