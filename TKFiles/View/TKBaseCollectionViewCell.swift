//
//  TKBaseCollectionViewCell.swift
//  TKFiles
//
//  Created by wuwei on 2020/9/10.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

class TKBaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    func setupUI() {
    }
}
