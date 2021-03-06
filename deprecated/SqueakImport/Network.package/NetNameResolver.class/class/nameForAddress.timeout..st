lookups
nameForAddress: hostAddress timeout: secs
	"Look up the given host address and return its name. Return nil if the lookup fails or is not completed in the given number of seconds. Depends on the given host address being known to the gateway, which may not be the case for dynamically allocated addresses."
	"NetNameResolver
		nameForAddress: (NetNameResolver addressFromString: '128.111.92.2')
		timeout: 30"

	| deadline |
	self initializeNetwork.
	deadline := Time utcMicrosecondClock + (secs * 1000000).
	"Protect the execution of this block, as the ResolverSemaphore is used for both parts of the transaction."
	^self resolverMutex critical: [
		(self waitForResolverReadyUntil: deadline) ifTrue: [
			self primStartLookupOfAddress: hostAddress.
			(self waitForCompletionUntil: deadline) ifTrue: [
				self primAddressLookupResult ] ] ]