//
//  Date+JSON.swift
//  JSONShootout
//
//  Created by Bart Whiteley on 5/17/16.
//  Copyright © 2016 Bart Whiteley. All rights reserved.
//

import Foundation
import Marshal
import Mapper

// Support for Marshal
extension Date : ValueType {
    public static func value(from object: Any) throws -> Date {
        guard let dateString = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object))
        }
        guard let date = Date.fromISO8601String(dateString) else {
            throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: dateString)
        }
        return date
    }
}

extension Date {
    @nonobjc static let ISO8601SecondFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        let tz = TimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }()
    
    static func fromISO8601String(_ dateString:String) -> Date? {
        if let date = ISO8601SecondFormatter.date(from: dateString) {
            return date
        }
        return .none
    }
}


// Support for Mapper
extension Date: Convertible {
    public static func fromMap(_ value: Any) throws -> Date {
        guard let string = value as? String else {
            throw MapperError.convertibleError(value: value, type: String.self)
        }
        
        if let date = ISO8601SecondFormatter.date(from: string) {
            return date
        }

        throw MapperError.customError(field: nil, message: "'\(string)' is not a valid Date")
    }
}
