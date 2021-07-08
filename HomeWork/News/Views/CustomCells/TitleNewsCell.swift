//
//  TitleNewsCell2.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class TitleNewsCell: UITableViewHeaderFooterView {

    @IBOutlet weak var titleNews: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func configCell(title: String) {
       titleNews.text = title
    }

}
