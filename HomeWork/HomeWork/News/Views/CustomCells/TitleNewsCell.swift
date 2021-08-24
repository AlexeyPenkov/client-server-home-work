//
//  TitleNewsCell2.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class TitleNewsCell: UITableViewHeaderFooterView {

    let instets: CGFloat = 20
    
    
    @IBOutlet weak var titleNews: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    func configCell(title: String) {
        let isBigText = getSizeText(text: title)
        
        if isBigText {
            let smallTitle = String(title.prefix(80)+"...")
//            print(smallTitle)
            titleNews.text = smallTitle
        } else {
            titleNews.text = title
        }
       
    }

    
    func getLabelSize(text: String) -> CGFloat {
        var text = text
        if getSizeText(text: text) {
            text = String(text.prefix(80) + "...")
//            let range = text.range(of: "\r")
//            text = text.suffix(<#T##maxLength: Int##Int#>)
        }
        let maxWidth = bounds.maxX - instets * 2
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = (text as NSString).boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
        return ceil(rect.size.height) + instets * 2
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
