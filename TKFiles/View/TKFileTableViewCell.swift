//
//  TKFileTableViewCell.swift
//  TKFiles
//
//  Created by wuwei on 2020/8/12.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

let tkFileTableViewCellImageSize = CGSize(width: 50, height: 50)
class TKFileTableViewCell: TKBaseTableViewCell {
    let leftImageView = UIImageView(image: UIImage.listFile)
    let titleLabel = UILabel(UIColor.text1, fontSize: UIFont.textFontSize1)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setupUI() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(titleLabel)
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(tkSpacing15)
            make.top.equalToSuperview().offset(tkSpacing5)
            make.bottom.equalToSuperview().offset(-tkSpacing5)
            make.size.equalTo(tkFileTableViewCellImageSize).priority(999)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(tkSpacing10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-tkSpacing15)
        }
    }
    func updateUI(_ title: String?, image: UIImage?) {
        titleLabel.text = title
        leftImageView.image = image
    }
}
