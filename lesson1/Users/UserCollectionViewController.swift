//
//  UserCollectionViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 15.04.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class UserCollectionViewController: UICollectionViewController {

    var currentIndex: Int?
    let userFotoCellIdentifier = "userFotoCellIdentifire"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: userFotoCellIdentifier)
        

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let curIndex = currentIndex {
            return DataStorage.share.usersArray[curIndex].photoArray.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userFotoCellIdentifier, for: indexPath) as? UserCollectionViewCell else { return UICollectionViewCell() }
        if let curIndex = currentIndex {
            cell.configCell(userFoto: DataStorage.share.usersArray[curIndex].photoArray[indexPath.item])
            
            cell.currentCount = curIndex
            cell.currentItem = indexPath.item
            cell.delegate = self
            
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension UserCollectionViewController: CustomCellDelegate {
    func pressLikeButton(currCount: Int, currItem: Int, count: Int) {
        DataStorage.share.usersArray[currCount].photoArray[currItem].countOfLike = count
    }
    
    func pressDislikeButton(currCount: Int, currItem: Int, count: Int) {
        DataStorage.share.usersArray[currCount].photoArray[currItem].countOfDislike = count
    }
    
   
}
