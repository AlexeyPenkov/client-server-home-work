//
//  ParseUserData.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 20.07.2021.
//

import Foundation

class ParseUserData: Operation {
    
    var outputData = [UserInfo]()
    
    override func main() {
        guard let getUserDataOperation = dependencies.first as? GetDataOperation,
              let data = getUserDataOperation.data else { return }
        print("АЛЯРМА!!!!!")
        print(data.prettyJSON)
        print("У меня все")
        do {
            let userList = try JSONDecoder().decode(HeadResponseUsers.self, from: data)
            outputData = userList.response.items
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
        }
        
      
    }
}
