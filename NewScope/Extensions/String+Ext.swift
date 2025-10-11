//
//  String+Ext.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import Foundation

extension String {
    func timeAgoString(localeIdentifier: String = "us_US") -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) ??
                        ISO8601DateFormatter().date(from: self) else {
            return ""
        }
        return date.timeAgo(localeIdentifier: localeIdentifier)
    }
}
