//
//  TKUtils.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/9.
//

import UIKit

class TKUtils: NSObject {

    //MARK: - 设备相关
    static var unameMachine: String {
        var utsnameInstance = utsname()
        uname(&utsnameInstance)
        let optionalString: String? = withUnsafePointer(to: &utsnameInstance.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        return optionalString ?? "N/A"
    }
    static var bundleShortVersion: String {
        
        guard let dic = Bundle.main.infoDictionary else {
            return ""
        }
        guard let version = dic["CFBundleShortVersionString"] as? String else {
            return ""
        }
        return version
    }
    //MARK: - 错误
    class func error(_ domain: String, code: Int) -> Error {
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey : domain]) as Error
    }
    class func error(_ domain: String) -> Error {
        return error(domain, code: 0)
    }
    class func errorDomain(_ error: Error) -> String {
        return (error as NSError).domain
    }
}

//MARK: - UI适配相关

let tkScreenSize = UIScreen.main.bounds.size
let tkScreenWidth = tkScreenSize.width
let tkScreenHeight = tkScreenSize.height
let tkSpacing15: CGFloat = 15
let tkSpacing10: CGFloat = 10
let tkSpacing5: CGFloat = 5

//MARK: - UI适配相关方法
func tkAdaptUI(_ value: CGFloat) -> CGFloat {
    let rect = UIScreen.main.bounds
    let min = rect.size.height < rect.size.width ? rect.size.height : rect.size.width
    let newValue = min / 375.0 * value
    // 丢失点精度
    return CGFloat(Int(newValue * 10) / 10)
}
func tkAdaptSize(_ value:CGSize) ->CGSize {
    let width = tkAdaptUI(value.width)
    let height = tkAdaptUI(value.height)
    return CGSize(width: width, height: height)
}
/// 字体适配
func tkAdaptFont(_ fontSize: CGFloat) -> CGFloat {
    var newFontSize = tkAdaptUI(fontSize)
    if newFontSize > fontSize + 0.01 {
        newFontSize = fontSize + 2
    } else if newFontSize < fontSize - 0.01 {
        newFontSize = fontSize - 2
    } else {
        newFontSize = fontSize
    }
    return fontSize
}

