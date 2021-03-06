debug printing
printStackPage: page
	<inline: false>
	<var: #page type: #'StackPage *'>
	self print: 'page '; printHexPtr: (self cCode: [page] inSmalltalk: [page baseAddress]);
		print: ' ('; printNum: (stackPages pageIndexFor: page realStackLimit);
		print: ')  (trace: '; printNum: page trace; printChar: $).
	(stackPages isFree: page) ifTrue:
		[self print: ' (free)'].
	page = stackPages mostRecentlyUsedPage ifTrue:
		[self print: ' (MRU)'].
	self cr; tab;
		printHexPtr: page baseAddress; print: ' - ';
		printHexPtr: page realStackLimit; print: ' - ';
		printHexPtr: page lastAddress.
	(stackPages isFree: page) ifFalse:
		[self cr; tab; print: 'baseFP '; printHexPtr: page baseFP.
		 self "cr;" tab; print: 'headFP '; printHexPtr: page headFP.
		 self "cr;" tab; print: 'headSP '; printHexPtr: page headSP].
	self cr; tab; print: 'prev '; printHexPtr: (self cCode: 'page->prevPage' inSmalltalk: [page prevPage baseAddress]);
		print: ' ('; printNum: (stackPages pageIndexFor: page prevPage realStackLimit); printChar: $).
	self tab; print: 'next '; printHexPtr: (self cCode: 'page->nextPage' inSmalltalk: [page nextPage baseAddress]);
		print: ' ('; printNum: (stackPages pageIndexFor: page nextPage realStackLimit); printChar: $).
	self cr