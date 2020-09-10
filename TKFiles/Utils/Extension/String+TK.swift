//
//  String+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/16.
//

import Foundation

extension String {
    // MARK: - 校验字符串
    private func crValidate(_ pre: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", pre)
        return predicate.evaluate(with: self)
    }
    // 校验手机号
    func crValidatePhone() -> Bool {
        let phoneRegex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}$"
        return self.crValidate(phoneRegex)
    }
    // 校验密码
    func crValidatePassword() -> Bool {
        let passwodRegex = "^[a-zA-Z0-9]{6,18}"
        return self.crValidate(passwodRegex)
    }
}
