//
//  Int+.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/19.
//

import Foundation

extension Int {
    var toRelativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        let now = Date()
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        let dateString = formatter.localizedString(for: date, relativeTo: now)
        
        return dateString
    }
    
    var toDayTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a hh:mm"
        
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        
        return dateFormatter.string(from: date)
    }
}

