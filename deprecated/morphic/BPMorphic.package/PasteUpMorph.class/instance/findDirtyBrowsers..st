world menu
findDirtyBrowsers: evt 
	"Present a menu of window titles for browsers with changes,
	and activate the one that gets chosen."
	| menu |
	menu := MenuMorph new.
	(SystemWindow
		windowsIn: self
		satisfying: [:w | (w model isKindOf: Browser)
				and: [w model canDiscardEdits not]])
		do: [:w | menu
				add: w label
				target: w
				action: #beKeyWindow].
	menu submorphs notEmpty
		ifTrue: [menu popUpEvent: evt in: self]