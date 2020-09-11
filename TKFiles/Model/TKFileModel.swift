//
//  TKFileModel.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/24.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

enum TKFilePathType {
    case file
    case folder
    case image
    case pdf
    case video
}
class TKFileModel: NSObject {
    var name: String
    var type: TKFilePathType {
        return getType()
    }
    var url: URL
    lazy var children: [TKFileModel] = {
        return getChildren()
    }()
    var fileExtension: String {
        return url.pathExtension
    }
    init(url: URL) {
        self.url = url
        self.name = url.deletingPathExtension().lastPathComponent
        super.init()
    }
    func getChildren() -> [TKFileModel] {
        return tkSharedFileManager.getFiles(url: url)
    }
    func getType() -> TKFilePathType {
        switch fileExtension {
        case "":
            return .folder
        case "png", "jpg", "jpeg":
            return .image
        case "mp4", "avi", "mkv", "mov":
            return .video
        case "pdf":
            return .pdf
        default:
            return .file
        }
    }
    func updateChildren() {
        children = getChildren()
    }
}

extension TKFileModel {
    func imageSize() -> CGSize {
        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil) else {
            return .zero
        }
        let dic = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any]
        guard let width = dic?[kCGImagePropertyPixelWidth as String] as? CGFloat , let heigth = dic?[kCGImagePropertyPixelHeight as String] as? CGFloat else {
            return .zero
        }
        return CGSize(width: width, height: heigth)
    }
    func getImage(size: CGSize) -> CGImage? {
        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil) else {
            return nil
        }
        let option: [NSString: Any] = [kCGImageSourceThumbnailMaxPixelSize: Double(max(size.width,size.height) * UIScreen.main.scale),
                                       kCGImageSourceCreateThumbnailFromImageAlways: true,
                                       kCGImageSourceCreateThumbnailWithTransform: true]
        return CGImageSourceCreateThumbnailAtIndex(imageSource, 0, option as CFDictionary)
    }
}
