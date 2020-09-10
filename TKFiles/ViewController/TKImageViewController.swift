//
//  TKImageViewController.swift
//  TKFiles
//
//  Created by wuwei on 2020/8/14.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

class TKImageViewController: TKBaseViewController {
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    var model: TKFileModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        loadData()
    }
    
    override func loadView() {
        super.loadView()
        view = scrollView
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    func setupUI() {
        title = model?.name
        extendedLayoutIncludesOpaqueBars = false
        edgesForExtendedLayout = []

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(TKImageViewController.tapScrollView(ges:)))
        scrollView.addGestureRecognizer(tapGes)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickClose(bar:)))
    }
    @objc func tapScrollView(ges: UIGestureRecognizer) {
        if let nav = navigationController {
            nav.isNavigationBarHidden = !nav.isNavigationBarHidden
        }
    }
    func loadData() {
        guard let url = model?.url, let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
    }
    
    func centerImageView() {
        var vertical: CGFloat = 0, horizontal: CGFloat = 0
        if scrollView.contentSize.width < view.bounds.width {
            horizontal = (scrollView.bounds.width - scrollView.contentSize.width)/2
        }
        if scrollView.contentSize.height < view.bounds.height {
            vertical = (scrollView.bounds.height - scrollView.contentSize.height)/2
        }
        scrollView.contentInset = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    
    @objc func clickClose(bar: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

extension TKImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageView()
    }
}
