//
//  UIImageView + SetImage.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import UIKit.UIImageView

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    @discardableResult
    func setImage(urlString: String, isRoundImg: Bool = false, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil

        let key = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: key) {
            self.image = cachedImage
            if isRoundImg{
                self.makeRounded()
            }
            return nil
        }
        
        if let placeholder = placeholder {
            self.image = placeholder
            if isRoundImg{
                self.makeRounded()
            }
        }

        guard let url = URL(string: urlString) else {
            return nil
        }



        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                    if isRoundImg{
                        self.makeRounded()
                    }
                }
            }
        }

        task.resume()
        return task
    }
    
    func makeRounded() {
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
}
