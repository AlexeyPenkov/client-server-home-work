//
//  AutorCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class AutorNewsCell: UITableViewCell {

    @IBOutlet weak var autorLabel: UILabel!
    
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
        autorLabel.text = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
}
