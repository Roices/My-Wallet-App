//
//  ViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 01/07/2021.
//

import UIKit
import FirebaseDatabase
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TField: UITextField!
    
    @IBOutlet weak var Edit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.TF2.delegate = self
        self.TField.delegate = self
        
        let path = "User"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        

    }
    
    //
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
         return false
    }

   @objc func keyboardWillShow(notification: Notification) {
            guard let userInfo = notification.userInfo,
                  let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                    return
            }
    if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
        
        ScrollView.frame.origin.y = -frame.height
        
    }else{
        ScrollView.frame.origin.y = 0
    }
        }
        
    
    @IBAction func Edittt(_ sender: Any) {
        let path = "Teen User"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        ref.child(path).childByAutoId().setValue(["Food": "20000k"])
    }
    
    @IBAction func Button(_ sender: Any) {
//        guard let subject = self.TF2.text,
//          let content = self.TField.text,
//          let email = Auth.auth().currentUser?.email else {
//          return
//        }
//
//        // tạo ref tới dữ liệu cha
//        let path = "User"
//        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path)
//
//        // tạo ref đến dữ liệu mới
//        let newRef = ref.childByAutoId()
//
//        // tạo value cho dữ liệu mới
//        let val: [String : Any] = [
//          "contentA": content,
//          "subjectA": subject,
//          "ownerA": email,
//          "timestampA": Date().timeIntervalSince1970,
//            "testA": "ayxz",
//            "TestA": "Testt"
//        ]
//
//        // đẩy dữ liệu
//        newRef.setValue(val)
        
        let path2 = "Teen User"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path2)
        ref.observe(.value, with: { (snapshot) in
          // cập nhật data
        
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
//              let key = postSnapshot.key
                if let Food = postSnapshot.childSnapshot(forPath: "Food").value as? String{
               print(Food)
              }
            }
          }
        })
    }
    
}

