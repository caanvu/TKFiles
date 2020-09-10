//
//  TKFileManager.swift
//  TKFiles
//
//  Created by wuwei on 2020/6/8.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit

let tkSharedFileManager = TKFileManager.shared
class TKFileManager: NSObject {
    class var shared: TKFileManager {
        struct Static {
            static let instance: TKFileManager = TKFileManager()
        }
        return Static.instance
    }
    private var manager = FileManager.default
    private var rootUrl: URL?
    var rootModel: TKFileModel?
    override init() {
        super.init()
        guard let url = try? self.manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            return
        }
        self.rootUrl = url
        rootModel = TKFileModel(url: url, name: "文件")
        test()
    }
    func getFiles(url: URL?) -> [TKFileModel] {
        if let url = url, let urls = try? manager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) {
            var arr: [TKFileModel] = []
            for url in urls {
                let model = TKFileModel(url: url, name: url.deletingPathExtension().lastPathComponent)
                arr.append(model)
            }
            return arr
        }
        return []
    }
    func test() {
        let directoryURL = self.rootUrl!
        let arr = try? manager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        if arr != nil , arr!.count > 0 {
            return
        }
        let videoURL = Bundle.main.url(forResource: "video", withExtension: "mp4")!
        let pdfURL = Bundle.main.url(forResource: "pdf", withExtension: "pdf")!
        let image = UIImage(named: "image.jpg")!
        let imageData = image.pngData()!


        let firstDirectoryURL = directoryURL.appendingPathComponent("Directory")
        try? manager.createDirectory(at: firstDirectoryURL, withIntermediateDirectories: true, attributes: nil)
//        try? FileManager.default.createDirectory(at: firstDirectoryURL, withIntermediateDirectories: true, attributes: convertToOptionalFileAttributeKeyDictionary([String: Any]()))

        let items = [
            (videoURL, "video.mp4"),
            (pdfURL, "pdf.pdf")
        ]
        for (url, filename) in items {
            let destinationURL = firstDirectoryURL.appendingPathComponent(filename)
            try? FileManager.default.copyItem(at: url, to: destinationURL)
        }

        let imageURL = firstDirectoryURL.appendingPathComponent("image.png")
        try? imageData.write(to: imageURL)

        let subdirectoryURL = firstDirectoryURL.appendingPathComponent("Empty Directory")
        try? manager.createDirectory(at: subdirectoryURL, withIntermediateDirectories: true, attributes: nil)
        let secondDirectoryURL = directoryURL.appendingPathComponent("Empty Directory")
        try? manager.createDirectory(at: secondDirectoryURL, withIntermediateDirectories: true, attributes: nil)
    }
}
