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
    
    var filteringGroupsArray = [Group]();

    var searchIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            return DataStorage.share.otherGroupsArray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: otherGroupCell, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        if searchIn {
            cell.configCell(group: filteringGroupsArray[indexPath.row])
        } else {
            cell.configCell(group: DataStorage.share.otherGroupsArray[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) as? GroupTableViewCell,
              let group = cell.saveItem as? Group else { return indexPath }
       
        var isEnableGroup = false
        if searchIn {
            for item in filteringGroupsArray {
                if item.name == group.name {
                    isEnableGroup = true
                }
            }

            if !isEnableGroup {
                filteringGroupsArray.append(group)
            }
        } else {
            for item in DataStorage.share.groupsArray {
                if item.name == group.name {
                    isEnableGroup = true
                }
            }
            
            if !isEnableGroup {
                DataStorage.share.groupsArray.append(group)
            }
        }
        self.navigationController?.popViewController(animated: true)
        return indexPath
    }
    
}

extension OtherGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteringGroupsArray = DataStorage.share.otherGroupsArray.filter({$0.name.prefix(searchText.count) == searchText})
        
        searchIn = true
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchIn = false
        mySearch.text = ""
        self.tableView.reloadData()
    }
}
