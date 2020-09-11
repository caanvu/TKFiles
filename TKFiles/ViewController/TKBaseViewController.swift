//
//  TKBaseViewController.swift
//  Temple
//
//  Created by wuwei on 2019/5/5.
//  Copyright © 2019 FMC_iOS. All rights reserved.
//

import UIKit
import SnapKit
class TKBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    /// 是否隐藏导航栏
    var isShowNavigationBar = true
    /// 是否透明导航栏
    var isTranslucentNavBar = false
    /// 是否StatusBar 为默认颜色
    var isDefaultBarStyle = true {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var isBarTintColorWhite = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /// 更好找当前在那个页面
        logging("初始化了->\(tkClassName)")
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isShowNavigationBar {
            navigationController?.isNavigationBarHidden = true
        }
        if isTranslucentNavBar {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isShowNavigationBar {
            navigationController?.isNavigationBarHidden = false
        }
        if isTranslucentNavBar {
            navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.isTranslucent = true
            //            navigationController?.navigationBar.tintColor = .red
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let childs = self.navigationController?.children else {
            return
        }
        if childs.count >=  1 {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isDefaultBarStyle {
            return .default
        } else {
            return .lightContent
        }
    }
    
    deinit {
        /// 容易找到视图内存泄漏
        logging("销毁了->\(tkClassName)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
