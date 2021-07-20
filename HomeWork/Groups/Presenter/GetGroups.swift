//
//  GetGroups.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 20.07.2021.
//

import Foundation
import Alamofire
import PromiseKit

class GetGroups {
    func getUserGroups(on queue: DispatchQueue = .main) -> Promise<[CommunityInfo]> {
        let promise = Promise<Data> { resolver in
            AF.request(Network().getCommunityForCurrentUserRequest(selection: nil)).responseData { response in
                if let data = response.data {
                    resolver.fulfill(data)
                }
                if let error = response.error {
                    resolver.reject(error)
                }
            }
            
        }
        .map { data in
            return try JSONDecoder().decode(HeadResponseCommunity.self, from: data)
        }
        .map { $0.response.items
        }
        
        return promise
    }
}
