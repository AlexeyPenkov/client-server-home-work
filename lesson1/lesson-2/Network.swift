//
//  Network.swift
//  lesson1
//
//  Created by Алексей Пеньков on 27.05.2021.
//

import Foundation
import Alamofire


class Network: NSObject {
    // URL для запроса к ВК
    private let baseUrl = "https://api.vk.com"
    // ключ для доступа к сервису (должен быть в синглтоне)
    let token = Session.shared.token
    let userID = Session.shared.userID
    
    var photoArray = [Photo]()
    
    var headSearchResponse: StructUserPhoto?
    //Подготовка запроса пользователей (друзей)
    //MARK: - getFriendsList
    func getFriendsList() ->URLRequest{
        
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        
        params.append(URLQueryItem(name: "user_id", value: String(self.userID)))
        params.append(URLQueryItem(name: "order", value: "name"))
        params.append(URLQueryItem(name: "fields", value: "photo"))
        
        requestUlr = prepareURLRequest(method: "friends.get", params: params)
        return requestUlr

    }
    
    func prepareURLRequest(method: String, params: [URLQueryItem]) ->URLRequest {
        var urlComponents = URLComponents()
    
            
        urlComponents = initURLReques(urlComponents: urlComponents , method: method)
    
        
        for i in 0...params.count-1 {
            urlComponents.queryItems?.append(params[i])
        }
    
        
        var requestUrl = URLRequest(url: urlComponents.url!)
        requestUrl.httpMethod = "GET"
        
        return requestUrl
    }
    
    func initURLReques(urlComponents: URLComponents, method: String) -> URLComponents {
        var urlComponents = urlComponents
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/"+method
        
        
        urlComponents.queryItems = [
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.131")
            ]
                    
        return urlComponents
    }

    //Запрос пользователей (друзей)
    //MARK: - requestUsers
    func requestUsers(request: URLRequest, complition: @escaping (Result<HeadResponseUsers, Error>)-> Void) {
        let configaration = URLSessionConfiguration.default
        let session = URLSession(configuration: configaration)
    
        session.dataTask(with: request) { data, response, error in
                
            DispatchQueue.main.async {
                if let error = error {
                    print("Some Error")
                    //complition(nil, error)
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let userList = try decoder.decode(HeadResponseUsers.self, from: data)
//                    complition(usersList, nil)
                    complition(.success(userList))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
//                    complition(nil, jsonError)
                    complition(.failure(jsonError))
                }
                

            }

        }.resume()
    }
    
    //Запрос сообществ
    //MARK: - getCommunityList
    func getCommunityList(selection: String?) -> URLRequest {
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        
        params.append(URLQueryItem(name: "q", value: selection ?? "а"))
        params.append(URLQueryItem(name: "type", value: "group"))
        
        requestUlr = prepareURLRequest(method: "groups.search", params: params)
        return requestUlr
    }
    
    //запрос сообществ текущего пользователя
    func getCommunityForCurrentUserList(selection: String?) -> URLRequest {
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        
        params.append(URLQueryItem(name: "user_id", value: String(self.userID)))
        params.append(URLQueryItem(name: "extended", value: "1"))
        
        
        requestUlr = prepareURLRequest(method: "groups.get", params: params)
        return requestUlr
    }
    
    //MARK: - requestCommunity
    func requestCommunity(request: URLRequest, complition: @escaping (Result<HeadResponseCommunity, Error>)-> Void) {
        let configaration = URLSessionConfiguration.default
        let session = URLSession(configuration: configaration)
    
        session.dataTask(with: request) { data, response, error in
                
            DispatchQueue.main.async {
                if let error = error {
                    print("Some Error")
                    //complition(nil, error)
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let usersList = try decoder.decode(HeadResponseCommunity.self, from: data)
//                    complition(usersList, nil)
                    complition(.success(usersList))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
//                    complition(nil, jsonError)
                    complition(.failure(jsonError))
                }
                
                
//                let someString = String(data: data, encoding: .utf8)
//                print(someString ?? "no data")
            }

        }.resume()
        
    }
    
    //Запрос фото пользователя
    //MARK: - getPhoto
    
    func getPhotos(userId: Int)  -> URLRequest {
        
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        params.append(URLQueryItem(name: "owner_id", value: String(userId)))
        params.append(URLQueryItem(name: "albub_id", value: "wall"))
        params.append(URLQueryItem(name: "extended", value: "1"))
        
        requestUlr = prepareURLRequest(method: "photos.get", params: params)
        return requestUlr
    }
    
    
    func requestUserPhotos(request: URLRequest, complition: @escaping (Result<HeadResponseUserPhotos, Error>)-> Void) {
        let configaration = URLSessionConfiguration.default
        let session = URLSession(configuration: configaration)
    
        session.dataTask(with: request) { data, response, error in
                
            DispatchQueue.main.async {
                if let error = error {
                    print("Some Error")
                    //complition(nil, error)
                    complition(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let usersList = try decoder.decode(HeadResponseUserPhotos.self, from: data)
//                    complition(usersList, nil)
                    complition(.success(usersList))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
//                    complition(nil, jsonError)
                    complition(.failure(jsonError))
                }
                
                
//                let someString = String(data: data, encoding: .utf8)
//                print(someString ?? "no data")
                
                
                
                
            }

        }.resume()
        
    }
    
    func requestUserPhotioForAlomofire(userId: Int) -> String {
        
//        let url = "https://api.vk.com/method/photos.get?access_token=\(token)&v=5.131&owner_id=\(String(userId))&albub_id=wall&extended=1"
        
        let url = "https://api.vk.com/method/photos.get?access_token=\(token)&owner_id=\(String(userId))&album_id=wall&rev=0&extended=1&photo_sizes=0&v=5.131"
        
//        AF.request(url, method: .get).responseData { response in
//            guard let data = response.value else { return }
//
//            //print(data.prettyJSON as Any)
//
//            self.headSearchResponse = try? JSONDecoder().decode(StructUserPhoto.self, from: data)

//            headSearchResponse?.response.items.forEach({ item in
//                item.sizes.forEach({ urlString in
//                    let photoItem = Photo(url: urlString.url)
//                    self.photoArray.append(photoItem)
//                })
//            })
            
//            headSearchResponse?.items.forEach({ photo in
//                photo.sizes.forEach { urlString in
//                photoArray.append(urlString)
//                }
//
//            })
            
//            print(self.photoArray.count)
        
         
        return url
        
    }
}
