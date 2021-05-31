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
   
    
//    var saveUser: User?
    var saveUser: UserInfo?
    
//    var tapOnCell: ((_ success: Bool) -> Void)?
    
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
//        self.setTapOnCell()
     
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clearCell()
        setupCell()
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//        
//    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
//    func configCell(user: User) {
//            friendName.text =  user.name
//           // friendAge.text = "Возраст: " + user.age
//            if let avatar = user.avatar {
//                friendAvatar.image = avatar
//
//            }
    func configCell(user: UserInfo) {
        
       
        
        friendName.text =  user.firstName + " " + user.lastName
       // friendAge.text = "Возраст: " + user.age
//        if let avatar = user.avatar {
//            friendAvatar.image = avatar
//
//        }
        saveUser = user
    }
    
    
    
}
