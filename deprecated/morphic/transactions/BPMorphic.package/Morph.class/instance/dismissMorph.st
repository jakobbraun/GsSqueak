meta-actions
dismissMorph
	"This is called from an explicit halo destroy/delete action.
	So first disconnect all constraints to keep the graph up to date."
	(self respondsTo: #disconnectAllConstraints)
		ifTrue: ["Connectors package"
			self perform: #disconnectAllConstraints].
	(self respondsTo: #releaseGraphModels)
		ifTrue: ["CGPrereqs package (Connectors)"
			self perform: #releaseGraphModels].
	self world
		ifNotNilDo: [:w | w abandonAllHalos; stopStepping: self].
	self delete