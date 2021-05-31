//
//  NewsTableViewCell.swift
//  lesson1
//
//  Created by Алексей Пеньков on 25.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var isLiked = true
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var autorLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var imageNew: UIImageView!
    
    func clearCell() {
        titleLabel.text = nil
        autorLabel.text = nil
        //likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    func configCell(news: NewsStruct){
        titleLabel.text = news.title
        autorLabel.text = news.autor.name
        if let image = news.image {
            imageNew.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    @IBAction func myLike() {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = UIColor.systemRed
            
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor.black
            
        }
        isLiked = !isLiked
    }
}
