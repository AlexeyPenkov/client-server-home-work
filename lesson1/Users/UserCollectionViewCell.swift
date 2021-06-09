//
//  UserCollectionViewCell.swift
//  lesson1
//
//  Created by Алексей Пеньков on 09.04.2021.
//

import UIKit

protocol CustomCellDelegate: class {
    func pressLikeButton(currCount: Int, currItem: Int, count: Int)
    func pressDislikeButton(currCount: Int, currItem: Int, count: Int)
}

class UserCollectionViewCell: UICollectionViewCell {

    var likeCount = 0, dislikeCount = 0
    var isLiked = true, isDisLiked = true
    var saveUserFoto: Photo?
    var currentCount: Int?
    var currentItem: Int?
    
    weak var delegate: CustomCellDelegate?
    
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var labelDisCounter: UILabel!
    
    @IBOutlet weak var labelLikeCounter: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dislikeButton: UIButton!
    
    func clearCell() {
        foto.image = nil
        saveUserFoto = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func prepareForReuse() {
        clearCell()
    }
    
    func configCell(userFoto: Photo?) {
        
        //получаем фото из строки url
        let urlString = userFoto?.url
        let urlAvatar = URL(string: urlString!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlAvatar!)
            DispatchQueue.main.async {
                self.foto.image = UIImage(data: data!)
            }
        }
//        labelLikeCounter.text = String(likeCount)
//        labelDisCounter.text = String(dislikeCount)
//        
//        likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
//        likeButton.tintColor = UIColor.black
//        
//        dislikeButton.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
//        dislikeButton.tintColor = UIColor.black
        
        saveUserFoto = userFoto
        //let myStackView = UIStackView(frame: CGRect(x: foto.frame.maxX-100.0, y: foto.frame.maxY-15.0, width: 100.0, height: 15.0))
        
        //let myLabel = UILabel(frame: CGRect(x: myStackView.frame.minX, y: myStackView.frame.minY, width: 50.0, height: 14.0))
        //let myLabel = UILabel(frame: CGRect(x: foto.frame.maxX-100.0, y: foto.frame.maxY-15.0, width: 100.0, height: 15.0))

        //myLabel.text = "лайки"
     
       // let heartView = HeartView()
        
        //self.foto.addSubview(myLabel)
        //self.foto.addSubview(heartView)
       // self.foto.addSubview(buttonLike)
    }
    
    @IBAction func pressLikeButton(_ sender: Any) {
        
        
        if isLiked {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            likeButton.tintColor = UIColor.systemRed
            likeCount += 1
        } else {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            likeButton.tintColor = UIColor.black
            likeCount -= 1
        }
        animateLike()
        isLiked = !isLiked
        labelLikeCounter.text = String(likeCount)
        
        if let currentCount = currentCount, let currentItem = currentItem {
            delegate?.pressLikeButton(currCount: currentCount, currItem: currentItem, count: likeCount)
        }
    }
    
    @IBAction func pressDislikeButton(_ sender: Any) {
        
        
        if isDisLiked {
            dislikeButton.setImage(UIImage(systemName: "hand.thumbsdown.fill"), for: .normal)
            dislikeButton.tintColor = UIColor.systemRed
            dislikeCount += 1
        } else {
            dislikeButton.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
            dislikeButton.tintColor = UIColor.black
            dislikeCount -= 1
        }
        
        animateDislike()
        isDisLiked = !isDisLiked
        labelDisCounter.text = String(dislikeCount)
        
        if let currentCount = currentCount, let currentItem = currentItem {
            delegate?.pressDislikeButton(currCount: currentCount, currItem: currentItem, count: dislikeCount)
            
        }
    }
    
    func animateLike() {
        UIImageView.animate(withDuration: 0.5,
                            delay: 0,
                            options: [],
                            animations: {
                                self.likeButton.transform = CGAffineTransform(rotationAngle: 90)
                            },
                            completion: {[weak self]_ in
                                UIImageView.animate(withDuration: 0.3,
                                                    delay: 0,
                                                    usingSpringWithDamping: 0.5,
                                                    initialSpringVelocity: 0,
                                                    options: [],
                                                    animations: {
                                                        self?.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                        
                                                        
                                                    },
                                                    completion: {[weak self] _ in
                                                        UIImageView.animate(withDuration: 0.2,
                                                                            animations: {self?.likeButton.transform = .identity})
                                                    })
                            })
    }
     
    func animateDislike() {
        UIImageView.animate(withDuration: 0.5,
                            delay: 0,
                            options: [],
                            animations: {
                                self.dislikeButton.transform = CGAffineTransform(rotationAngle: 90)
                            },
                            completion: {[weak self]_ in
                                UIImageView.animate(withDuration: 0.3,
                                                    delay: 0,
                                                    usingSpringWithDamping: 0.5,
                                                    initialSpringVelocity: 0,
                                                    options: [],
                                                    animations: {
                                                        self?.dislikeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                        
                                                        
                                                    },
                                                    completion: {[weak self] _ in
                                                        UIImageView.animate(withDuration: 0.2,
                                                                            animations: {self?.dislikeButton.transform = .identity})
                                                    })
                            })
    }
}

