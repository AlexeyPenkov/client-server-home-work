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
    
    func configCell(group: Group) {
        groupName.text = group.name
        
        if let avatar = group.avatar {
           groupAvatar.image = avatar
        }
        saveItem = group
    }
}
