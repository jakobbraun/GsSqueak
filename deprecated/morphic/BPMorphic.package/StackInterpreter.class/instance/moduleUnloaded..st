initialization
moduleUnloaded: aModuleName 
	"The module with the given name was just unloaded. 
	Make sure we have no dangling references."
	(aModuleName strcmp: 'SurfacePlugin')
			= 0
		ifTrue: ["Surface plugin went away. Should never happen. But then,
			who knows"
			showSurfaceFn := 0]