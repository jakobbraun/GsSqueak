what to show
toggleShowDocumentation
	"Toggle the setting of the showingDocumentation flag, unless there are unsubmitted edits that the user declines to discard"

	| wasShowing |
	self okToChange ifTrue:
		[wasShowing := self showingDocumentation.
		self restoreTextualCodingPane.
		self showDocumentation: wasShowing not.
		self setContentsToForceRefetch.
		self contentsChanged]

