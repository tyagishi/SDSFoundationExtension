//
//  ScheduledPublisher.swift
//  SDSFoundationExtension
//
//  Created by Tomoaki Yagishita on 2025/08/02.
//

import Foundation
import Combine

/// TimerPublisher which will start from specified Date
public class ScheduledPublisher: Publisher {
    public typealias Output = Date
    public typealias Failure = Never

    let internalPublisher = PassthroughSubject<Date,Never>()

    let initialTrigger: Date
    let repeatInterval: TimeInterval?
    var cancellable: AnyCancellable? = nil

    public init(firstAt: Date, repeatInterval: TimeInterval? = nil) {
        self.initialTrigger = firstAt
        self.repeatInterval = repeatInterval
        let timer = Timer.init(fire: initialTrigger, interval: 100, repeats: false) { timer in
            self.internalPublisher.send(Date())
            timer.invalidate()
            self.setupRepeat()
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    public init(delayFor: TimeInterval, repeatInterval: TimeInterval? = nil) {
        self.initialTrigger = Date().advanced(by: delayFor)
        self.repeatInterval = repeatInterval
        let timer = Timer.init(fire: initialTrigger, interval: 100, repeats: false) { timer in
            self.internalPublisher.send(Date())
            timer.invalidate()
            self.setupRepeat()
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    @available(macOS 13, iOS 16, *)
    public init(firstAt: Date, repeatDuration: Duration? = nil) {
        self.initialTrigger = firstAt
        self.repeatInterval = repeatDuration?.timeInterval
        let timer = Timer.init(fire: initialTrigger, interval: 100, repeats: false) { timer in
            self.internalPublisher.send(Date())
            timer.invalidate()
            self.setupRepeat()
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    @available(macOS 13, iOS 16, *)
    public init(delayFor: Duration, repeatDuration: Duration? = nil) {
        self.initialTrigger = Date().advanced(by: delayFor.timeInterval)
        self.repeatInterval = repeatDuration?.timeInterval
        let timer = Timer.init(fire: initialTrigger, interval: 100, repeats: false) { timer in
            self.internalPublisher.send(Date())
            timer.invalidate()
            self.setupRepeat()
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    func setupRepeat() {
        if let repeatInterval {
            cancellable = Timer.TimerPublisher(interval: repeatInterval, runLoop: .main, mode: .common)
                .autoconnect()
                .sink { newDate in
                    self.internalPublisher.send(newDate)
                }
        }
    }
    public func stop() {
        cancellable?.cancel()
        cancellable = nil
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Date == S.Input {
        internalPublisher.receive(subscriber: subscriber)
    }
}

extension Timer {
    public static func schedulePublisher(firstAt: Date, repeatInterval: TimeInterval?) -> ScheduledPublisher {
        ScheduledPublisher(firstAt: firstAt, repeatInterval: repeatInterval)
    }
    public static func schedulePublisher(delayFor: TimeInterval, repeatInterval: TimeInterval?) -> ScheduledPublisher {
        ScheduledPublisher(delayFor: delayFor, repeatInterval: repeatInterval)
    }
    @available(macOS 13, iOS 16, *)
    public static func schedulePublisher(firstAt: Date, repeatDuration: Duration?) -> ScheduledPublisher {
        ScheduledPublisher(firstAt: firstAt, repeatDuration: repeatDuration)
    }
    @available(macOS 13, iOS 16, *)
    public static func schedulePublisher(delayFor: Duration, repeatDuration: Duration?) -> ScheduledPublisher {
        ScheduledPublisher(delayFor: delayFor, repeatDuration: repeatDuration)
    }
}
