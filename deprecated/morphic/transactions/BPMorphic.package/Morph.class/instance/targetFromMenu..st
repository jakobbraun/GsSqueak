meta-actions
targetFromMenu: aMenu 
	"Some other morph become target of the receiver"
	| newTarget |
	newTarget := aMenu startUpWithCaption: self externalName , ' targets...'.
	newTarget
		ifNil: [^ self].
	self target: newTarget