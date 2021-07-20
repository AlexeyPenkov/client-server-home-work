//
//  ReloadUsersTableController.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 20.07.2021.
//

import Foundation

class ReloadUserTableContoller: Operation {
    var controller: FriendsListViewController
    
    init (controller: FriendsListViewController) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? ParseUserData else { return }
        RealmService().writeUserInfoToRealm(userArray: parseData.outputData)
        controller.friedsListTableView.reloadData()
    }
    
}
