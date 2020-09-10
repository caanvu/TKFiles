//
//  UIView+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/16.
//

import UIKit

extension UIView {
    @discardableResult
    func addBottomLine() -> UIView {
        let line = UIView()
        line.backgroundColor = .bottomLine
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        return line
    }
}
