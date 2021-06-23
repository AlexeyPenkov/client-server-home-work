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
    
    func configCell(group: GroupRealm) {
        
        groupName.text = group.name
        
//        //получаем фото из строки url
        let urlString = group.photo
        guard let urlAvatar = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlAvatar)
            DispatchQueue.main.async {
                self.groupAvatar.image = UIImage(data: data!)
            }
        }
       saveItem = group
    }
    
    func configCellOtherGroup(group: OtherGroupRealm) {
        
        groupName.text = group.name
        
//        //получаем фото из строки url
        let urlString = group.photo
        guard let urlAvatar = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlAvatar)
            DispatchQueue.main.async {
                self.groupAvatar.image = UIImage(data: data!)
            }
        }

    }
}
