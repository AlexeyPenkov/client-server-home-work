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
    
    var networkService = Network()
    
    private func tableViewConfig() {
            let nib = UINib(nibName: headerID, bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
        
        tableView.tableFooterView = UIView()
        
    }
    
    var newsArray : [ItemNews] = []
//    var newsProfiles = [Profile]()
    
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewConfig()
        
//        self.newsPost.getNewsArray(countNews: 10, startTime: nil)
        networkService.getNewsPost(count: 10, startTime: nil, startFrom: networkService.nextForm) { [weak self] item in
            self?.newsArray.append(contentsOf: item)
            self?.tableView.reloadData()
        }
        
        for item in self.newsPost.newsArray {
            newsArray.append(item)
        }
//        self.newsArray = self.newsPost.newsArray
        let dispatchGroup = DispatchGroup()
        DispatchQueue.global().async(group: dispatchGroup)
        {
             
            self.newsPost.getProfileArr()
            self.newsPost.getNewsGroup()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            
            self.tableView.reloadData()
        }
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Обновляю новости...")
        refreshControl.tintColor = .cyan
        refreshControl.addTarget(self, action: #selector(onRefreshTriggered), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        tableView.prefetchDataSource = self
    }

    @objc private func onRefreshTriggered() {
        self.refreshControl?.beginRefreshing()
        let mostFreshNewsDate: Double
        if let date = self.newsArray.first?.date
        {
            mostFreshNewsDate = Double(date)
        } else {
            mostFreshNewsDate = Date().timeIntervalSince1970
        }
        var newsUpdateArr = [ItemNews]()
        
        networkService.getNewsPost(count: 10, startTime: mostFreshNewsDate, startFrom: networkService.nextForm) { item in
            guard item.count > 0  else { return }
            newsUpdateArr.append(contentsOf: item)
           // self?.newsArray.append(contentsOf: item)
        }
        self.refreshControl?.endRefreshing()
        if newsUpdateArr.count > 0 {
            self.newsArray = newsUpdateArr + self.newsArray
            let indexSet = IndexSet(integersIn: 0..<newsArray.count)
            self.tableView.insertSections(indexSet, with: .automatic)
            self.tableView.reloadData()
        }
        
        //
    }
    
    
    func getHeigthTableViewCellForPhoto(photo: Photo, width: CGFloat) -> CGFloat? {
        guard let widthPhoto = photo.sizes.first?.width,
              let heigthPhoto = photo.sizes.first?.height else { return 0 }
        
        let aspectRatio = CGFloat(widthPhoto / heigthPhoto)
        return width * aspectRatio
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return newsArray.count
//        return newsPost.newsArray.count
        //return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        guard let arrAttachments = newsPost.getItemNews(id: section).attachments else { return 4 }
       // guard let arrAttachments = newsArray[section].attachments else { return 4 }
        guard let photo = newsArray[section].attachments?.first?.photo else { return 3}
//        return arrAttachments.count
        return 4
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as? TitleNewsCell else { return UIView() }
//        header.configCell(title: newsPost.getItemNews(id: section).text)
        header.configCell(title: newsArray[section].text)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let headerLabel = newsPost.getItemNews(id: section).text
        let headerLabel = newsArray[section].text
        
//        return 50
        return TitleNewsCell().getLabelSize(text: headerLabel)
        //return UITableView.automaticDimension
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
//            cell.configCell(news: newsPost.getItemNews(id: indexPath.section).text)
            var indexSet = IndexSet()
            indexSet.insert(indexPath.section)
            cell.indexPath = indexPath
            //cell.section = indexSet
            cell.delegate = self
            cell.configCell(news: newsArray[indexPath.section].text)
            return cell
        case 2:
           if let photo = newsArray[indexPath.section].attachments?.first?.photo {
                    self.tableView.register(UINib(nibName: "PhotosNewsCell", bundle: nil), forCellReuseIdentifier: "PhotosNewsCell")

                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosNewsCell", for: indexPath) as? PhotosNewsCell  else { return UITableViewCell() }

                    guard let arrAttachments = newsArray[indexPath.section].attachments else { return cell }
                    cell.arrAttachments = arrAttachments
                    cell.configCell()
                    return cell
           } else {
                self.tableView.register(UINib(nibName: "ControlsForNewsCell", bundle: nil), forCellReuseIdentifier: "ControlsForNewsCell")
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as? ControlsForNewsCell  else { return UITableViewCell() }
                    cell.configCell(likeCount: String(newsArray[indexPath.section].likes.count))
                return cell
            }

        case 3:
            self.tableView.register(UINib(nibName: "ControlsForNewsCell", bundle: nil), forCellReuseIdentifier: "ControlsForNewsCell")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ControlsForNewsCell", for: indexPath) as? ControlsForNewsCell  else { return UITableViewCell() }
//            cell.configCell(likeCount: String(newsPost.getItemNews(id: indexPath.section).likes.count))
            cell.configCell(likeCount: String(newsArray[indexPath.section].likes.count))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let headerLabel = newsArray[indexPath.section].text
        
        if indexPath.row == 1 {
            return NewsEntryCell().getLabelSize(text: headerLabel)
        }else if indexPath.row == 2 {
            if let photo = newsArray[indexPath.section].attachments?.first?.photo {
                let tableViewWidth = tableView.bounds.width
                if let heigthTableViewCell = getHeigthTableViewCellForPhoto(photo: photo, width: tableViewWidth) {
                        return heigthTableViewCell
                    } else {
                        return UITableView.automaticDimension
                    }
            } else {
                return UITableView.automaticDimension
            }
        } else {
//            return 40
            return UITableView.automaticDimension
        }
    }
}

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({$0.section}).max() else { return }
        
        if maxSection > newsArray.count - 3,
           !isLoading {
            isLoading.toggle()
            networkService.getNewsPost(count: 10, startTime: nil, startFrom: networkService.nextForm) { [weak self] item in
                guard let self = self else { return }
                let indexSet = IndexSet(integersIn: self.newsArray.count ..< self.newsArray.count+item.count)
                self.newsArray.append(contentsOf: item)
                self.tableView.insertSections(indexSet, with: .none)
                //self.tableView.reloadData()
                self.isLoading.toggle()
                
            }
        }
    }
    
}
