other
orderedCrayonColors
	"self orderedCrayonColors explore."
	^ OrderedDictionary
		newFrom: (#(#cantaloupe #honeydew #spindrift #sky #lavender #carnation #licorice #snow #salmon #banana #flora #ice #orchid #bubblegum #lead #mercury #tangerine #lime #seaFoam #aqua #grape #strawberry #tungsten #silver #maraschino #lemon #spring #turquoise #blueberry #magenta #iron #magnesium #mocha #fern #moss #ocean #eggplant #maroon #steel #aluminum #cayenne #asparagus #clover #teal #midnight #plum #tin #nickel )
				collect: [:ea | ea
						-> (self perform: ea)])