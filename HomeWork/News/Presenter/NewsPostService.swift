//
//  NewsPostService.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 09.07.2021.
//

import Foundation

class NewsPostService {
    var newsArray = [ItemNews]()
    var newsPhotoArray = [Int: [Size]]()
    var newsProfile = [Profile]()
    var newsGroup = [Group]()
    
    
    func getNewsArray() {
        Network().getNewsPost { [weak self] item in
            self?.newsArray.append(contentsOf: item)
        }
    }
    
    func getItemNews(id: Int) -> ItemNews {
        return newsArray[id]
    }
    
//    func getNewsPhotoArray() {
//        Network().getNewsPhoto { [weak self] dict in
//            self?.newsPhotoArray.updateValue
//        }
//    }
    
    func getProfileArr() {
        Network().getNewsProfile { [weak self] profile in
            self?.newsProfile.append(contentsOf: profile)
        }
    }
    
    func getNewsGroup() {
        Network().getNewsGroups { [weak self] group in
            self?.newsGroup.append(contentsOf: group)
        }
    }
}
