# SDSFoundationExtension
extensions for Foundation

## ScheduledPublisher
timer which starts at spcified date, then repeats (iff necessary)
```
Timer.schedulePublisher(firstAt: Calendar.date(2025,1,1,hour:9,minute:0,second:0), repeatDuration: .minutes(30))
.sink({ _ 
    // every 30 min alarm it starts from 2025.Jan.1st 9:00:00am
}).store(in: &cancellables)
```

## Duration.init
### from seconds
attoseconds part will be calced automatically
```
extension Duration {
  public init(seconds value: Double)
}
```

### from two Dates
init from diff between two dates
```
extension Duration {
    public init(from fromDate: Date, to toDate: Date)
}
```

## DurationStyleDayHourMinute
show duration like "?days ??:??:??"
```
let duration = Duration(secondsComponent: Int64(60.0*60.0*24.0*4.5), attosecondsComponent: 0)
XCTAssertEqual(duration.formatted(DurationStyleDayHourMinute()), "4days 12:00:00")
```

## Bundle.versionBuildString
retrieve app version and build number

```
if let (ver,build) = Bundle.versionBuildString {
    Text("version: \(ver) build: \(build)")
}
```

