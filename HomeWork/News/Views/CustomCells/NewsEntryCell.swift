//
//  NewsEntryCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class NewsEntryCell: UITableViewCell {

    let instets: CGFloat = 10
    
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
    
    func getLabelSize(text: String) -> CGFloat {
        let maxWidth = bounds.maxX - instets * 2
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = (text as NSString).boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        return ceil(rect.size.height) + instets * 2
    }
}
