removing
removeAllAlarmsBefore: nowTime 
	^ Array
		new: 10
		streamContents: [:stream | [heap notEmpty
				and: [heap first scheduledTime < nowTime]]
				whileTrue: [stream nextPut: heap removeFirst]]