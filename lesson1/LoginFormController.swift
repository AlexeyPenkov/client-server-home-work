//
//  LoginFormController.swift
//  lesson1
//
//  Created by Алексей Пеньков on 04.04.2021.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageLoginView: UIImageView!
    @IBOutlet weak var inputLogin: UITextField!
    
    @IBOutlet weak var myScroll: UIScrollView!
    
    @IBOutlet weak var inputPassword: UITextField!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    
    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var button: UIButton!
    
    let loginToTabbarSegue = "loginToTabbarSegue"
    let listCommunityToFindCommunitySegue = "fromListCommunityToFindCommunity"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        myScroll?.addGestureRecognizer(hideKeyboardGesture)
        //imageLoginView.isHidden = true
        //self.imageLoginView.frame.origin.x = self.view.frame.maxX
        
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
            
        imageLoginView.transform = CGAffineTransform(translationX: view.frame.maxX, y: imageLoginView.frame.origin.y)
        
        labelTitle.transform = CGAffineTransform(translationX: labelTitle.bounds.origin.x, y: -view.bounds.height)
        //labelTitle.alpha = 0
        
        labelLogin.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        labelLogin.alpha = 0
        
        labelPassword.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        labelPassword.alpha = 0
        
        labelComment.transform = CGAffineTransform(rotationAngle: 600)
        labelComment.alpha = 0
        
        button.transform = CGAffineTransform(translationX: button.bounds.origin.x, y: view.bounds.height)
        
        let offset = view.bounds.width
        inputLogin.transform = CGAffineTransform(translationX: -offset, y: inputLogin.bounds.origin.y)
        inputPassword.transform = CGAffineTransform(translationX: offset, y: inputPassword.bounds.origin.y)
        
        UIView.animate(withDuration: 5,
                       delay: 0,
                       options: .autoreverse,
                       animations: {
                        self.pageControl.isHidden = false
                        self.pageControl.currentPage = 1
                       },
                       completion: {[weak self]_ in
                        self?.pageControl.isHidden = true
                       })
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       //usingSpringWithDamping: 0.5,
                       //initialSpringVelocity: 0,
                       options: [.curveEaseOut],
                       animations: {self.inputLogin.transform = .identity
                        self.inputPassword.transform = .identity
                       },
                       completion: {[weak self]_ in
                        UIView.animate(withDuration: 0.5,
                                       delay: 0,
                                       usingSpringWithDamping: 0.5,
                                       initialSpringVelocity: 0,
                                       options: .curveEaseOut,
                                       animations: {
                                        self?.labelTitle.alpha = 1
                                        self?.labelTitle.transform = .identity
                                       },
                                       completion: {[weak self]_ in
                            UIView.animate(withDuration: 0.5,
                                           delay: 0,
                                           usingSpringWithDamping: 0.5,
                                           initialSpringVelocity: 0,
                                           
                                           animations: {
                                            self?.labelLogin.alpha = 1
                                            self?.labelLogin.transform = .identity
                                           },
                                           completion:{[weak self]_ in
                                            UIView.animate(withDuration: 0.5,
                                                           delay: 0,
                                                           usingSpringWithDamping: 0.5,
                                                           initialSpringVelocity: 0,
                                                                      
                                                           animations: {
                                                            self?.labelPassword.alpha = 1
                                                            self?.labelPassword.transform = .identity
                                                           },
                                                           completion: {[weak self]_ in
                                                            UIView.animate(withDuration: 0.5,
                                                                           delay: 0,
                                                                           usingSpringWithDamping: 0.5,
                                                                           initialSpringVelocity: 0,
                                                                           //options: .repeat,
                                                                           animations: {
                                                                            self?.labelComment.alpha = 1
                                                                            self?.labelComment.transform = .identity
                                                                           },
                                                                           completion:  {[weak self]_ in
                                                                            UIView.animate(withDuration: 0.5,
                                                                                           delay: 0,
                                                                                           usingSpringWithDamping: 0.3,
                                                                                           initialSpringVelocity: 0,
                                                                                                      
                                                                                           animations: {
                                                                                            self?.button.transform = .identity
                                                                                           },
                                                                                           completion: nil)})})})
                           })
                       })
    }


    @objc func hideKeyboard() {
            self.myScroll?.endEditing(true)
    }

    
    
    
    @objc func keyboardWasShown(notification: Notification)  {
        
        let info = notification.userInfo! as NSDictionary
        
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        
        self.myScroll?.contentInset = contentInsets
                
        myScroll?.scrollIndicatorInsets = contentInsets

        
    }
    
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        myScroll?.contentInset = contentInsets
      
    }
    
   

        // Do any additional setup after loading the view.

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func firstInitial() {
        
        //var userFoto = UserFoto(photo: UIImage(named: "foto1_1")!, countOfLike: 0, countOfDislike: 0)
        var imArray = getArrayPhotoUser(array: [UIImage(named: "foto1_1")!, UIImage(named: "foto1_2")!])
        
        //imArray.append(userFoto)
        
        //userFoto.photo = UIImage(named: "foto1_2")!
        //imArray.append(userFoto)
        
        let user1 = User(name: "Митрич", age: "45", avatar: UIImage(named: "mitrichAvatar"), photoArray: imArray)
        
        imArray = getArrayPhotoUser(array: [UIImage(named: "foto2_1")!, UIImage(named: "foto2_2")!])
        
//        userFoto.photo = UIImage(named: "foto2_1")!
//        imArray.append(userFoto)
//
//        userFoto.photo = UIImage(named: "foto2_2")!
//        imArray.append(userFoto)
        
        let user2 = User(name: "Валера", age: "28", avatar: UIImage(named: "avatar2"), photoArray: imArray)
        
        imArray = getArrayPhotoUser(array: [UIImage(named: "foto3_1")!])
        
//        imArray.removeAll()
//
//        userFoto.photo = UIImage(named: "foto3_1")!
//        imArray.append(userFoto)
        
        
        let user3 = User(name: "Эдик", age: "32", avatar: UIImage(named: "avatar3"), photoArray: imArray)
        
        imArray = getArrayPhotoUser(array: [UIImage(named: "valdemar")!])
        let user4 = User(name: "Вальдемар", age: "21", avatar: UIImage(named: "valdemar"), photoArray: imArray)
        
        imArray = getArrayPhotoUser(array: [UIImage(named: "drugsman1")!])
        let user5 = User(name: "Павлик", age: "50", avatar: UIImage(named: "drugsman1"), photoArray: imArray)
        
        imArray = getArrayPhotoUser(array: [UIImage(named: "drugsman2")!])
        let user6 = User(name: "Петрович", age: "32", avatar: UIImage(named: "drugsman2"), photoArray: imArray)
        
        imArray = getArrayPhotoUser(array: [UIImage(named: "drugsman3")!])
        let user7 = User(name: "Жорик", age: "29", avatar: UIImage(named: "drugsman3"), photoArray: imArray)
        
        DataStorage.share.usersArray.append(user1)
        DataStorage.share.usersArray.append(user2)
        DataStorage.share.usersArray.append(user3)
        DataStorage.share.usersArray.append(user4)
        DataStorage.share.usersArray.append(user5)
        DataStorage.share.usersArray.append(user6)
        DataStorage.share.usersArray.append(user7)
        
        
        let group1 = Group(name: "Все. Завтра не пью!", avatar: UIImage(named: "groupsAvatar1"))
        let group2 = Group(name: "Ботаники", avatar: UIImage(named: "groupsAvatar2"))
        
        DataStorage.share.otherGroupsArray.append(group1)
        DataStorage.share.otherGroupsArray.append(group2)
        
        let otherGroup1 = Group(name: "Какое-то сообщество", avatar: UIImage(named: "someCommunity"))
        let otherGroup2 = Group(name: "Петросяния и только", avatar: UIImage(named: "petrosyania"))
        
        DataStorage.share.otherGroupsArray.append(otherGroup1)
        DataStorage.share.otherGroupsArray.append(otherGroup2)
    }
    
    @IBAction func pressLoginButton(sender: UIButton) {
        guard let login = self.inputLogin.text,
              login == "Admin"
        else {
            showAlert(alertText: "Wrong username!")
            return
        }
//        guard let password = self.inputPassword.text,
//              password == "qwerty"
//        else {
//            showAlert(alertText: "Wrong password!")
//            return
//        }
        //imageLoginView.isHidden = false
        let userID = 1
        fillSingleton(token: login, userID: userID)
        UIImageView.animate(withDuration: 0.1,
                            delay: 0.0,
                            options: [
                                .curveEaseOut],
                            animations: {
                                self.imageLoginView.frame.origin.x = self.view.frame.midX
                            },
                            completion: {[weak self] _ in
                                guard let self = self else {return}
                                UIImageView.animate(withDuration: 0.1,
                                                    delay: 0.4,
                                                    animations: {
                                                        self.imageLoginView.frame.origin.x = self.view.frame.maxX
                                                    },
                                                    completion: {[weak self] _ in
                                guard let self = self else {return}
                                self.performSegue(withIdentifier: self.loginToTabbarSegue, sender: self)
                                                    })
                            })
        
        firstInitial()
       
        //performSegue(withIdentifier: self.loginToTabbarSegue, sender: self)
    }
    
    func showAlert(alertText: String) {
        let alertController = UIAlertController(title: "Ахтунг!", message: alertText, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    /*
    @IBAction func pressFindCommunity(_ sender: Any) {
        performSegue(withIdentifier: self.listCommunityToFindCommunitySegue, sender: self)
    }
    */
    
    func getArrayPhotoUser(array: [UIImage]) -> [UserFoto] {
        var imArray = [UserFoto] ()
        for item in array {
            var user = UserFoto(photo: item, countOfLike: Int.random(in: 0...10), countOfDislike: Int.random(in: 0...10))
            imArray.append(user)
        }
        
        return imArray
    }
    
    func animePageContol() {
       //UIView
    }
    
    
    func fillSingleton(token: String, userID: Int) {
        Session.shared.token = token
        Session.shared.userID = userID
        
        print("Получен новый токен  \(Session.shared.token) и ID \(Session.shared.userID)")
    }
}
