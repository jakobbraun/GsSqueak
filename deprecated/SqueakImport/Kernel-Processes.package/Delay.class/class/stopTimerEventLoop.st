timer process
stopTimerEventLoop
	"Stop the timer event loop"
	RunTimerEventLoop := false.

    "During GsSqueak bootstrap this code runs before the
    TimingSemaphore is created"
    TimingSemaphore ifNotNil: [
        TimingSemaphore signal ].
	TimerEventLoop := nil.
