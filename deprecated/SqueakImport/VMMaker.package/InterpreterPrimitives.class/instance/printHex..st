debug printing
printHex: n
	"Print n in hex,  in the form '    0x1234', padded to a width of 10 characters
	 in 32-bits ('0x' + 8 nibbles) or 18 characters in 64-bits ('0x' + 16 nibbles)"
	<api>
	| len buf |
	<var: #buf declareC: 'char buf[35]'> "large enough for a 64-bit value in hex plus the null plus 16 spaces"
	self cCode: 'memset(buf,'' '',34)' inSmalltalk: [buf := 'doh!'].
	len := self cCode: 'sprintf(buf + 2 + 2 * BYTES_PER_WORD, "0x%lx", (unsigned long)(n))'.
	self cCode: 'printf("%s", buf + len)'.
	len touch: buf