//
//  Session.swift
//  lesson1
//
//  Created by Алексей Пеньков on 24.05.2021.
//

import Foundation


class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String = ""
    var userID: Int = 0
    
}
