class initialization
initialize
	"Initialize the scripting system.  Sometimes this method is vacuously changed just to get it in a changeset so that its invocation will occur as part of an update"

	(self environment at: #ScriptingSystem ifAbsent: [nil]) ifNil:
		[self environment at: #ScriptingSystem put: self new].

	ScriptingSystem
		initializeHelpStrings.

	self registerInFlapsRegistry.
	
	"on GsSqueak bootstrap, there is no FormDictionary"
	FormDictionary ifNil: [
    	FormDictionary := IdentityDictionary new ].
    	
    self initializeForms

"StandardScriptingSystem initialize"
