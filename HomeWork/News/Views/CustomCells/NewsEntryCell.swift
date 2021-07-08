//
//  NewsEntryCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class NewsEntryCell: UITableViewCell {

    @IBOutlet weak var newsEntryLabel: UILabel!
    
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
        newsEntryLabel.text = nil
    }
    
    func configCell(news: String?) {
        guard let news = news else { return }
        newsEntryLabel.text = news
    }
    
    override func prepareForReuse() {
        clearCell()
    }
}
