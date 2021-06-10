//
//  FriendsListViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 21.04.2021.
//

import UIKit
import RealmSwift


class FriendsListViewController: UIViewController {

    @IBOutlet weak var friedsListTableView: UITableView!
    
    @IBOutlet weak var myControl: ControlFriendListTableView!
    
    let userCellIdentifier = "userCellIdentifire"
    
    let tableToCollectionSegue = "fromUserTableToCollection"
    
    var currentUserId: Int?
    
    var isFiltering = false
    
    var filteringFriendsArray = [UserInfo]()
    
    let delegate = UserCollectionViewController()
    
    var usersFromVK: [UserInfo] = []
    
    var userArr = [UserRealm]()
    
    let funcForRealm = RealmService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userArr = funcForRealm.readUserFromRealm()
//        Network().getFriends { [weak self] items in
//            self?.usersFromVK = items
//        }
        
        //if (userArr.count == 0) || (userArr.count != usersFromVK.count) {
        if userArr.count == 0 {
            funcForRealm.clearUsersRealm()
            let  group = DispatchGroup()
            group.enter()
            Network().getFriends {[weak self] items in
                self?.funcForRealm.writeUserInfoToRealm(userArray: items)
                group.leave()
            }
            
            group.notify(queue: .main) { [weak self] in
                self?.friedsListTableView.reloadData()
            }
        }

        friedsListTableView.dataSource = self
        friedsListTableView.delegate = self
        
        let userCell = UINib(nibName: "MyFriendsTableViewCell", bundle: nil)
        
        friedsListTableView.register(userCell, forCellReuseIdentifier: userCellIdentifier)
        
        
        friedsListTableView.reloadData()
    }

}

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friedsListTableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as? MyFriendsTableViewCell else { return UITableViewCell() }

            let user = userArr[indexPath.row]
            
            cell.configCell(user: user)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        currentUserId = userArr[indexPath.row].id
        
        performSegue(withIdentifier: tableToCollectionSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isFiltering {
            filteringFriendsArray.remove(at: indexPath.row)
        } 
        friedsListTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let dst = segue.destination as? UserCollectionViewController else { return }
        dst.currentUserId = currentUserId
    
    }
    
 
    
}



