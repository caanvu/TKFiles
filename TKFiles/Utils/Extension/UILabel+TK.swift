//
//  UILabel+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/17.
//

import UIKit
extension UILabel {
    convenience init(_ color: UIColor, fontSize:CGFloat, text:String? = nil, textAlignment: NSTextAlignment = .left, weight: UIFont.Weight = .regular) {
        self.init()
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.text = text
        self.textAlignment = textAlignment
    }
}
