as yet unclassified
deadlineSecs: secs
  "Return a deadline time the given number of seconds from now."

  self
    deprecated:
      'Using this method may result in clock rollover related bug. Don''t use it.'.
  ^ Time millisecondClockValue + (secs * 1000) truncated