accessing
byteAt: index put: aByte

	| d r w bytes |
	bytes := self charSize.
	d := (index + bytes - 1) // bytes.
	r := (index - 1) \\ bytes + 1.
	w := (self wordAt: d) bitAnd: ((16rFF<<((bytes - r)*8)) bitInvert32).
	w := w + (aByte<<((bytes - r)*8)).
	self basicAt: d put: w.
	^ aByte.
