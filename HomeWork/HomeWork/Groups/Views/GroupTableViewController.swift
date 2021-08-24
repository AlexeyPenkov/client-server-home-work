//
//  GroupTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 12.04.2021.
//

import UIKit
import RealmSwift
import Firebase


class GroupTableViewController: UITableViewController {

    @IBOutlet weak var groupTableView: UITableView!
    
    let groupCellIdentifier = "groupCellIdentifire"
    
    let fromMyCommunityToFindCommunitySegue = "myCommunityToFIndCommunity"
    
    let funcForRealm = RealmService()
  
    let realm = try! Realm()
    
    var token: NotificationToken?
    
    var groupsRealm: Results<GroupRealm>? {
        didSet {
            token = groupsRealm?.observe { changes in
                switch changes {
                case .initial(let results):
                    print("Start modified: \(results)")
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    self.groupTableView.reloadData()
                case .error(let error):
                    print("ERROR: \(error)")
                }
            }
        }
    }
    
    private let group = [FBGroups]()
    
    private let ref = Database.database().reference(withPath: "users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsRealm = realm.objects(GroupRealm.self)
                
        if groupsRealm?.count == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//            Network().getCommunity { [weak self] (item) in
//                self?.funcForRealm.writeGroupsInfoFromRealm(groupArray: item)
//            }
        GetGroups().getUserGroups(on: .global())
            .get { [weak self] item in
                self?.funcForRealm.writeGroupsInfoFromRealm(groupArray: item)
            }
            .done { [weak self ]_ in
                self?.tableView.reloadData()
            }
            .catch { error in
                print(error)
            }
            .finally {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
        }
        
        groupTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupCellIdentifier)
    
        if let communitys = groupsRealm {
            for item in communitys {
                let group = FBGroups(name: item.name, groupid: item.id)
                let groupRef = self.ref.child(String(Session.shared.userID)).child(item.name)
                groupRef.setValue(group.toDictionary())
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let groups = groupsRealm {
            return groups.count
        } else { return 0 }
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupCellIdentifier, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        
        if let group = groupsRealm?[indexPath.row] {
            cell.configCell(group: group)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.tableView.reloadData()
    }
  
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    @IBAction func pressFinfCommunity() {
        performSegue(withIdentifier: fromMyCommunityToFindCommunitySegue, sender: nil)
    }
    
    @IBAction func clearRealm() {
        funcForRealm.clearUsersRealm()
    }

}
