//
//  GroupTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 12.04.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {

    @IBOutlet weak var groupTableView: UITableView!
    
    let groupCellIdentifier = "groupCellIdentifire"
    
    let fromMyCommunityToFindCommunitySegue = "myCommunityToFIndCommunity"
    
    var headSearchResposne: SearchResponseCommunity? = nil
    
    let funcForRealm = FuncForWorkingWithRealm()
    var groupArr = [GroupRealm]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //groupTableView.dataSource = self
        groupArr = funcForRealm.readGroupsFromRealm()
        
        if groupArr.count == 0 {
            let request = Network().getCommunityForCurrentUserList(selection: nil)
            Network().requestCommunity(request: request) { [weak self](result) in
                switch result {
                case .success(let searchResponse):
//                    self?.headSearchResposne = searchResponse.response
//                    self?.groupTableView.reloadData()
    //                searchResponse.response.items.map { user in
    //                    self.usersFromVK.append(user)
    //                }
                    self?.funcForRealm.writeGroupsFromRealm(response: searchResponse.response)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        //self.tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupCellIdentifier)
        groupTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupCellIdentifier)
     
        self.groupTableView.reloadData()
    
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
        
//        return headSearchResposne?.items.count ?? 0
        return groupArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupCellIdentifier, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }

        //let community = headSearchResposne?.items[indexPath.row]
        //cell.configCell(group: community!)

        cell.configCell(group: groupArr[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //DataStorage.share.groupsArray.remove(at: indexPath.row)
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
