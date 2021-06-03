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
   
    var photoArray = [Photo]()
    var photoArrayRealm = [PhotosRealm]()
    let funcForRealm = FuncForWorkingWithRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentIndex = currentUserId else { return }
        
        photoArrayRealm = funcForRealm.readPhotosFromRealm().filter { $0.userId == currentIndex
        }
    
        if photoArrayRealm.count == 0 {
            urlRequest = Network().requestUserPhotioForAlomofire(userId: currentIndex)
            
            AF.request(urlRequest, method: .get).responseData { [self] response in
                guard let data = response.value else { return }
                
                self.searchRequest = try? JSONDecoder().decode(StructUserPhoto.self, from: data)
                
                funcForRealm.writePhotosFromRealm(response: self.searchRequest!.response)
            
//            self.photoArray.removeAll()
//
//            self.searchRequest?.response.items.forEach({ item in
//                item.sizes.forEach { size in
//                    //print("Здесь должен быть ЮРЛ \(size.url)")
//                    if size.width == 320 {
//                        let photoItem = Photo(url: size.url)
//                        self.photoArray.append(photoItem)
//                    }
////                    print(self.photoArray.count)
//                }
//            })
            
               
                
            }
        }
//        let request = Network().getPhotos(userId: currentIndex)
//        
//        Network().requestUserPhotos(request: request) { [weak self](result) in
//            switch result {
//            case .success(let searchResponse):
//                self?.headSearchResponse = searchResponse.response
//                //self?.headSearchResposne = searchResponse.response
//                self?.collectionView.reloadData()
////                searchResponse.response.items.map { user in
////                    self.usersFromVK.append(user)
////                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//        photoArray.removeAll()
//        
//        headSearchResponse?.items.forEach({ photo in
//            photo.sizes.forEach { urlString in
//            photoArray.append(urlString)
//            }
//            
//        })
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
