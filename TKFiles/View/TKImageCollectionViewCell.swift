//
//  TKImageCollectionViewCell.swift
//  TKFiles
//
//  Created by wuwei on 2020/9/10.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

class TKImageCollectionViewCell: TKBaseCollectionViewCell {
    let imageView = UIImageView()
    var imageUrl: URL?
    override func setupUI() {
        imageView.backgroundColor = .clear
        backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
