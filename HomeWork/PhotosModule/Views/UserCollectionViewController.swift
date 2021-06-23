//
//  UserCollectionViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 15.04.2021.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class UserCollectionViewController: UICollectionViewController {

    var currentUserId: Int?
    let userFotoCellIdentifier = "userFotoCellIdentifire"
    
    let realm = try! Realm()
    
    var token: NotificationToken?
    
    let funcForRealm = RealmService()
    
    var photoArrayRealm: Results<PhotosRealm>? {
        didSet {
            token = photoArrayRealm?.observe { changes in
                
                switch changes {
                case .initial(let results):
                    print("Start to modify", results)
                    //Pattern matching - Enum
                case .update(let results, let deletions, let insertions, let modifications):
                    self.collectionView.reloadData()
                case .error(let error):
                    print("error \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentIndex = currentUserId else { return }
        
        getPhotosArray(curIndex: String(currentIndex))
                
        if photoArrayRealm?.count == 0 {
            Network().getUserFoto(userId: currentIndex) { [weak self] item in
                self?.funcForRealm.writePhotosFromRealm(userId: currentIndex, photoArray: item)
            }
        }

        self.collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: userFotoCellIdentifier)
    
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        guard let currentIndex = currentUserId else { return 0 }
        
        getPhotosArray(curIndex: String(currentIndex))
        
        if let photos = photoArrayRealm {
            return photos.count
        } else { return 0}
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userFotoCellIdentifier, for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
        
        guard let curIndex = currentUserId else { return cell }
        
        getPhotosArray(curIndex: String(curIndex))
       
        cell.configCell(userFoto: photoArrayRealm?[indexPath.item])
            cell.currentCount = curIndex
            cell.currentItem = indexPath.item
            cell.delegate = self
            
        return cell
    }

}

extension UserCollectionViewController: CustomCellDelegate {
    func pressLikeButton(currCount: Int, currItem: Int, count: Int) {

    }
    
    func pressDislikeButton(currCount: Int, currItem: Int, count: Int) {

    }
    
    func getPhotosArray(curIndex: String) {
                
        photoArrayRealm = realm.objects(PhotosRealm.self)
            .filter("userId = \(curIndex)")
        
    }
   
}
