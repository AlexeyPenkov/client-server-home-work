//
//  UserCollectionViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 15.04.2021.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class UserCollectionViewController: UICollectionViewController {

    var currentUserId: Int?
    let userFotoCellIdentifier = "userFotoCellIdentifire"
    
    var urlRequest: String = ""
    
    var searchRequest: StructUserPhoto?
   
    var photoArrayRealm = [PhotosRealm]()
    let funcForRealm = RealmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentIndex = currentUserId else { return }
        
        photoArrayRealm = funcForRealm.readPhotosFromRealm().filter { $0.userId == currentIndex
        }
    
        if photoArrayRealm.count == 0 {
            Network().getUserFoto(userId: currentIndex) { [weak self] item in
                self?.funcForRealm.writePhotosFromRealm(userId: currentIndex, photoArray: item)
            }
        }

        self.collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: userFotoCellIdentifier)
        
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
       
        //return photoArray.count
        return photoArrayRealm.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userFotoCellIdentifier, for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
        
        guard let curIndex = currentUserId else { return cell }
        
        
//        cell.configCell(userFoto: photoArray[indexPath.item])
        
        cell.configCell(userFoto: photoArrayRealm[indexPath.item])
            cell.currentCount = curIndex
            cell.currentItem = indexPath.item
            cell.delegate = self
            
        return cell
    }

}

extension UserCollectionViewController: CustomCellDelegate {
    func pressLikeButton(currCount: Int, currItem: Int, count: Int) {
//        DataStorage.share.usersArray[currCount].photoArray[currItem].countOfLike = count
    }
    
    func pressDislikeButton(currCount: Int, currItem: Int, count: Int) {
        //DataStorage.share.usersArray[currCount].photoArray[currItem].countOfDislike = count
    }
    
   
}
