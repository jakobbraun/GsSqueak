private
formatNoPattern: noPattern ifFail: failBlock
	^(self parser _env0
		parseCue: cue 
		noPattern: noPattern
		ifFail: [^failBlock value]) preen
