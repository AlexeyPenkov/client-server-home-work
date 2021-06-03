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
    
//    var filteringFriendsArray = [User]()
    var filteringFriendsArray = [UserInfo]()
    
    let delegate = UserCollectionViewController()
    
    var myCell = MyFriendsTableViewCell()
    
    var usersFromVK: [UserInfo] = []
    var headSearchResposne: SearchResponseUsers? = nil
    
    var userArr = [UserRealm]()
    
    let funcForRealm = FuncForWorkingWithRealm()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // clearUsersRealm()
        userArr = funcForRealm.readUserFromRealm()
        
        if userArr.count == 0 {
            let request = Network().getFriendsList()
            Network().requestUsers(request: request) { [weak self](result) in
                switch result {
                case .success(let searchResponse):
//                    self?.headSearchResposne = searchResponse.response
//                    self?.friedsListTableView.reloadData()
    //                searchResponse.response.items.map { user in
    //                    self.usersFromVK.append(user)
    //                }
                    self?.funcForRealm.writeUserToRealm(response: searchResponse.response)
                case .failure(let error):
                    print(error)
                }
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
        
//        if isFiltering {
//            return filteringFriendsArray.count
//        } else {
//            return DataStorage.share.usersArray.count
//        }
        
       // let userArray = Network().getFriendsList()
        //return usersFromVK.count
//        let userArray = readUserFromRealm()
        
        //return headSearchResposne?.count ?? 0
        return userArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friedsListTableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as? MyFriendsTableViewCell else { return UITableViewCell() }

        if isFiltering {
            //cell.configCell(user: filteringFriendsArray[indexPath.row])
        } else {
            //cell.configCell(user: DataStorage.share.usersArray[indexPath.row])
            //let user = headSearchResposne?.items[indexPath.row]
            
            let user = userArr[indexPath.row]
            
            cell.configCell(user: user)
            
            //получаем фото из строки url
//            let urlString = user.photo
//            let urlAvatar = URL(string: urlString)
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: urlAvatar!)
//                DispatchQueue.main.async {
//                    cell.friendAvatar.image = UIImage(data: data!)
//                }
//            }
            
        }
        //cell.selectionStyle = UITableViewCell.SelectionStyle.blue
        //cell.delegate = self
//        cell.tapOnCell = { (success) in
//            if success {
//                self.animatedCell(atCell: cell)
//            }
//        }
        myCell = cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //currentUserId = headSearchResposne?.items[indexPath.row].id
        currentUserId = userArr[indexPath.row].id
        //animateImage(cell: myCell)
        
        performSegue(withIdentifier: tableToCollectionSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isFiltering {
            filteringFriendsArray.remove(at: indexPath.row)
        } else {
            DataStorage.share.usersArray.remove(at: indexPath.row)
        }
        friedsListTableView.reloadData()
        //self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //if segue.identifier == tableToCollectionSegue {
            guard let dst = segue.destination as? UserCollectionViewController else { return }
        dst.currentUserId = currentUserId
    
    }
    
 
    
}



//Все равно пока не работает

//extension FriendsListViewController: CustomControlProtocol {
//    func setFindLiteral(literal: Literal?) {
//        guard let literal = literal else { return }
//
////        filteringFriendsArray = DataStorage.share.usersArray.filter({$0.name!.prefix(1) == literal.title})
//
//        filteringFriendsArray = usersFromVK.filter({$0.firstName.prefix(1) == literal.title})
//
//        isFiltering = true
//        friedsListTableView.reloadData()
//
//    }
    
    
    
//}
