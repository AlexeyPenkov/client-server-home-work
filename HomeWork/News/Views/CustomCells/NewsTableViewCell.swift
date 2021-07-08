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

    }
    
    func configCell(news: ItemNews){
        titleLabel.text = news.text
        //autorLabel.text = news.autor.name
        let url = news.attachments.first?.photo.sizes.first
        let urlString = url?.url
        
        let urlAvatar = URL(string: urlString!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlAvatar!)
            DispatchQueue.main.async {
                self.imageNew.image = UIImage(data: data!)
            }
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
