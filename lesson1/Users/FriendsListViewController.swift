//
//  FriendsListViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 21.04.2021.
//

import UIKit

class FriendsListViewController: UIViewController {

    @IBOutlet weak var friedsListTableView: UITableView!
    
    @IBOutlet weak var myControl: ControlFriendListTableView!
    
    let userCellIdentifier = "userCellIdentifire"
    
    let tableToCollectionSegue = "fromUserTableToCollection"
    
    var currentIndex: Int?
    
    var isFiltering = false
    
    var filteringFriendsArray = [User]()
    
    let delegate = UserCollectionViewController()
    
    var myCell = MyFriendsTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friedsListTableView.dataSource = self
        friedsListTableView.delegate = self
        
        let userCell = UINib(nibName: "MyFriendsTableViewCell", bundle: nil)
        
        friedsListTableView.register(userCell, forCellReuseIdentifier: userCellIdentifier)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteringFriendsArray.count
        } else {
            return DataStorage.share.usersArray.count
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = friedsListTableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as? MyFriendsTableViewCell else { return UITableViewCell() }

        if isFiltering {
            cell.configCell(user: filteringFriendsArray[indexPath.row])
        } else {
            cell.configCell(user: DataStorage.share.usersArray[indexPath.row])
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
       
        currentIndex = indexPath.row
        
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
        dst.currentIndex = currentIndex
    
    }
}




extension FriendsListViewController: CustomControlProtocol {
    func setFindLiteral(literal: Literal?) {
        guard let literal = literal else { return }
        
        filteringFriendsArray = DataStorage.share.usersArray.filter({$0.name.prefix(1) == literal.title})
        
        isFiltering = true
        friedsListTableView.reloadData()
        
    }
    
    
    
}
