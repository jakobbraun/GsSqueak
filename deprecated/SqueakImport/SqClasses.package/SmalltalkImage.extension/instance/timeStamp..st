*SqClasses-*SqClasses-*SqClasses-sources, changes log
timeStamp: aStream 
	"Writes system version and current time on stream aStream."

	| dateTime |
	dateTime := Time dateAndTimeNow.
	aStream nextPutAll: 'From ', self datedVersion, ' [', self lastUpdateString, '] on ', (dateTime at: 1) printString,
						' at ', (dateTime at: 2) printString
