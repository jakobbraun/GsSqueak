message sending
internalFindNewMethodOuter: depth 
	"Find the compiled method to be run when the current
	messageSelector is sent to the depth'th enclosing object w/r/t the
	mixin of the current method, setting the values of 'newMethod' and
	'primitiveIndex'. "
	localAbsentReceiver := self receiver.
	self
		deny: (objectMemory isOopForwarded: localAbsentReceiver).
	lkupClassTag := objectMemory fetchClassTagOf: localAbsentReceiver.
	(self
			inlineLookupInNSMethodCacheSel: messageSelector
			classTag: lkupClassTag
			method: method
			lookupRule: depth)
		ifTrue: [localAbsentReceiverOrZero = 0
				ifFalse: [localAbsentReceiver := localAbsentReceiverOrZero]]
		ifFalse: [| actualLookupRule |
			"entry was not found in the cache; look it up the hard way"
			self externalizeIPandSP.
			((objectMemory isOopForwarded: messageSelector)
					or: [objectMemory isForwardedClassTag: lkupClassTag])
				ifTrue: [(objectMemory isOopForwarded: messageSelector)
						ifTrue: [messageSelector := self handleForwardedSelectorFaultFor: messageSelector].
					(objectMemory isForwardedClassTag: lkupClassTag)
						ifTrue: [lkupClassTag := self handleForwardedSendFaultForTag: lkupClassTag]].
			lkupClass := objectMemory classForClassTag: lkupClassTag.
			actualLookupRule := self lookupOuterSend: depth.
			self internalizeIPandSP.
			self addNewMethodToNSCache: actualLookupRule]