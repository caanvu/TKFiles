//
//  TKFileModel.swift
//  TKFiles
//
//  Created by wuwei on 2020/7/24.
//  Copyright © 2020 caanvu. All rights reserved.
//

import Foundation

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
    var children: [TKFileModel] {
        return getChildren()
    }
    var fileExtension: String {
        return url.pathExtension
    }
    init(url: URL, name: String) {
        self.url = url
        self.name = name
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
}
