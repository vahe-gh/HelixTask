//
//  Date+Localized.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium,
                              in timeZone: TimeZone = .current,
                              locale: Locale = .current) -> String {
        
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    
    var localizedDescription: String { return localizedDescription() }
}

extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}

extension Formatter {
    static let date = DateFormatter()
}

extension Date {
    var fullDate:  String { return localizedDescription(dateStyle: .full, timeStyle: .none)  }
    var shortDate: String { return localizedDescription(dateStyle: .short, timeStyle: .none)  }
    var fullTime:  String { return localizedDescription(dateStyle: .none, timeStyle: .full)  }
    var shortTime: String { return localizedDescription(dateStyle: .none, timeStyle: .short)   }
    var fullDateTime:  String { return localizedDescription(dateStyle: .full, timeStyle: .full)  }
    var shortDateTime: String { return localizedDescription(dateStyle: .short, timeStyle: .short)  }
}

// For non-optional
extension Date {
    func localizedDescriptionForClient(dateStyle: DateFormatter.Style = .short) -> String {
        return self.localizedDescription(dateStyle: dateStyle, timeStyle: .short)
    }
}

// For optional
extension Optional where Wrapped == Date {
    func localizedDescriptionForClient(dateStyle: DateFormatter.Style = .short) -> String {
        guard let value = self else {
            return NSLocalizedString("Value not set", comment: "Error")
        }
        
        return value.localizedDescriptionForClient(dateStyle: dateStyle)
    }
}
