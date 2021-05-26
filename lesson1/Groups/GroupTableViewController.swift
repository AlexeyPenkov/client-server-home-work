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
    
    //let groupCell =
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //groupTableView.dataSource = self
        
        
        
        //self.tableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupCellIdentifier)
        groupTableView.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: groupCellIdentifier)
     
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        // #warning Incomplete implementation, return the number of rows
        return DataStorage.share.groupsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: groupCellIdentifier, for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }

        cell.configCell(group: DataStorage.share.groupsArray[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataStorage.share.groupsArray.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
  
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    @IBAction func pressFinfCommunity() {
        performSegue(withIdentifier: fromMyCommunityToFindCommunitySegue, sender: nil)
    }
    

}
