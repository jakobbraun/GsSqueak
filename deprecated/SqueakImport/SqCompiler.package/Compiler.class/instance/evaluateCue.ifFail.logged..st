private
evaluateCue: aCue ifFail: failBlock logged: logFlag
	"Compiles the cue source into a parse tree, then generates code into
	a method. Finally, the compiled method is invoked from here via 	withArgs:executeMethod:, hence the system no longer creates Doit method
	litter on errors."

	| value |

	self flag: #'hack'.

	value := self evaluateCue: aCue ifFail: [^failBlock value].
	"logFlag ifTrue:
		[SystemChangeNotifier uniqueInstance evaluated: cue stringToLog context: cue context]."
	^ value
