//
//  AuthViewController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 26.05.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    let toTabBarControlSegue = "fromAuthToTabBarController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7863996"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_url", value: "https//oauth.vk.com/blank.html"),
            //URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        var isToken = false
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                                            decisionHandler(.allow)
                                            return}
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String] ()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"] else {
            print("не нашел токен ((")
            return
        }
        
//        params.forEach({
//            print($0)
//        })
        guard let strUserId = params["user_id"],
              let userId = Int(strUserId) else {
            print("не нашел юзер айди ((")
            return
        }
        
        Session.shared.token = token
        isToken = true
        Session.shared.userID = userId
        
        print("UserID: \(Session.shared.userID)")
        print("TOKEN: \(Session.shared.token)")
        decisionHandler(.cancel)
        
        if isToken {
            //firstInitial()
            self.performSegue(withIdentifier: toTabBarControlSegue, sender: self)
        }
    }
}
