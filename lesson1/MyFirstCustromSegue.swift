//
//  MyFirstCustromSegue.swift
//  lesson1
//
//  Created by Алексей Пеньков on 10.05.2021.
//

import UIKit

class MyFirstCustromSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let src = self.source
        
        let dst = self.destination
        
        guard let tableViewController = src as? FriendsListViewController else { return }
        
        guard let indexPath = tableViewController.friedsListTableView.indexPathForSelectedRow else { return }
        
        guard let cell = tableViewController.friedsListTableView.cellForRow(at: indexPath) as? MyFriendsTableViewCell else { return }
        
        
        
        UIImageView.animate(withDuration: 0.05,
                            animations: {
                                cell.friendAvatar.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
//                                cell.friendAvatar.transform = CGAffineTransform.init(rotationAngle: 90)
                            },
                            completion: {[weak cell] _ in
                                UIImageView.animate(withDuration: 0.05,
                                                    delay: 0.05,
                                                    usingSpringWithDamping: 0.3,
                                                    initialSpringVelocity: 0,
                                                    options: [],
                                                    animations: {
                                                        cell?.friendAvatar.transform = .identity
//                                                        cell?.friendAvatar.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
                                                        //self?.friendAvatar.transform = .identity
                                                    },
                                                    completion: { _ in
                                                        super.perform()})
                            })
    }

}
