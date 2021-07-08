//
//  NewsTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 25.04.2021.
//

import UIKit


class NewsTableViewController: UITableViewController {

    var heigth: CGFloat?
    
    //let newCellIdentifier = "AutorNewsCell"
    
    var newsArr = [ItemNews]()
    
    let headerID = String(describing: TitleNewsCell.self)
    
    private func tableViewConfig() {
            let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        
        tableView.tableFooterView = UIView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfig()
        
        Network().getNews { [weak self] item in
            self?.newsArr.append(contentsOf: item)
        }
        
       
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return newsArr.count
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return DataStorage.share.newsArr.count
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? TitleNewsCell else { return UIView() }
        header.configCell(title: "Новость: \(section)")
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        switch indexPath.row {
        case 0:
            self.tableView.register(UINib(nibName: "AutorNewsCell", bundle: nil), forCellReuseIdentifier: "AutorNewsCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutorNewsCell", for: indexPath) as? AutorNewsCell else { return UITableViewCell() }
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AutorNewsCell", for: indexPath) as! AutorNewsCell
            
            return cell
        case 1:
            self.tableView.register(UINib(nibName: "NewsEntryCell", bundle: nil), forCellReuseIdentifier: "NewsEntryCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsEntryCell", for: indexPath) as? NewsEntryCell  else { return UITableViewCell() }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsEntryCell", for: indexPath) as! NewsEntryCell
            return cell
        case 2:
            self.tableView.register(UINib(nibName: "PhotosNewsCell", bundle: nil), forCellReuseIdentifier: "PhotosNewsCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosNewsCell", for: indexPath) as? PhotosNewsCell  else { return UITableViewCell() }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosNewsCell", for: indexPath) as! PhotosNewsCell
            return cell
        case 3:
            self.tableView.register(UINib(nibName: "ControlsForNewsCell", bundle: nil), forCellReuseIdentifier: "ControlsForNewsCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as? ControlsForNewsCell  else { return UITableViewCell() }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as! ControlsForNewsCell
            return cell
        default:
            return UITableViewCell()
        }
    }
       
    
            
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: newCellIdentifier, for: indexPath)
        
//        cell.textLabel?.text = "Section: \(indexPath.section), row: \(indexPath.row)"
        
        //cell.configCell(news: newsArr[indexPath.row])
//        cell.configCell(news: "Новость \(indexPath)")

    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 500
//    }

}
