//
//  UIImage+TK.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/15.
//

import UIKit

extension UIImage {
    func scaleImage(_ imageSize:CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(imageSize)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let tmpImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tmpImage
    }
    //MARK: - 本地图片
    private convenience init?(tkNamed name: String) {
        self.init(named: name)
    }
    open class var tabFile: UIImage? {
        return UIImage(tkNamed: "tabFile")
    }
    open class var tabDownload: UIImage? {
        return UIImage(tkNamed: "tabDownload")
    }
    open class var tabGear: UIImage? {
        return UIImage(tkNamed: "tabGear")
    }
    open class var tabShare: UIImage? {
        return UIImage(tkNamed: "tabShare")
    }
    
    open class var folder: UIImage? {
        return UIImage(tkNamed: "folder")
    }
    open class var listFile: UIImage? {
        return UIImage(tkNamed: "listFile")
    }
}
