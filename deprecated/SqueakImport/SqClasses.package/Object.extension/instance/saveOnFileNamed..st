*SqClasses-objects from disk
saveOnFileNamed: filenameString
	"Save myself on a SmartReferenceStream file.  Writes out the version and class structure.  The file is fileIn-able.  UniClasses will be filed out."
	| fileStream |
	fileStream := FileStream newFileNamed: filenameString.
	fileStream fileOutClass: nil andObject: self.	"Puts UniClass definitions out anyway, and closes the stream."
