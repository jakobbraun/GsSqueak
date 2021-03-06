housekeeping
fixObsoleteReferences
	"Smalltalk fixObsoleteReferences"
	

	Smalltalk garbageCollect; garbageCollect.

	Preference allInstances do: [:each || informee realName newInformee | 
		informee := each instVarNamed: #changeInformee.
		((informee isKindOf: Behavior)
			and: [informee isObsolete])
			ifTrue: [
				Transcript show: 'Preference: '; show: each name; cr.
				realName := (informee name copyReplaceAll: 'AnObsolete' with: '') asSymbol.
				newInformee := (informee environment declarationOf: realName) value.
				each instVarNamed: #changeInformee put: newInformee]].
 
	CompiledMethod allInstances do: [:method |
		| obsoleteBindings |
		obsoleteBindings := method literals select: [:literal |
			literal isVariableBinding
				and: [literal value isBehavior
				and: [literal value isObsolete]]].
		obsoleteBindings do: [:binding |
			| obsName realName realClass |
			obsName := binding value name.
			Transcript show: 'Binding: '; show: obsName; cr.
			realName := obsName copyReplaceAll: 'AnObsolete' with: ''.
			realClass := Smalltalk at: realName asSymbol ifAbsent: [UndefinedObject].
			binding isSpecialWriteBinding
				ifTrue: [binding privateSetKey: binding key value: realClass]
				ifFalse: [binding key: binding key value: realClass]]].

	Behavior flushObsoleteSubclasses.
	Smalltalk garbageCollect; garbageCollect.
	
