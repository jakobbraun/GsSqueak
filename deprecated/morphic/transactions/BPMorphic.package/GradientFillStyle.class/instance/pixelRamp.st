accessing
pixelRamp
	"Compute a pixel ramp, and cache it for future accesses"
	^ pixelRamp
		ifNil: ["Insure the PixelRampCache is in place"
			PixelRampCache
				ifNil: [self class initPixelRampCache].
			"Ask my cache for an existing instance if one is available"
			pixelRamp := PixelRampCache at: colorRamp deepCopy]