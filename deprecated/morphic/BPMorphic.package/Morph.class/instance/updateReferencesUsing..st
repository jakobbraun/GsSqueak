copying
updateReferencesUsing: aDictionary 
	"Update intra-morph references within a composite morph that 
	has been copied. For example, if a button refers to morph X in 
	the orginal 
	composite then the copy of that button in the new composite 
	should refer to 
	the copy of X in new composite, not the original X. This default 
	implementation updates the contents of any morph-bearing slot. 
	It may be 
	overridden to avoid this behavior if so desired."
	| old |
	Morph instSize + 1
		to: self class instSize
		do: [:i | 
			old := self instVarAt: i.
			old isMorph
				ifTrue: [self
						instVarAt: i
						put: (aDictionary
								at: old
								ifAbsent: [old])]].
	extension
		ifNotNil: [extension updateReferencesUsing: aDictionary]