//
//  LoginView.swift
//  Financial_management
//
//  Created by Tuan on 21/06/2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet var Email:UITextField!
    @IBOutlet var PassWord:UITextField!
    @IBOutlet var ButtonLogin:UIButton!
    @IBOutlet var ViewImage:UIImageView!
    @IBOutlet var LabelText:UILabel!
    @IBOutlet weak var ButtonKeyboard: UIButton!
    @IBOutlet weak var DontHaveAccount: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var ForgotButton: UIButton!
    @IBOutlet weak var MadebyMeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.PassWord.delegate = self
        self.Email.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillHideNotification, object: nil)
        CustomUI()
        if FirebaseAuth.Auth.auth().currentUser != nil{
            //Change ->View
//            let mapview = (self.storyboard?.instantiateViewController(identifier: "FirstView"))! as FirstView
//            self.navigationController?.pushViewController(mapview, animated: true)
            
            
            //
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    @IBAction func Login(_ sender: Any) {
        guard let email = Email.text, !email.isEmpty,
              let password = PassWord.text,!password.isEmpty else{
            print("Missing field data")
            //Missing data!!!!!
            
            //code here
            
            //
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion:  {[weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                // show accout creation

                return
            }
            print("U have signed in")
            //Change -> View
            
//            let path = UserDefaults.standard.string(forKey: "Username")
//            let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!)
//
//            // tạo ref đến dữ liệu mới
//    //        let newRef = ref.child("Internet")
//
//            // tạo value cho dữ liệu mới
//            let val: [String : Any] = [
//              "Account": "",
//              "Sinh Hoạt": "",
//              "Dịch vụ": "",
//                "Con cái": "",
//                "Học tập": "",
//                "Du lịch": "",
//                "Đi lại": "",
//                "Shopping": "",
//                "Nhà cửa": "",
//                "Sức khỏe": "",
//                "Hiếu hỉ": "",
//                "Ngân hàng": ""
//
//            ]
//
//            // đẩy dữ liệu
//         //  newRef.setValue(val)
//         ref.setValue(val)
        })
        
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!)

        // tạo ref đến dữ liệu mới
//        let newRef = ref.child("Internet")

        // tạo value cho dữ liệu mới
        let val: [String : Any] = [
          "Account": "",
          "Sinh Hoạt": "",
          "Dịch vụ": "",
            "Con cái": "",
            "Học tập": "",
            "Du lịch": "",
            "Đi lại": "",
            "Shopping": "",
            "Nhà cửa": "",
            "Sức khỏe": "",
            "Hiếu hỉ": "",
            "Ngân hàng": ""
            
        ]

        // đẩy dữ liệu
     //  newRef.setValue(val)
     ref.setValue(val)
        
        let mapview = (self.storyboard?.instantiateViewController(identifier: "FirstView"))! as FirstView
        self.navigationController?.pushViewController(mapview, animated: true)
    }
    

    
    @IBAction func SignUp(){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "RegistrationView"))! as RegistrationViewcontroller
                 self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    @IBAction func ResetPassword(){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "ResetViewcontroller"))! as ResetView
            self.navigationController?.pushViewController(mapView, animated: true)
    }
    
   
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
         
         view.frame.origin.y = -frame.height + 150
         
     }else{
         view.frame.origin.y = 0
     }
         }
    
    
}

extension LoginViewController{
    func CustomUI(){
        
       
        let ScreenWitdh = UIScreen.main.bounds.width
        let ScreenHeight = UIScreen.main.bounds.height
       
  
      
        Email.frame = CGRect(x: ScreenWitdh/10, y: 0.4*ScreenHeight, width: (ScreenWitdh*4)/5, height: 0.08*ScreenHeight)
        Email.layer.borderWidth = 0.65
        Email.layer.borderColor = UIColor.lightGray.cgColor
        Email.layer.cornerRadius = Email.frame.size.height/2
        Email.clipsToBounds = true
        
        
    
        PassWord.frame = CGRect(x: ScreenWitdh/10, y: 0.5*ScreenHeight, width: (ScreenWitdh*4)/5, height: 0.08*ScreenHeight)
        PassWord.layer.borderWidth = 0.65
        PassWord.layer.borderColor = UIColor.lightGray.cgColor
        PassWord.layer.cornerRadius = PassWord.frame.size.height/2
        PassWord.clipsToBounds = true
        
        
        
        let color = UIColor(hexString: "3D87ED")
        ButtonLogin.frame = CGRect(x: ScreenWitdh/10, y: 0.65*ScreenHeight, width: (ScreenWitdh*4)/5, height: 0.08*ScreenHeight)
        ButtonLogin.layer.cornerRadius = ButtonLogin.frame.size.height/2
        ButtonLogin.backgroundColor = color
        

        DontHaveAccount.frame.origin.x = 0.347*ScreenWitdh
        DontHaveAccount.frame.origin.y = 0.825*ScreenHeight
        
        SignUpButton.frame.origin.x = 0.385*ScreenWitdh
        SignUpButton.frame.origin.y = 0.84*ScreenHeight
        
        ForgotButton.frame = CGRect(x: 0.5 * ScreenWitdh  , y: 0.58*ScreenHeight, width: 0.4*ScreenWitdh, height: 0.033*ScreenHeight)
        
       
        MadebyMeLabel.frame.origin.x = 0.432*ScreenWitdh
        MadebyMeLabel.frame.origin.y = 0.935*ScreenHeight
        
       
    }
    
  
    

}

