//
//  NSDate+JSON.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Foundation
import Marshal
import Mapper

// Support for Marshal
extension NSDate : ValueType {
    public static func value(object: Any) throws -> NSDate {
        guard let dateString = object as? String else {
            throw Error.TypeMismatch(expected: String.self, actual: object.dynamicType)
        }
        guard let date = NSDate.fromISO8601String(dateString) else {
            throw Error.TypeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}

extension NSDate {
    @nonobjc static let ISO8601SecondFormatter:NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        let tz = NSTimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }()
    
    static func fromISO8601String(dateString:String) -> NSDate? {
        if let date = ISO8601SecondFormatter.dateFromString(dateString) {
            return date
        }
        return .None
    }
}


// Support for Mapper
extension NSDate: Convertible {
    @warn_unused_result
    public static func fromMap(value: AnyObject?) throws -> NSDate {
        guard let string = value as? String else {
            throw MapperError.ConvertibleError(value: value, type: String.self)
        }
        
        if let date = ISO8601SecondFormatter.dateFromString(string) {
            return date
        }

        throw MapperError.CustomError(field: nil, message: "'\(string)' is not a valid Date")
    }
}
