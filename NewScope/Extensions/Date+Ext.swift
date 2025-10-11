//
//  Date+Ext.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import Foundation

extension Date {
    func timeAgo(localeIdentifier: String = "tr_TR") -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.unitsStyle = .full
        
        let relativeString = formatter.localizedString(for: self, relativeTo: Date())
        
        return relativeString
    }
}
