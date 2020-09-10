//
//  UIButton+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/16.
//


import UIKit

extension UIButton {
    convenience init(_ color: UIColor, fontSize: CGFloat,text: String = "", textAlignment: UIControl.ContentHorizontalAlignment = .center,weight: UIFont.Weight = .regular) {
        self.init(type: .custom)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        contentHorizontalAlignment = textAlignment
        setTitle(text, for: .normal)
        setTitleColor(color, for: .normal)
    }
    convenience init(_ img: UIImage?, highlightedImg: UIImage?) {
        self.init(type: .custom)
        self.setImage(img, for: .normal)
        self.setImage(highlightedImg, for: .highlighted)
    }
}
