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

   // let ScrollView = UIScrollView()
    let Email = UITextField()
    let PassWord = UITextField()
    let ButtonLogin = UIButton()
    let ViewImage = UIImageView()
    let LabelText = UILabel()
   // let ButtonKeyboard = UIButton
    let DontHaveAccount = UILabel()
    let SignUpButton = UIButton()
    let ForgotButton = UIButton()
    let MadebyMeLabel = UILabel()
    var isSecureText = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.PassWord.delegate = self
        self.Email.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(Email)
        view.addSubview(PassWord)
        view.addSubview(ButtonLogin)
        view.addSubview(ViewImage)
        view.addSubview(LabelText)
        view.addSubview(DontHaveAccount)
        view.addSubview(SignUpButton)
        view.addSubview(ForgotButton)
        view.addSubview(MadebyMeLabel)
        
        CustomUI()
        if FirebaseAuth.Auth.auth().currentUser != nil{
            //Change ->View
            let mapview = (self.storyboard?.instantiateViewController(identifier: "MainsView"))! as UITabBarController
            let userID =  Auth.auth().currentUser!.uid
            UserDefaults.standard.setValue(userID, forKey: "Username")
            self.navigationController?.pushViewController(mapview, animated: true)
            //
        }
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func SecureText(sender: UIButton){
        isSecureText = !isSecureText
        if isSecureText == true{
            PassWord.isSecureTextEntry = false
        }else{
            PassWord.isSecureTextEntry = true
        }
        
    }
    
    @objc func Login(sender: UIButton) {
        let mapView = (self.storyboard?.instantiateViewController(identifier: "MainsView"))! as UITabBarController
        guard let email = Email.text, !email.isEmpty,
              let password = PassWord.text,!password.isEmpty else{
            print("Missing field data")
            //Missing data!!!!!
            
            let controller = UIAlertController.init(title: "", message: "Password or account invalid", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                }))
                self.present(controller, animated: true, completion: nil)
                
            
            //
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion:  {[weak self] result, error in
            guard self != nil else{
                return
            }
            guard error == nil else{
                // show accout creation
                let controller = UIAlertController.init(title: "", message: "Password or account invalid", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                    }))
                self!.present(controller, animated: true, completion: nil)
                return
            }
            print("U have signed in")
            //Change -> View

            let userID =  Auth.auth().currentUser!.uid
            UserDefaults.standard.setValue(userID, forKey: "Username")
            self?.navigationController?.pushViewController(mapView, animated: true)
        })
    }
    

    
    @objc func SignUp(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "RegistrationView"))! as RegistrationViewcontroller
                 self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    @objc func ResetPassword(sender: UIButton){
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
        Email.placeholder = "Email"
        Email.withImage(direction: .Left, image: UIImage(named: "Gmail")!)
        Email.layer.cornerRadius = 10.0
        Email.autocapitalizationType = .none
        
        PassWord.frame = CGRect(x: ScreenWitdh/10, y: 0.5*ScreenHeight, width: (ScreenWitdh*4)/5, height: 0.08*ScreenHeight)
        PassWord.layer.borderWidth = 0.65
        PassWord.layer.borderColor = UIColor.lightGray.cgColor
        PassWord.layer.cornerRadius = PassWord.frame.size.height/2
        PassWord.clipsToBounds = true
        PassWord.withImage(direction: .Left, image: UIImage(named: "Password")!)
        PassWord.placeholder = "Password"
        PassWord.layer.cornerRadius = 10.0
        PassWord.autocapitalizationType = .none
        let button = UIButton(type: .custom)
        PassWord.rightViewMode = .unlessEditing
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
//        button.frame = CGRect(x: PasswordTextField.frame.size.width - 15, y: 5, width: 15, height: 15)
        button.addTarget(self, action: #selector(SecureText(sender:)), for: .touchUpInside)
        PassWord.rightView = button
        PassWord.rightViewMode = .always
        PassWord.isSecureTextEntry = true
        
        
        ButtonLogin.frame = CGRect(x: ScreenWitdh/10, y: 0.65*ScreenHeight, width: (ScreenWitdh*4)/5, height: 0.08*ScreenHeight)
        ButtonLogin.layer.cornerRadius = ButtonLogin.frame.size.height/2
        ButtonLogin.backgroundColor = UIColor(hexString: "090F52")
        ButtonLogin.addTarget(self, action: #selector(Login), for: .touchUpInside)
        ButtonLogin.setTitle("SIGN IN", for: .normal)
        ButtonLogin.setTitleColor(.white, for: .normal)
        ButtonLogin.layer.cornerRadius = 10.0
        ButtonLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        ForgotButton.frame = CGRect(x: 0.5 * ScreenWitdh  , y: 0.58*ScreenHeight, width: 0.4*ScreenWitdh, height: 0.033*ScreenHeight)
        ForgotButton.setTitle("Forgot password", for: .normal)
        ForgotButton.setTitleColor(.lightGray, for: .normal)
        ForgotButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        ForgotButton.contentHorizontalAlignment = .right
        ForgotButton.addTarget(self, action: #selector(ResetPassword), for: .touchUpInside)
        
        
        DontHaveAccount.frame = CGRect(x: 0.3*ScreenWitdh, y: 0.825*ScreenHeight, width: 0.4*ScreenWitdh, height: 40)
        DontHaveAccount.text = "Don't have an account?"
        DontHaveAccount.font = UIFont.boldSystemFont(ofSize: 12.0)
        DontHaveAccount.textColor = .lightGray
        DontHaveAccount.textAlignment = .center
        
        SignUpButton.frame.origin.x = 0.385*ScreenWitdh
        SignUpButton.frame.origin.y = 0.84*ScreenHeight
        SignUpButton.frame = CGRect(x: 0.3*ScreenWitdh, y: 0.84*ScreenHeight, width: 0.4*ScreenWitdh, height: 50)
        SignUpButton.setTitle("SIGN UP", for: .normal)
        SignUpButton.setTitleColor(UIColor(hexString: "4369DE"), for: .normal)
        SignUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        SignUpButton.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
        
        
        MadebyMeLabel.frame = CGRect(x: 0.3*ScreenWitdh, y: 0.935*ScreenHeight, width: 0.4*ScreenWitdh, height: 50)
        MadebyMeLabel.text = "Made by me"
        MadebyMeLabel.textAlignment = .center
        MadebyMeLabel.textColor = .lightGray
        MadebyMeLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        
       
    }
    
  
    

}

