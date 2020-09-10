//
//  UITextField+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/16.
//

import UIKit

extension UITextField {
    convenience init(fontSize: CGFloat,placeholder: String = "", textAlignment: NSTextAlignment = .center) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        self.textAlignment = textAlignment
        self.placeholder = placeholder
    }
}
