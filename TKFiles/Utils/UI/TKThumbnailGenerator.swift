//
//  TKThumbnailGenerator.swift
//  TKFiles
//
//  Created by wuwei on 2020/8/13.
//  Copyright © 2020 caanvu. All rights reserved.
//

import UIKit
import AVFoundation
class TKThumbnailGenerator: NSObject {
    static func videoThumbnail(url: URL, with size: CGSize) -> UIImage? {
        let scale = UIScreen.main.scale
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = CGSize(width: size.width * scale, height: size.height * scale)

        let kPreferredTimescale: Int32 = 1000
        var actualTime: CMTime = CMTime(seconds: 0, preferredTimescale: kPreferredTimescale)
        //generates thumbnail at first second of the video
        let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 1, preferredTimescale: kPreferredTimescale), actualTime: &actualTime)
        return cgImage.flatMap { UIImage(cgImage: $0, scale: scale, orientation: .up) }
    }
    static func imageThumbnail(url: URL, with size: CGSize) -> UIImage? {
        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil) else {
            return nil
        }

        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: Double(max(size.width, size.height) * UIScreen.main.scale),
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true
        ]

        return CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as NSDictionary).flatMap { UIImage(cgImage: $0) }
    }
    static func pdfThumbnail(url: URL, with size: CGSize) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL), let page = document.page(at: 1) else { return nil }

        let originalPageRect: CGRect = page.getBoxRect(.mediaBox)
        var targetPageRect = AVMakeRect(aspectRatio: originalPageRect.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        targetPageRect.origin = CGPoint.zero

        UIGraphicsBeginImageContextWithOptions(targetPageRect.size, true, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.setFillColor(gray: 1.0, alpha: 1.0)
        context.fill(targetPageRect)

        context.saveGState()
        context.translateBy(x: 0.0, y: targetPageRect.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.concatenate(page.getDrawingTransform(.mediaBox, rect: targetPageRect, rotate: 0, preserveAspectRatio: true))
        context.drawPDFPage(page)
        context.restoreGState()

        return context.makeImage().flatMap { UIImage(cgImage: $0, scale: UIScreen.main.scale, orientation: .up) }
    }
}
