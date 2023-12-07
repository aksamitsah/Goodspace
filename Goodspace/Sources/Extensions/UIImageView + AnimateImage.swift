//
//  UIImageView + Animate.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//


import UIKit.UIImage
import ImageIO

extension UIImage {
    static func animatedImage(withGIFName name: String) -> UIImage? {
        
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif"),
              let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)),
              let source = CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        
        let frameCount = CGImageSourceGetCount(source)
        var frames: [UIImage] = []
        var gifDuration = 0.0
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil),
               let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
               let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) {
                gifDuration += frameDuration.doubleValue
            }
            
            let frameImage = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
                frames.append(frameImage)
        }
        
        let animatedImage = UIImage.animatedImage(with: frames, duration: gifDuration)
        return animatedImage
    }
}
