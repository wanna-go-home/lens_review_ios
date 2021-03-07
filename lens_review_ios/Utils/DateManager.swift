//
//  DateManager.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/13.
//

import Foundation

extension Date {
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var month: Int {
         return Calendar.current.component(.month, from: self)
    }
    
    public var day: Int {
         return Calendar.current.component(.day, from: self)
    }
    
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
}

func calcCreatedBefore(createdAt: String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    let createdDate = dateFormatter.date(from: createdAt)
    let nowDate = Date()
    
    let yearDiff = nowDate.year - (createdDate?.year ?? 0)
    let monthDiff = nowDate.month - (createdDate?.month ?? 0)
    let dayDiff = nowDate.day - (createdDate?.day ?? 0)
    let hoursDiff = nowDate.hour - (createdDate?.hour ?? 0)
    let minutesDiff = nowDate.minute - (createdDate?.minute ?? 0)
    
    if yearDiff >= 1 {
        if monthDiff < 0 {
            return "%d_month_ago".localized(with: monthDiff + 12)
        }
        
        return "%d_year_ago".localized(with: yearDiff)
    }
    
    if monthDiff > 0 {
        return "%d_month_ago".localized(with: monthDiff)
    }
    
    if dayDiff > 0 {
        return "%d_day_ago".localized(with: dayDiff)
    }
    
    if hoursDiff > 0 {
        return "%d_hour_ago".localized(with: hoursDiff)
    }
    
    if minutesDiff > 0 {
        return "%d_minute_ago".localized(with: minutesDiff)
    }
    
    return "just_now".localized()
}

func convertDateFormat(createdAt: String) -> String
{
    var res = ""
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    if let date = dateFormatter.date(from: createdAt) {
        dateFormatter.dateFormat = "MM/dd-HH:mm"
        res = dateFormatter.string(from: date)
    }

    return res
}
