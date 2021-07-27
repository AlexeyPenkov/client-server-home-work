//
//  NewsTableViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 25.04.2021.
//

import UIKit


class NewsTableViewController: UITableViewController {

    var heigth: CGFloat?
    
    let newsPost = NewsPostService()
    
    let headerID = String(describing: TitleNewsCell.self)
    
    private func tableViewConfig() {
            let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        
        tableView.tableFooterView = UIView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfig()
        
        self.newsPost.getNewsArray()
        
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global().async(group: dispatchGroup){
            
            self.newsPost.getProfileArr()
            self.newsPost.getNewsGroup()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       // return newsArr.count
        return newsPost.newsArray.count
        //return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let arrAttachments = newsPost.getItemNews(id: section).attachments else { return 4 }
//        return arrAttachments.count
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? TitleNewsCell else { return UIView() }
        header.configCell(title: newsPost.getItemNews(id: section).text)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerLabel = newsPost.getItemNews(id: section).text
        
//        return 50
        return TitleNewsCell().getLabelSize(text: headerLabel)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        switch indexPath.row {
        case 0:
            self.tableView.register(UINib(nibName: "AutorNewsViewCell", bundle: nil), forCellReuseIdentifier: "AutorNewsViewCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutorNewsViewCell", for: indexPath) as? AutorNewsViewCell else { return UITableViewCell() }
            cell.configCell(autor: newsPost.newsProfile.first?.firstName)
            return cell
        case 1:
            self.tableView.register(UINib(nibName: "NewsEntryCell", bundle: nil), forCellReuseIdentifier: "NewsEntryCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsEntryCell", for: indexPath) as? NewsEntryCell  else { return UITableViewCell() }
            cell.configCell(news: newsPost.getItemNews(id: indexPath.section).text)
            return cell
        case 2:
            if let arrAttachments = newsPost.getItemNews(id: indexPath.section).attachments {
                if arrAttachments.count > 0 {
                    self.tableView.register(UINib(nibName: "PhotosNewsCell", bundle: nil), forCellReuseIdentifier: "PhotosNewsCell")

                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosNewsCell", for: indexPath) as? PhotosNewsCell  else { return UITableViewCell() }

                    guard let arrAttachments = newsPost.getItemNews(id: indexPath.section).attachments else { return cell }
                    cell.arrAttachments = arrAttachments
                    cell.configCell()
                    return cell
                } else {
                    self.tableView.register(UINib(nibName: "ControlsForNewsCell", bundle: nil), forCellReuseIdentifier: "ControlsForNewsCell")
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as? ControlsForNewsCell  else { return UITableViewCell() }
                    cell.configCell(likeCount: String(newsPost.getItemNews(id: indexPath.section).likes.count))
                    return cell
                    }
            } else {
                self.tableView.register(UINib(nibName: "ControlsForNewsCell", bundle: nil), forCellReuseIdentifier: "ControlsForNewsCell")
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as? ControlsForNewsCell  else { return UITableViewCell() }
                cell.configCell(likeCount: String(newsPost.getItemNews(id: indexPath.section).likes.count))
                return cell
            }
//            self.tableView.register(UINib(nibName: "PhotosNewsCell", bundle: nil), forCellReuseIdentifier: "PhotosNewsCell")
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosNewsCell", for: indexPath) as? PhotosNewsCell  else { return UITableViewCell() }
////            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosNewsCell", for: indexPath) as! PhotosNewsCell
//            guard let arrAttachments = newsPost.getItemNews(id: indexPath.section).attachments else { return cell }
//            cell.arrAttachments = arrAttachments
//            cell.configCell()
//            return cell
        case 3:
            self.tableView.register(UINib(nibName: "ControlsForNewsCell", bundle: nil), forCellReuseIdentifier: "ControlsForNewsCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as? ControlsForNewsCell  else { return UITableViewCell() }
            cell.configCell(likeCount: String(newsPost.getItemNews(id: indexPath.section).likes.count))
            return cell
        default:
            return UITableViewCell()
        }
    }
       
    
            
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: newCellIdentifier, for: indexPath)
        
//        cell.textLabel?.text = "Section: \(indexPath.section), row: \(indexPath.row)"
        
        //cell.configCell(news: newsArr[indexPath.row])
//        cell.configCell(news: "Новость \(indexPath)")

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let headerLabel = newsPost.getItemNews(id: indexPath.section).text
        
       
        if indexPath.row == 1 {
            return NewsEntryCell().getLabelSize(text: headerLabel)
        }else if indexPath.row == 2 {
            return 200
        } else {
            return 40
        }
        
    }

    
    
}
