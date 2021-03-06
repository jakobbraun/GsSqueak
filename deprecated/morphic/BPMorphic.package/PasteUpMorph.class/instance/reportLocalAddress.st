world menu
reportLocalAddress
	"Report the local host address of this computer."
	| addrString m s |
	Socket initializeNetwork.
	addrString := NetNameResolver localAddressString.
	m := RectangleMorph new
				color: (Color
						r: 0.6
						g: 0.8
						b: 0.6);
				 extent: 118 @ 36;
				 borderWidth: 1.
	s := StringMorph contents: 'Local Host Address:'.
	s position: m position + (5 @ 4).
	m addMorph: s.
	s := StringMorph contents: addrString.
	s position: m position + (5 @ 19).
	m addMorph: s.
	self primaryHand attachMorph: m