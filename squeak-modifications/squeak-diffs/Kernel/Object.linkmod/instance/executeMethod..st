message handling
executeMethod: compiledMethod
	"Execute compiledMethod against the receiver with no args"

	^ self _env0 performMethod: compiledMethod
