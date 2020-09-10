//
//  TKRouter.swift
//  TKFiles
//
//  Created by wuwei on 2020/8/11.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit
let tkRouterShared = TKRouter.shared
class TKRouter: NSObject {
    class var shared: TKRouter {
        struct Static {
            static let instance: TKRouter = TKRouter()
        }
        return Static.instance
    }
    class func push(from: UIViewController?,to:UIViewController?) {
         if let f = from,let t = to {
             f.navigationController?.pushViewController(t, animated: true)
         }
     }
    class func present(from: UIViewController?,to:UIViewController?) {
        if let f = from,let t = to {
            f.present(t, animated: true, completion: nil)
        }
    }
}
