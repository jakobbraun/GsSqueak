removing
removeAlarmWithReceiver: receiver selector: selector

	^heap
		detect: [ :each | each receiver == receiver and: [ each selector == selector ] ]
		ifFound: [ :found | heap remove: found ]
		ifNone: [ ]