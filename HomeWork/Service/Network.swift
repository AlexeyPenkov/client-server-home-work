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
    
    //var photoArray = [Photo]()
    
    var headSearchResponse: StructUserPhoto?
    
    //Подготовка запроса пользователей (друзей)
    //MARK: - getFriendsList
    func getFriendsRequest() ->URLRequest{
        
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        
        params.append(URLQueryItem(name: "user_id", value: String(self.userID)))
        params.append(URLQueryItem(name: "order", value: "name"))
        params.append(URLQueryItem(name: "fields", value: "photo"))
        
        requestUlr = prepareURLRequest(method: "friends.get", params: params)
        return requestUlr

    }
    
    func getFriends(complition: @escaping ([UserInfo]) -> ()) {
        
        var tempArr = [UserInfo]()
        let request =  getFriendsRequest()
       
        requestUsers(request: request) { result in
            switch result {
            case .success(let searchResponse):
                tempArr = searchResponse.response.items
                DispatchQueue.main.async {
                    complition(tempArr)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func prepareURLRequest(method: String, params: [URLQueryItem]) ->URLRequest {
        var urlComponents = URLComponents()
    
            
        urlComponents = initURLReques(urlComponents: urlComponents , method: method)
    
        
        for i in 0...params.count-1 {
            urlComponents.queryItems?.append(params[i])
        }
    
        
        var requestUrl = URLRequest(url: urlComponents.url!)
        requestUrl.httpMethod = "GET"
        
        return requestUrl
    }
    
    private func initURLReques(urlComponents: URLComponents, method: String) -> URLComponents {
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
   private func requestUsers(request: URLRequest, complition: @escaping (Result<HeadResponseUsers, Error>)-> Void) {
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
    func getCommunityRequest(selection: String?) -> URLRequest {
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        
        params.append(URLQueryItem(name: "q", value: selection ?? "а"))
        params.append(URLQueryItem(name: "type", value: "group"))
        
        requestUlr = prepareURLRequest(method: "groups.search", params: params)
        return requestUlr
    }
    
    func getOthersCommunity(selection: String?, complition: @escaping ([CommunityInfo])->()) {
        var tempArr = [CommunityInfo]()
        let request = getCommunityRequest(selection: selection)
        
        requestCommunity(request: request) { result in
            switch result {
            case .success(let searchResponse):
                
                tempArr = searchResponse.response.items
                DispatchQueue.main.async {
                    complition(tempArr)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //запрос сообществ текущего пользователя
    func getCommunityForCurrentUserRequest(selection: String?) -> URLRequest {
        var requestUlr: URLRequest
        var params = [URLQueryItem]()
        
        
        params.append(URLQueryItem(name: "user_id", value: String(self.userID)))
        params.append(URLQueryItem(name: "extended", value: "1"))
        
        
        requestUlr = prepareURLRequest(method: "groups.get", params: params)
        return requestUlr
    }
    
    func getCommunity(complition: @escaping ([CommunityInfo])->()) {
        var tempArr = [CommunityInfo]()
        let request = getCommunityForCurrentUserRequest(selection: nil)
        
        requestCommunity(request: request) { result in
            switch result {
            case .success(let searchResponse):
                
                tempArr = searchResponse.response.items
                DispatchQueue.main.async {
                    complition(tempArr)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - requestCommunity
    private func requestCommunity(request: URLRequest, complition: @escaping (Result<HeadResponseCommunity, Error>)-> Void) {
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
                    complition(.success(usersList))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    complition(.failure(jsonError))
                }
                
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
    
    
    func requestUserPhotos(request: URLRequest, complition: @escaping (Result<StructUserPhoto, Error>)-> Void) {
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
                    let usersList = try decoder.decode(StructUserPhoto.self, from: data)
                    complition(.success(usersList))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    complition(.failure(jsonError))
                }
        
            }

        }.resume()
        
    }
    
    func requestUserPhotoForAlomofire(userId: Int) -> String {
        
//        let url = "https://api.vk.com/method/photos.get?access_token=\(token)&v=5.131&owner_id=\(String(userId))&albub_id=wall&extended=1"
        
        let url = "https://api.vk.com/method/photos.getAll?access_token=\(token)&owner_id=\(String(userId))&album_id=wall&rev=0&extended=1&photo_sizes=0&v=5.131"
        
        return url
        
    }
    
    func getUserFoto(userId: Int, complition: @escaping ([String]) -> ()) {
        let urlRequest = requestUserPhotoForAlomofire(userId: userId)
        var photoArray = [String]()
        
        AF.request(urlRequest, method: .get).responseData { response in
            guard let data = response.value else { return }
            //print(data.prettyJSON)
            guard let searchRequest = try? JSONDecoder().decode(StructUserPhoto.self, from: data) else { return }
            
            for item in searchRequest.response.items {
                if let url = item.sizes.first?.url {
                    photoArray.append(url)
                }
                
            }
            
            DispatchQueue.main.async {
                complition(photoArray)
            }
        }
    }
    
    func getNewsPost(complition: @escaping ([ItemNews])->()) {
        
        let url = "https://api.vk.com/method/newsfeed.get?access_token=\(token)&filters=post&return_banned=0&v=5.131"
        AF.request(url, method: .get).responseData { response in
            guard let data = response.value else { return }
                do {
                    let searchRequest = try JSONDecoder().decode(NewsResponse.self, from: data)
                    complition(searchRequest.response.items)
                } catch {
                    print(error)
                }
            }
            
    }
    
    func getNewsProfile(complition: @escaping ([Profile])->()) {
        
        let url = "https://api.vk.com/method/newsfeed.get?access_token=\(token)&filters=post&return_banned=0&v=5.131"
        AF.request(url, method: .get).responseData { response in
            guard let data = response.value else { return }
              do {
                    let searchRequest = try JSONDecoder().decode(NewsResponse.self, from: data)
                    complition(searchRequest.response.profiles)
                } catch {
                    print(error)
                }
            }
    }
    
    func getNewsGroups(complition: @escaping ([Group])->()) {
        
        let url = "https://api.vk.com/method/newsfeed.get?access_token=\(token)&filters=post&return_banned=0&v=5.131"
        AF.request(url, method: .get).responseData { response in
            guard let data = response.value else { return }
              do {
                    let searchRequest = try JSONDecoder().decode(NewsResponse.self, from: data)
                complition(searchRequest.response.groups)
                } catch {
                    print(error)
                }
            }
    }
    
    
    func getNewsPhoto(complition: @escaping ([Int: [Size]])->()) {
        var photoDict = [Int: [Size]]()
        let url = "https://api.vk.com/method/newsfeed.get?access_token=post&filters=photo&return_banned=0&v=5.131"
        AF.request(url, method: .get).responseData { response in
            guard let data = response.value else { return }
            guard let searchRequest = try? JSONDecoder().decode(NewsResponse.self, from: data) else { return }
            for item in searchRequest.response.items {
                var photoArr = [Size]()
                let newsId = item.postID
                if let attachements = item.attachments {
                    for itemAttachements in attachements {
                        if let photo = itemAttachements.photo?.sizes.last {
                            photoArr.append(photo)
                        }
                        
                    }
                }
                photoDict.updateValue(photoArr, forKey: newsId ?? 0)
            }
            complition(photoDict)
        }
        
    }
    
    
}
