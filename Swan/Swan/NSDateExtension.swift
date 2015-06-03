//
//  NSDateExtension.swift
//  Swan
//
//  Created by Antti Laitala on 22/05/15.
//
//

import Foundation

// MARK: Comparable

extension NSDate: Comparable { }

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSinceDate(rhs) < 0
}

// MARK: Helpers

public extension NSDate {
    
    var second: Int {
        return NSCalendar.mainThreadSharedCalendar().component(.CalendarUnitSecond, fromDate: self)
    }
    
    var minute: Int {
        return NSCalendar.mainThreadSharedCalendar().component(.CalendarUnitMinute, fromDate: self)
    }
    
    var hour: Int {
        return NSCalendar.mainThreadSharedCalendar().component(.CalendarUnitHour, fromDate: self)
    }
    
    var day: Int {
        return NSCalendar.mainThreadSharedCalendar().component(.CalendarUnitDay, fromDate: self)
    }
    
    var month: Int {
        return NSCalendar.mainThreadSharedCalendar().component(.CalendarUnitMonth, fromDate: self)
    }
    
    var year: Int {
        return NSCalendar.mainThreadSharedCalendar().component(.CalendarUnitYear, fromDate: self)
    }
    
    func midnight() -> NSDate {
        let calendar = NSCalendar.mainThreadSharedCalendar()
        let comps = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        return calendar.dateFromComponents(comps)!
    }
    
    func noon() -> NSDate {
        let calendar = NSCalendar.mainThreadSharedCalendar()
        let comps = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        comps.hour = 12
        return calendar.dateFromComponents(comps)!
    }
    
}

// MARK: Date Arithmetic

public struct TimeUnit {
    
    let unit: NSCalendarUnit
    let duration: Int
    
    init(_ unit: NSCalendarUnit, duration: Int) {
        self.unit = unit
        self.duration = duration
    }
    
}

public func +(lhs: NSDate, rhs: TimeUnit) -> NSDate {
    return NSCalendar.mainThreadSharedCalendar().dateByAddingUnit(rhs.unit, value: rhs.duration, toDate: lhs, options: .allZeros)!
}

public func +=(inout lhs: NSDate, rhs: TimeUnit) {
    lhs = NSCalendar.mainThreadSharedCalendar().dateByAddingUnit(rhs.unit, value: rhs.duration, toDate: lhs, options: .allZeros)!
}

public func -(lhs: NSDate, rhs: TimeUnit) -> NSDate {
    return NSCalendar.mainThreadSharedCalendar().dateByAddingUnit(rhs.unit, value: -rhs.duration, toDate: lhs, options: .allZeros)!
}

public func -=(inout lhs: NSDate, rhs: TimeUnit) {
    lhs = NSCalendar.mainThreadSharedCalendar().dateByAddingUnit(rhs.unit, value: -rhs.duration, toDate: lhs, options: .allZeros)!
}