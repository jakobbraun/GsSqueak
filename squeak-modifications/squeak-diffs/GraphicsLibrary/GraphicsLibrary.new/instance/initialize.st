as yet unclassified
initialize
	<messageSendsInEnv: 7>
	| calloutClass libraryClass |
	libraryClass := GemstoneSmalltalk _env0 classNamed: #CLibrary.
	calloutClass := GemstoneSmalltalk _env0 classNamed: #CCallout.
	graphicsLib := libraryClass _env0 named: '$GEMSTONE/lib/libgraFFIcs'.
	createWindowCo := calloutClass _env0
				library: graphicsLib
				name: #'ffi_create_window'
				result: #'ptr'
				args: #(#'uint32' #'uint32').
  drawWindowCo := calloutClass _env0
    library: graphicsLib
    name: #'ffi_draw_window'
    result: #'void'
    args: #(#'ptr' #'ptr').
  getSizeCo := calloutClass _env0
    library: graphicsLib
    name: #'ffi_get_window_size'
    result: #'void'
    args: #(#'ptr' #'ptr').
  setSizeCo := calloutClass _env0
    library: graphicsLib
    name: #'ffi_set_window_size'
    result: #'void'
    args: #(#'ptr' #'uint32' #'uint32').
  getEventsCo := calloutClass _env0
    library: graphicsLib
    name: #'ffi_process_events'
    result: #'void'
    args: #(#'ptr' #'ptr').
  displayStringCo := calloutClass _env0
    library: graphicsLib
    name: #'ffi_display_string'
    result: #'void'
    args: #(#'const char*' #'uint32' #'uint32' #'ptr' #'uint32' #'uint32').
  destroyWindowCo := calloutClass _env0
    library: graphicsLib
    name: #'ffi_destroy_window'
    result: #'void'
    args: #(#'ptr')
