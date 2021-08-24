//
//  AutorNewsViewCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 12.07.2021.
//

import UIKit

class AutorNewsViewCell: UITableViewCell {

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
    
    func configCell(autor: String?) {
        guard let autor = autor else { return }
        autorLabel.text = autor
    }
    
    override func prepareForReuse() {
        clearCell()
    }
}
