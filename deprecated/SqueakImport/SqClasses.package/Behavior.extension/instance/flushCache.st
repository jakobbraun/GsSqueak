*SqClasses-private
flushCache
	"Tell the interpreter to remove the contents of its method lookup cache, if it has 
	one.  Essential.  See Object documentation whatIsAPrimitive."

	self _env0 _codeChangedForEnv: 7
