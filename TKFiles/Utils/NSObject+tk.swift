//
//  NSObject+tk.swift
//  TKTemple
//
//  Created by wuwei on 2019/5/7.
//  Copyright © 2019 FMC_iOS. All rights reserved.
//

import Foundation

extension NSObject {
    var tkClassName: String {
        get {
            return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last! as String
        }
    }
}
