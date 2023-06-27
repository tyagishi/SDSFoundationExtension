# SDSFoundationExtension
extensions for Foundation

## DurationStyleDayHourMinute
show duration like "?days ??:??:??"
```
let duration = Duration(secondsComponent: Int64(60.0*60.0*24.0*4.5), attosecondsComponent: 0)
XCTAssertEqual(duration.formatted(DurationStyleDayHourMinute()), "4days 12:00:00")
```

