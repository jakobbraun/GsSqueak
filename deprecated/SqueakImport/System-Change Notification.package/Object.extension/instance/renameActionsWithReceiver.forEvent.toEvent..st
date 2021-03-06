*System-Change Notification-events
renameActionsWithReceiver: anObject forEvent: anEventSelector toEvent: newEvent

	| oldActions newActions |
	oldActions := Set new.
	newActions := Set new.
	(self actionSequenceForEvent: anEventSelector) do: [ :action |
		action receiver == anObject
			ifTrue: [ oldActions add: anObject ]
			ifFalse: [ newActions add: anObject ]].
	self setActionSequence: (ActionSequence withAll: newActions) forEvent: anEventSelector.
	oldActions do: [ :act | self when: newEvent evaluate: act ].