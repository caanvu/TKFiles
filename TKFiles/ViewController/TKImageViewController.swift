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
    var models: [TKFileModel] = []
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellId = "cellId"
    var cacheImages: [URL:UIImage] = [:]
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

    }
    
    override func loadView() {
        super.loadView()
        view = scrollView
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    func setupUI() {
        title = models.first?.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickClose(bar:)))

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2
        scrollView.delegate = self
        scrollView.addSubview(collectionView)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(TKImageViewController.tapScrollView(ges:)))
        scrollView.addGestureRecognizer(tapGes)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        }
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TKImageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        // layout
        scrollView.addSubview(collectionView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
    }
    @objc func tapScrollView(ges: UIGestureRecognizer) {
        if let nav = navigationController {
            let value = !nav.isNavigationBarHidden
            nav.setNavigationBarHidden(value, animated: true)
        }
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
        if scrollView == self.scrollView {
            return collectionView
        } else {
            return nil
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            scrollView.contentSize = CGSize(width: scrollView.frame.width * scrollView.zoomScale, height: scrollView.frame.height)
        }
    }
}

extension TKImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = models[indexPath.row]
        let width = scrollView.bounds.width
        var height = scrollView.bounds.height
        let imageSize = model.imageSize()
        height = width / imageSize.width * imageSize.height
        return CGSize(width: width, height: height)
    }
    
}

extension TKImageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let model = models[indexPath.row]
        if let imageCell = cell as? TKImageCollectionViewCell {
            let size = scrollView.bounds.size
            imageCell.imageUrl = model.url
            DispatchQueue.global().async {
                let imageSize = model.imageSize()
                let height = size.width / imageSize.width * imageSize.height
                let image = model.getImage(size: CGSize(width: size.width, height: height))
                DispatchQueue.main.async {
                    if imageCell.imageUrl == model.url {
                        imageCell.imageView.image = image == nil ? nil : UIImage(cgImage: image!)
                    }
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        logging(indexPath.row)
    }
}
