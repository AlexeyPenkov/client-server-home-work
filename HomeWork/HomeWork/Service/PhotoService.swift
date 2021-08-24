//
//  PhotoService.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 21.07.2021.
//

import UIKit
import Alamofire

class PhotoService {
    
    private let casheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    private static let casheImagesURL: URL? = {
        let path = "Images"
        
        guard let cashesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let imageFolderUrl = cashesDirectory.appendingPathComponent(path, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: imageFolderUrl.path) {
            try? FileManager.default.createDirectory(at: imageFolderUrl, withIntermediateDirectories: true)
        }
        return imageFolderUrl
    }()
    
    private var imageCashe: [String: UIImage] = [:]

    // MARK: - Private methods
    
    private func getFilePath(at url: URL) -> String? {
        
        let hashName = url.lastPathComponent
        
        return Self.casheImagesURL?.appendingPathComponent(hashName).path
    }
    
    private func saveImageToCashe(_ image: UIImage, with url: URL) {
        guard let filePath = self.getFilePath(at: url) else { return }
        let imageData = image.pngData()
        FileManager.default.createFile(atPath: filePath, contents: imageData)
    }
    
    private func getImageFromCashe(at url: URL) -> UIImage? {
        guard let filePath = self.getFilePath(at: url) else { return nil }
        
        guard let modificationDate = try? FileManager.default.attributesOfItem(atPath: filePath)[.modificationDate] as? Date else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= self.casheLifeTime,
              let image = UIImage(contentsOfFile: filePath) else {
            return nil
        }
        
        DispatchQueue.main.async {
            self.imageCashe[filePath] = image
        }
        
        return image
    }
    
}

extension PhotoService {
    
    static let shared = PhotoService()
    
    private func loadPhoto(at url: URL, complition: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                guard let filePath  = self.getFilePath(at: url) else { return }
                self.imageCashe[filePath] = image
            }
            
            self.saveImageToCashe(image, with: url)
            
            DispatchQueue.main.async {
                complition(image)
            }
        }.resume()
    }
    
    func getPhoto(at url: URL, complition: @escaping (UIImage) -> Void) {
        
        assert(Thread.isMainThread, "Must call on main thred")
        
        if let filePath = self.getFilePath(at: url), let image = self.imageCashe[filePath] {
            return complition(image)
        } else if let image = self.getImageFromCashe(at: url) {
            return complition(image)
        } else {
            self.loadPhoto(at: url, complition: complition)
        }
        
    }
}

extension UIImageView {
    func setImage(at url: URL) {
        PhotoService.shared.getPhoto(at: url) { [weak self] image in
            self?.image = image
        }
    }
}
