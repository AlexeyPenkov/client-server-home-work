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
        self.photoNews.image = nil
    }
    
    func configCell(url: String?) {
        
        guard let url = url,
              let urlAvatar = URL(string: url) else { return }
        
        
        self.photoNews.setImage(at: urlAvatar)
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
