*System-Changes-fileIn/Out
checkForPreamble: chunk
	((chunk beginsWith: '"Change Set:') and: [ChangeSet current preambleString == nil])
		ifTrue: [ChangeSet current preambleString: chunk].
	((chunk beginsWith: '"Postscript:') and: [ChangeSet current postscriptString == nil])
		ifTrue: [ChangeSet current postscriptString: chunk].
							
