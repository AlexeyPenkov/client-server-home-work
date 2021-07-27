//
//  FriendsListViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 21.04.2021.
//

import UIKit
import RealmSwift
import Firebase
import Alamofire


class FriendsListViewController: UIViewController {

    @IBOutlet weak var friedsListTableView: UITableView!
    
    //@IBOutlet weak var myControl: ControlFriendListTableView!
    
    let userCellIdentifier = "userCellIdentifire"
    
    let tableToCollectionSegue = "fromUserTableToCollection"
    
    var currentUserId: Int?
    
    var isFiltering = false
    
    var filteringFriendsArray = [UserInfo]()
    
    let delegate = UserCollectionViewController()

    let funcForRealm = RealmService()
    
    let realm = try! Realm()
    
    var token: NotificationToken?
    
    var usersRealm: Results<UserRealm>? {
        didSet {
            token = usersRealm?.observe { changes in
                
                switch changes {
                case .initial(let results):
                    print("Start to modify", results)
                    //Pattern matching - Enum
                case .update(let results, let deletions, let insertions, let modifications):
                    self.friedsListTableView.reloadData()
                case .error(let error):
                    print("error \(error.localizedDescription)")
                }
            }
        }
    }
        
    private var AuthorizedUsers = [FBUsers]()
    
    private let ref = Database.database().reference(withPath: "users")
    
    //var presenter: UserViewPresenterProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //presenter.showUsers()
        
        let authorizedUsers = FBUsers(id: Session.shared.userID)
        let userRef = self.ref.child(String(Session.shared.userID))
        userRef.setValue(authorizedUsers.toDictionary())
        
        usersRealm = realm.objects(UserRealm.self)
       
        if usersRealm?.count == 0 {
            funcForRealm.clearUsersRealm()
//            Network().getFriends {[weak self] items in
//                self?.funcForRealm.writeUserInfoToRealm(userArray: items)
//            }
            let myQueue = OperationQueue()
            let request = AF.request(Network().getFriendsRequest())
            let getUserDataOperation = GetDataOperation(request: request)
            myQueue.addOperation(getUserDataOperation)
            let parseData = ParseUserData()
            parseData.addDependency(getUserDataOperation)
            myQueue.addOperation(parseData)
            let reloadRealmUsers = ReloadUserTableContoller(controller: self)
            reloadRealmUsers.addDependency(parseData)
            OperationQueue.main.addOperation(reloadRealmUsers)
        }

        friedsListTableView.dataSource = self
        friedsListTableView.delegate = self
        
        let userCell = UINib(nibName: "MyFriendsTableViewCell", bundle: nil)
        
        friedsListTableView.register(userCell, forCellReuseIdentifier: userCellIdentifier)

    }

}

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let usersRealm = realm.objects(UserRealm.self)
        return usersRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friedsListTableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as? MyFriendsTableViewCell else { return UITableViewCell() }
                    
        if let user = usersRealm?[indexPath.row] {            
            cell.configCell(user: user)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              
        currentUserId = usersRealm?[indexPath.row].id
        
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

//extension FriendsListViewController: UserViewProtocol {
//    func set() {
//        <#code#>
//    }
//
//
//}


