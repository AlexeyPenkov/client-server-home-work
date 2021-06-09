//
//  GroupTableViewCell.swift
//  lesson1
//
//  Created by Алексей Пеньков on 09.04.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
   
    @IBOutlet weak var groupAvatar: UIImageView!
    
    var saveItem: Any?
    
    func clearCell() {
        groupName.text = nil
        groupAvatar.image = nil
        saveItem = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clearCell()
    }

    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configCell(group: CommunityInfo) {
        groupName.text = group.name
        
//        //получаем фото из строки url
//        let urlString = group.photo_100
//        let urlAvatar = URL(string: urlString!)
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: urlAvatar!)
//            DispatchQueue.main.async {
//                self.groupAvatar.image = UIImage(data: data!)
//            }
//        }
//        if let avatar = group.avatar {
//           groupAvatar.image = avatar
//        }
        saveItem = group
    }
}
