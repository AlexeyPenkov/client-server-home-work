//
//  PhotosNewsCell.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 07.07.2021.
//

import UIKit

class PhotosNewsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionPhoto: UICollectionView!
    
    let cellIdentifire = "ImageToCollection"
    var photoArrayCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionPhoto.delegate = self
        collectionPhoto.dataSource = self
        
        collectionPhoto.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifire)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
