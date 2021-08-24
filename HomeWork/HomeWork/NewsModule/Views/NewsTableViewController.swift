//
//  NewsTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 25.04.2021.
//

import UIKit
import Firebase

class NewsTableViewController: UITableViewController {

    var heigth: CGFloat?
    
    let newCellIdentifier = "newCellIdentifier"
    
    var newsArr = [ItemsNews]()
    
//    var usersRealm: Results<UserRealm>? {
//        didSet {
//            token = usersRealm?.observe { changes in
//                
//                switch changes {
//                case .initial(let results):
//                    print("Start to modify", results)
//                    //Pattern matching - Enum
//                case .update(let results, let deletions, let insertions, let modifications):
//                    self.friedsListTableView.reloadData()
//                case .error(let error):
//                    print("error \(error.localizedDescription)")
//                }
//            }
//        }
//    }
    
    private var AuthorizedUsers = [FBUsers]()
    
    private let ref = Database.database().reference(withPath: "users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network().getNews { [weak self] item in
            self?.newsArr.append(contentsOf: item)
        }
        
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: newCellIdentifier)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return DataStorage.share.newsArr.count
        return newsArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: newCellIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        cell.configCell(news: newsArr[indexPath.row])
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 500
    }

}
