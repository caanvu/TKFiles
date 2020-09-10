//
//  TKNetworkViewController.swift
//  TKFiles
//
//  Created by wuwei on 2020/8/25.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

class TKNetworkViewController: TKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    func setupUI() {
        title = "网络"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.clickAddButton(barButton:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.clickSwitchButton(barbutton:)))
    }
    
    
    // MARK: - action
    @objc func clickAddButton(barButton: UIBarButtonItem) {
        
    }

    @objc func clickSwitchButton(barbutton: UIBarButtonItem) {
        
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
