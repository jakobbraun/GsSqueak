world menu
findAFileList: evt 
	"Bring a file list to the foreground, reusing an existing one if possible."
	self
		findAWindowSatisfying: [ : aWindow | (aWindow model class = FileList) and: [ aWindow model hasUnacceptedEdits not ] ]
		orMakeOneUsing: [ FileList prototypicalToolWindow openInWorld ]