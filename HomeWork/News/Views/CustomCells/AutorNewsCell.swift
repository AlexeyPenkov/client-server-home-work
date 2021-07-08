//
//  AutorCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class AutorNewsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func clearCell() {
//        autorLabel.text = nil
    }
    
//    func configCell(autor: String?) {
//        guard let autor = autor else { return }
//        autorLabel.text = autor
//    }
    
    override func prepareForReuse() {
        clearCell()
    }
}
