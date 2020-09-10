//
//  UIColor+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/16.
//

import UIKit

extension UIColor {
    private convenience init(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap{ [$0,$0] }
            fallthrough
        case 6:
            chars = ["F", "F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            alpha = 0
            red = 0
            green = 0
            blue = 0
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    //MARK: - 颜色
    open class var blue1: UIColor {
        return UIColor(hexString: "#3498DB")
    }
    open class var bottomLine: UIColor {
        return UIColor(hexString: "#E0E0E0")
    }
    open class var text1: UIColor {
        return UIColor(hexString: "#5C5C5C")
    }
}
