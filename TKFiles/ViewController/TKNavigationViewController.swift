//
//  TKNavigationViewController.swift
//  UliRent
//
//  Created by wuwei on 2019/6/6.
//  Copyright © 2019 Uli. All rights reserved.
//

import UIKit

class TKNavigationViewController: UINavigationController {

    var isBarTintColorWhite = false {
        didSet {
            if oldValue != isBarTintColorWhite {
                changeBarColor()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeBarColor()

    }
    func changeBarColor() {
//        if isBarTintColorWhite {
//            color = .textColor3
//        }
        let attri = [NSAttributedString.Key.foregroundColor: UIColor.text1,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)]
        navigationBar.largeTitleTextAttributes = attri
    }
    // 跳转新界面
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if children.count > 0 {
//            let btn = UIButton(.backArrow, selectImg: .backArrow)
//            btn.size = CGSize(width: 30, height: 44)
//            btn.contentHorizontalAlignment = .left
//            btn.addTarget(viewController, action: #selector(viewController.navigationLeftAction), for: .touchUpInside)
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
//            viewController.hidesBottomBarWhenPushed = true
//        }
        super.pushViewController(viewController, animated: animated)
    }
    override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}
