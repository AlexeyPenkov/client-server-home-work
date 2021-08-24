//
//  UsersPresenter.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 23.06.2021.
//

import Foundation

protocol UserViewProtocol: class {
    func set()
}

protocol UserViewPresenterProtocol {
    init(view: UserViewProtocol)
    
    func showUsers()
}

class UserPresenter: UserViewPresenterProtocol {
    
    let view: UserViewProtocol
    
    required init(view: UserViewProtocol) {
        self.view = view
    }
    
    func showUsers() {
       
    }
    
    
}
