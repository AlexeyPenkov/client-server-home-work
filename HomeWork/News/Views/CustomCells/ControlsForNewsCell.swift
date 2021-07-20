//
//  ControlsForNewsCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class ControlsForNewsCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func clearCell() {
        likeCounter.text = nil
    }
    
    func configCell(likeCount: String) {
        likeCounter.text = likeCount
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
    }
   
    
}
