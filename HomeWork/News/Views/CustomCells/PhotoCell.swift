//
//  PhotoCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoNews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clearCell()
    }

    func clearCell() {
        photoNews.image = nil
    }
    
    func configCell() {
//        let url = news.attachments.first?.photo.sizes.first
//        let urlString = url?.url
        
//        let urlAvatar = URL(string: urlString!)
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: urlAvatar!)
//            DispatchQueue.main.async {
//                self.imageNew.image = UIImage(data: data!)
//            }
//        }
    }
    
    override func prepareForReuse() {
        clearCell()
    }
}
