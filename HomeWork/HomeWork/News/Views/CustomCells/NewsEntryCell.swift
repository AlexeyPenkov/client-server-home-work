//
//  NewsEntryCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class NewsEntryCell: UITableViewCell {

    let instets: CGFloat = 10
    
    var textNewsFull: String = ""
    var textNewsSmall: String = ""
    var section: IndexSet? = nil
    var indexPath: IndexPath? = nil
    var delegate: UITableViewController? = nil
    var isHiddenBigText = true
    var noComputeSizeLabel = false
    
    @IBOutlet weak var newsEntryLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        var newsText = ""
        newsText = !isHiddenBigText ? textNewsSmall : textNewsFull
        
        if !isHiddenBigText {
            self.noComputeSizeLabel = false
            showButton.setTitle("show more ...", for: .normal)
        } else {
            self.noComputeSizeLabel = true
            showButton.setTitle("show less", for: .normal)
        }
        newsEntryLabel.text = newsText
//        guard let section = section else { return }
        guard let indexPath = indexPath else { return }
        delegate?.tableView.reloadRows(at: [indexPath], with: .automatic)
       // delegate?.tableView.reloadSections(section, with: .automatic)
        isHiddenBigText.toggle()
    }
    
    
    func clearCell() {
        newsEntryLabel.text = nil
        showButton.isHidden = true
        showButton.frame.size.height = 0
    }
    
    func configCell(news: String?) {
        guard let news = news else { return }
        let isBigText = getSizeText(text: news)
        
        if isBigText {
            self.textNewsFull = news
            self.textNewsSmall = String(news.prefix(100)+"...")
            newsEntryLabel.text = self.textNewsSmall
            showButton.setTitle("show more...", for: .normal)
            showButton.isHidden = false
            showButton.frame.size.height = 20
//            let showMoreButton = UIButton(frame: CGRect(x: bounds.minX, y: bounds.maxY-20, width: bounds.maxX-20, height: 20))
//            showMoreButton.setTitleColor(.blue, for: .normal)
//            showMoreButton.setTitle("Показать больше...", for: .normal)
//            showMoreButton.addTarget(self, action: #selector(showMoreButtonAction(_ : )), for: .touchUpInside)
//            self.addSubview(showMoreButton)
        } else {
            showButton.frame.size.height = 0
            showButton.isHidden = true
            newsEntryLabel.text = news
        }
    }
    
    @objc func showMoreButtonAction(_ text: String) {
        
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func getLabelSize(text: String) -> CGFloat {
        var text = text
        var isBigText = false
        if !noComputeSizeLabel && getSizeText(text: text){
            text = String(text.prefix(100) + "...")
            isBigText = true
        }
        let maxWidth = bounds.maxX - instets * 2
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = (text as NSString).boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        if isBigText {
            return ceil(rect.size.height) + instets * 2 + 40
        } else {
            return ceil(rect.size.height) + instets * 2
        }
    }
    
    func getSizeText(text: String) -> Bool {
        
        let maxWidth = bounds.maxX - instets * 2
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = (text as NSString).boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        if rect.height > 200 {
            return true
        } else {
            return false
        }
    }
}
