//
//  MyFriendsTableViewCell.swift
//  lesson1
//
//  Created by Алексей Пеньков on 09.04.2021.
//

import UIKit


class MyFriendsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var friendAvatar: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendAge: UILabel!
    @IBOutlet weak var customView: UIView!
   
    
    var saveUser: UserRealm?
    
    func clearCell() {
        friendName.text = nil
        friendAvatar.image = nil
        friendAge.text = nil
        saveUser = nil
    }
    
    func setupCell() {
        customView.layer.cornerRadius = customView.frame.size.height / 2
        customView.layer.shadowRadius = 10
        customView.layer.shadowOpacity = 0.9
        customView.layer.shadowOffset = CGSize.zero
        customView.layer.shadowColor = UIColor.black.cgColor
        
        friendAvatar.layer.cornerRadius = customView.frame.size.height / 2
     
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clearCell()
        setupCell()
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
            
    func configCell(user: UserRealm) {
        
        friendName.text =  user.firstName + " " + user.lastName
        
        let urlString = user.photo
        let urlAvatar = URL(string: urlString)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlAvatar!)
            DispatchQueue.main.async {
                self.friendAvatar.image = UIImage(data: data!)
            }
        }
        saveUser = user
    }

}
