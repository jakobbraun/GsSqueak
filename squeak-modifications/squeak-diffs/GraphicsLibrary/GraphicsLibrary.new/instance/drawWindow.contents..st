as yet unclassified
drawWindow: aWindow contents: aBitmap
	<messageSendsInEnv: 0>
	drawWindowCo
		callWith: {
			aWindow.
			aBitmap _env7 asCByteArray }
