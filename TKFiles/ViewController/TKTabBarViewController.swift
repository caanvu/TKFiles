//
//  TKTabBarViewController.swift
//  UliRent
//
//  Created by wuwei on 2019/6/6.
//  Copyright © 2019 Uli. All rights reserved.
//

import UIKit
class TKTabBarViewController: UITabBarController {

    let fileVc = createController(TKFileViewController(), name: "文件", image: UIImage.tabFile, selectImage: UIImage.tabFile)

    let shareVc = createController(TKNetworkViewController(), name: "网络", image: UIImage.tabShare, selectImage: UIImage.tabShare)

    let downLoadVc = createController(ViewController(), name: "下载", image: UIImage.tabDownload, selectImage: UIImage.tabDownload)
    let settingVC = createController(ViewController(), name: "设置", image: UIImage.tabGear, selectImage: UIImage.tabGear)
    var controlClickable = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue1], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.text1], for: .normal)
//        self.tabBar.tintColor = UIColor.white
        self.viewControllers = [fileVc,shareVc,downLoadVc,settingVC]
        self.delegate = self
    }
    
    private class func createController(_ vc: UIViewController, name: String, image:UIImage?, selectImage: UIImage?) -> UIViewController {
        vc.tabBarItem.title = name
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectImage
        let nav = TKNavigationViewController(rootViewController: vc)
        return nav
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
extension TKTabBarViewController : UITabBarControllerDelegate {
    
}
