//
//  Log.swift
//  Temple
//
//  Created by wuwei on 2019/5/5.
//  Copyright © 2019 FMC_iOS. All rights reserved.
//

import UIKit

func logging<T>(_ message:T, file:String = #file, function:String = #function, line:Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
//        print("\(fileName):\(line) \(function) | \(message)")
        print("\(fileName):\(line) \(message)")
    #endif
}
