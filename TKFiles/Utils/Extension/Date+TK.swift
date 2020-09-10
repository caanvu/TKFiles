//
//  Date+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/28.
//

import Foundation

public enum TKDateFormateType : String {
    case formateAll = "yyyy-MM-dd HH:mm:ss"
    case formateyMdHm = "yyyy-MM-dd HH:mm"
    case formateyMdHm2 = "yyyy.MM.dd HH:mm"
    case formateyYM = "yyyy-MM"
    case formateyMd = "MM-dd"
    case formateyMd1 = "yyyy.MM.dd"
    case formateMd1 = "MM月dd"
    case formateMd2 = "MM月dd日"
    case formateMd3 = "MM.dd"
    case formateMdHm = "MM月dd日 HH:mm"
    case formateHm = "HH:mm"
    case formateM = "MM月"
}

public extension Date {
    // 毫秒
    var tkMilliseconds: TimeInterval {
        get { return self.timeIntervalSince1970 * 1000 }
    }
    internal func tkDateString(_ type : TKDateFormateType) -> String {
        tkDateFormatter.dateFormat = type.rawValue
        return tkDateFormatter.string(from: self)
    }
    func tkAddDays(_ value: Int) -> Date? {
        var component = DateComponents()
        component.day = value
        return tkCalendar.date(byAdding: component, to: self)
    }
    func tkAddMonth(_ value: Int) -> Date? {
        return tkCalendar.date(byAdding: DateComponents(month: value), to: self)!
    }
    func tkStartOfMonth() -> Date {
        let component = tkCalendar.dateComponents([.year,.month], from: self)
        return tkCalendar.date(from: component)!
    }
    func tkEndOfMonth() -> Date {
        return tkCalendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.tkStartOfMonth())!
    }
    func tkPreviousMonth() -> Date {
        return tkCalendar.date(byAdding: DateComponents(month: -1), to: self)!
    }
    func tkNextMonth() -> Date {
        return tkCalendar.date(byAdding: DateComponents(month: 1), to: self)!
    }
    func tkStartOfMdDay() -> Date {
        return tkDateFormatter.date(from: self.tkDateString(.formateyMd))!
    }
    // 星期几
    func tkWeek() -> String {
        let myWeekday: Int = (Calendar.current as NSCalendar).components([NSCalendar.Unit.weekday], from: self).weekday!
        switch myWeekday {
        case 0:
            return "周日"
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        default:
            break
        }
        return "未取到数据"
    }
    // 获取时间文字说明
    func tkMessageAgoSinceDate(_ date: Date) -> String {
        return tkTimeAgoSinceDate(numericDates: false)
    }
    // 获取时间文字说明
    func tkTimeAgoSinceDate(numericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components:DateComponents = (calendar as NSCalendar).components([
            NSCalendar.Unit.minute,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.day,
//            NSCalendar.Unit.weekOfYear,
//            NSCalendar.Unit.month,
//            NSCalendar.Unit.year,
            NSCalendar.Unit.second
            ], from: earliest, to: latest, options: NSCalendar.Options())
        if  components.day! <= 1 {
            if (components.day! == 1){
                return "昨天" + tkDateString(.formateHm)
            } else if (components.hour! >= 2) {
                return "\(components.hour!) 小时前"
            } else if (components.hour! >= 1){
                return "1 小时前"
            } else if (components.minute! >= 2) {
                return "\(components.minute!) 分钟前"
            } else if (components.minute! >= 1){
                return "1 分钟前"
            } else if (components.second! >= 3) {
                return "\(components.second!) 秒前"
            } else {
                return "刚刚"
            }
        } else {
            return tkDateString(.formateyMdHm)
        }
    }
    static func tkGetDateString(timeInterval: String?, type:TKDateFormateType) -> String? {
        var timeStr: String?
        if let str = timeInterval, let time = TimeInterval(str) {
            timeStr = Date(timeIntervalSince1970: time/1000.0).tkDateString(type)
        }
        return timeStr
    }
}
