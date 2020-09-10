//
//  TKCalendar.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/28.
//

import Foundation

/// 日历单例
let tkCalendar = TKCalendar.shared.calendar
let tkDateFormatter = TKCalendar.shared.dateFormatter
class TKCalendar: NSObject {
    let calendar: Calendar = Calendar(identifier: .gregorian)
    let dateFormatter = DateFormatter()
    class var shared: TKCalendar {
        struct Static {
            static let instance: TKCalendar = TKCalendar()
        }
        return Static.instance
    }
    override init() {
        let local = Locale(identifier: "zh-Hans")
        dateFormatter.locale = local
    }
}
