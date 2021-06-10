//
//  OtherGroupTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 12.04.2021.
//

import UIKit

class OtherGroupTableViewController: UITableViewController {
    
  
    @IBOutlet weak var mySearch: UISearchBar!
    
    
    let otherGroupCell = "otherGrouCell"
    
    var filteringGroupsArray = [OtherGroupRealm]();

    var searchIn = false
    
    var headSearchResposne: SearchResponseCommunity? = nil
    
    let funcForRealm = RealmService()
    var otherGroupArr = [OtherGroupRealm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otherGroupArr = funcForRealm.readOtherGroupsFromRealm()
        
        if otherGroupArr.count == 0 {
            Network().getOthersCommunity(selection: nil) { [weak self] (item) in
                self?.funcForRealm.writeOtherGroupsInfoFromRealm(otherGroupArray: item)
            }
        }
        
        self.tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: otherGroupCell)
        
        mySearch.delegate = self
       
        self.tableView.reloadData()
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
            return otherGroupArr.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: otherGroupCell, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
            
        if searchIn {
            let group = filteringGroupsArray[indexPath.row]
            cell.groupName.text = group.name
                
                //получаем фото из строки url
                let urlString = group.photo
                if let urlAvatar = URL(string: urlString) {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: urlAvatar)
                        DispatchQueue.main.async {
                            cell.groupAvatar.image = UIImage(data: data!)
                        }
                    }
                }
        } else {
            let group = otherGroupArr[indexPath.row]
            cell.groupName.text = group.name
                
                //получаем фото из строки url
                let urlString = group.photo
                if let urlAvatar = URL(string: urlString) {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: urlAvatar)
                        DispatchQueue.main.async {
                            cell.groupAvatar.image = UIImage(data: data!)
                        }
                    }
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

        searchIn = true

        if otherGroupArr.count == 0 {
            Network().getOthersCommunity(selection: searchText) { [weak self] (item) in
                self?.funcForRealm.writeOtherGroupsInfoFromRealm(otherGroupArray: item)
            }
        } else {
            filteringGroupsArray = otherGroupArr.filter({$0.name.prefix(searchText.count).lowercased() == searchText.lowercased()})
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchIn = false
        mySearch.text = ""
        self.tableView.reloadData()
    }
}
