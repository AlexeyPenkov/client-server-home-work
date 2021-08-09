//
//  AsyncImageView.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 09.08.2021.
//

import UIKit

class AsyncImageView: UIImageView {
    
    private var _image: UIImage?
    
    override var image: UIImage? {
        get {
            return _image
        }
        set {
            self._image = newValue
            
            self.layer.contents = nil
            
            guard let image = newValue else { return }
            
            DispatchQueue.global(qos: .userInteractive).async {
                let cgImage = self.decode(image)
                
                DispatchQueue.main.async {
                    self.layer.contents = cgImage
                }
            }
        }
    }
    
    //MARK: - Private
    
    func decode(_ image: UIImage) -> CGImage? {
        guard let cgImage = image.cgImage else { return nil}
        
        if let cachedImage = Self.cache.object(forKey: image) {
            return (cachedImage as! CGImage)
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let context = CGContext(data: nil,
                                width: cgImage.width,
                                height: cgImage.height,
                                bitsPerComponent: 8,
                                bytesPerRow: cgImage.width*4,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        else { return nil }
        
        let imageRect = CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height)
        
        let maxDimension = CGFloat(max(cgImage.width, cgImage.height))
        
        let cornerRadiusPath = UIBezierPath(roundedRect: imageRect, cornerRadius: maxDimension/2).cgPath
        
        context.addPath(cornerRadiusPath)
        
        context.clip()
        
        context.draw(cgImage, in: imageRect)
        
        guard let outputImage = context.makeImage() else { return nil }
        
        Self.cache.setObject(outputImage, forKey: image)
        
        return context.makeImage()
    }
}

extension AsyncImageView {
    static var cache = NSCache<AnyObject, AnyObject>()
}
