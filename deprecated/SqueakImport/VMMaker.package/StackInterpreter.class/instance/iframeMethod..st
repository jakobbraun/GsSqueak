frame access
iframeMethod: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages longAt: theFP + FoxMethod