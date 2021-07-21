//
//  OtherGroupTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 12.04.2021.
//

import UIKit
import RealmSwift

class OtherGroupTableViewController: UITableViewController {
    
  
    @IBOutlet weak var mySearch: UISearchBar!
    
    
    let otherGroupCell = "otherGrouCell"
    
    var filteringGroupsArray = [OtherGroupRealm]();

    var searchIn = false
    
    var headSearchResposne: SearchResponseCommunity? = nil
    
    let funcForRealm = RealmService()
    
    var otherGroupArr: Results<OtherGroupRealm>? {
        didSet {
            token = otherGroupArr?.observe { changes in
                switch changes {
                case .initial(let results):
                    print("Start modified: \(results)")
                case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    self.tableView.reloadData()
                case .error(let error):
                    print("ERROR: \(error)")
                }
            }
        }
    }
    
    let realm = try! Realm()
    
    var token: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOtherGroupsArray(searchIn: searchIn)
        
        
        if otherGroupArr?.count == 0 {
//            Network().getOthersCommunity(selection: nil) { [weak self] (item) in
//                self?.funcForRealm.writeOtherGroupsInfoFromRealm(otherGroupArray: item)
//            }
            
            GetGroups().getGroups(selection: nil, on: .global())
                .get { [weak self] item in
                    self?.funcForRealm.writeOtherGroupsInfoFromRealm(otherGroupArray: item)
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
                
            //}
        }
        
        self.tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: otherGroupCell)
        
        mySearch.delegate = self
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchIn {
            return filteringGroupsArray.count
        } else {
            if let otherGroupArr = otherGroupArr {
                return otherGroupArr.count
            } else { return 0 }
            
        }
     
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: otherGroupCell, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
         
        if searchIn {

            let group = filteringGroupsArray[indexPath.row]
                cell.configCellOtherGroup(group: group)

        } else {

            if let group = otherGroupArr?[indexPath.row] {
                cell.configCellOtherGroup(group: group)
           }
        }
            
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

extension OtherGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteringGroupsArray.removeAll()
        searchIn = true
//        getOtherGroupsArray(searchIn: searchIn)
        let otherGroupArr = realm.objects(OtherGroupRealm.self).filter({$0.name.prefix(searchText.count).lowercased() == searchText.lowercased()})

        for item in otherGroupArr {
            let itemGroup = OtherGroupRealm()
            itemGroup.name = item.name
            itemGroup.id = item.id
            itemGroup.photo = item.photo
            filteringGroupsArray.append(itemGroup)
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchIn = false
        filteringGroupsArray.removeAll()
        mySearch.text = ""
        self.tableView.reloadData()
    }
    
    func getOtherGroupsArray(searchIn: Bool) {
        otherGroupArr = realm.objects(OtherGroupRealm.self)
    }
}
