//
//  GetUsersDataOperation.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 15.07.2021.
//

import Foundation
import Alamofire

class GetUsersDataOperation: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        
        super.cancel()
    }
    
    private var request: DataRequest //= 
    
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] responce in
            self?.data = responce.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
}


