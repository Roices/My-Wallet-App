//
//
//  RegistrationView.swift
//  MyWallet
//
//  Created by Tuan on 26/06/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewcontroller: UIViewController,UITextFieldDelegate, CAAnimationDelegate{
    
    //cmt
    
    let EmailField = UITextField()
    let UserNameField = UITextField()
    let PasswordTextField = UITextField()
    let ConfirmPasswordField = UITextField()
    let SignUp = UIButton()
    let BackButton = UIButton()
    let RegistrationLabel = UILabel()
    let LoginLabel = UILabel()
    
    let ScrollView = UIScrollView()
    var isSecureText = false
    var isSecureText2 = false
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(ScrollView)
        ScrollView.addSubview(EmailField)
        ScrollView.addSubview(UserNameField)
        ScrollView.addSubview(PasswordTextField)
        ScrollView.addSubview(ConfirmPasswordField)
        ScrollView.addSubview(SignUp)
        ScrollView.addSubview(BackButton)
        ScrollView.addSubview(RegistrationLabel)
        ScrollView.addSubview(LoginLabel)
        
        ref = Database.database().reference()
        EmailField.delegate = self
        UserNameField.delegate = self
        PasswordTextField.delegate = self
        ConfirmPasswordField.delegate = self
        
        CustomUI()
        self.hideKeyboardWhenTappedAround()
//        registerNotifications()

        
//        ConfirmPasswordField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
         registerNotifications()
        
        // Do any additional setup after loading the view.
    
    }
    

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @objc func SignUpAction(sender: UIButton) {
        guard let email = EmailField.text, !email.isEmpty, let password = PasswordTextField.text,!password.isEmpty else {
            //Missing data!!!!!
            
            // show accout creation
            let controller = UIAlertController.init(title: "", message: "Missing field data", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                }))
            self.present(controller, animated: true, completion: nil)
            return
            
            
        }
        
        if PasswordTextField.text != ConfirmPasswordField.text{
            let controller = UIAlertController.init(title: "", message: "Can't confirm password", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                }))
            self.present(controller, animated: true, completion: nil)
        }
    
//        FirebaseAuth.Auth.auth().fetchSignInMethods(forEmail: EmailField.text!, completion: { (signInMethods, error) in
//            let controller = UIAlertController.init(title: "", message: "Email was registered", preferredStyle: .alert)
//            controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
//                }))
//            self.present(controller, animated: true, completion: nil)
//
//        })
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self]result, error in
            guard self != nil else{
                print("error")
                return
            }
            guard error == nil else{
                let controller = UIAlertController.init(title: "", message: "Please enter the correct information", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                    }))
                return
            }
            print("success")
            let alert = UIAlertController(title: "Success", message: "You have successfully registered!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                let mapView = self?.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                let transition = CATransition.init()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
                transition.type = CATransitionType.push //Transition you want like Push, Reveal
                transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
                transition.delegate = self
                self!.view.window!.layer.add(transition, forKey: kCATransition)
                self?.navigationController?.pushViewController(mapView, animated: true)
            }))
            self!.present(alert, animated: true, completion: nil)
            
            print("Succsess")
            UserDefaults.standard.setValue(self!.UserNameField.text, forKey: "Username")
        })
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
         return false
}
    
    
    @objc func backtoLogin(sender: UIButton){
        let mapView = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
             guard let userInfo = notification.userInfo,
                   let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                     return
    }
        
     if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
         
         ScrollView.frame.origin.y = -frame.height + 100
         
     }else{
         ScrollView.frame.origin.y = 0
     }
         }
    

    
}

extension RegistrationViewcontroller{
    func CustomUI(){
        let ScreenWitdh = UIScreen.main.bounds.width
        let ScreenHeight = UIScreen.main.bounds.height
        
        ScrollView.frame = CGRect(x: 0, y: 0, width: ScreenWitdh, height: ScreenHeight)
        
        EmailField.frame = CGRect(x: 0.075*ScreenWitdh, y: 0.33*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        EmailField.layer.borderWidth = 0.65
        EmailField.layer.borderColor = UIColor.lightGray.cgColor
        EmailField.clipsToBounds = true
        EmailField.withImage(direction: .Left, image: UIImage(named: "Gmail")!)
        EmailField.placeholder = "Email"
        EmailField.layer.cornerRadius = 10
        EmailField.autocapitalizationType = .none
        
        
        UserNameField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.435*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        UserNameField.layer.borderWidth = 0.65
        UserNameField.layer.borderColor = UIColor.lightGray.cgColor
        UserNameField.clipsToBounds = true
        UserNameField.withImage(direction: .Left, image: UIImage(named: "User")!)
        UserNameField.placeholder = "Username"
        UserNameField.layer.cornerRadius = 10
        UserNameField.autocapitalizationType = .none
        
        
        PasswordTextField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.54*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        PasswordTextField.layer.borderWidth = 0.65
        PasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        PasswordTextField.clipsToBounds = true
        PasswordTextField.isSecureTextEntry = true
        PasswordTextField.withImage(direction: .Left, image: UIImage(named: "Password")!)
        PasswordTextField.placeholder = "Password"
        PasswordTextField.layer.cornerRadius = 10.0
        PasswordTextField.autocapitalizationType = .none
        
        
        
        ConfirmPasswordField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.645*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        ConfirmPasswordField.layer.borderWidth = 0.65
        ConfirmPasswordField.layer.borderColor = UIColor.lightGray.cgColor
        ConfirmPasswordField.clipsToBounds = true
        ConfirmPasswordField.isSecureTextEntry = true
        ConfirmPasswordField.withImage(direction: .Left, image: UIImage(named: "Password")!)
        ConfirmPasswordField.placeholder = "Confirm password"
        ConfirmPasswordField.layer.cornerRadius = 10.0
        ConfirmPasswordField.autocapitalizationType = .none
        
    
        SignUp.frame = CGRect(x: ScreenWitdh*0.075, y: 0.75*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        SignUp.layer.cornerRadius = 10.0
        SignUp.backgroundColor = UIColor(hexString: "090F52")
        SignUp.setTitleColor(.white, for: .normal)
        SignUp.setTitle("SIGN UP", for: .normal)
        SignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        SignUp.addTarget(self, action: #selector(SignUpAction), for: .touchUpInside)
        
        
        let button = UIButton(type: .custom)
        PasswordTextField.rightViewMode = .unlessEditing
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
//        button.frame = CGRect(x: PasswordTextField.frame.size.width - 15, y: 5, width: 15, height: 15)
        button.addTarget(self, action: #selector(SecureText(sender:)), for: .touchUpInside)
        PasswordTextField.rightView = button
        PasswordTextField.rightViewMode = .always
        
        
        let Button = UIButton(type: .custom)
        ConfirmPasswordField.rightViewMode = .unlessEditing
        Button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        Button.addTarget(self, action: #selector(SecureText2(sender:)), for: .touchUpInside)
        Button.setImage(UIImage(named: "eye")!, for: .normal)
        ConfirmPasswordField.rightView = Button
        ConfirmPasswordField.rightViewMode = .always
        //ConfirmPasswordField.withImage(direction: .Right, image: UIImage(named: "eye")!)
        
        BackButton.frame = CGRect(x: 0.021*ScreenWitdh, y: 0.07*ScreenHeight, width: 0.2*ScreenWitdh, height: 0.079*ScreenHeight)
        BackButton.setImage( UIImage(named:"BacktoLogin")!, for: .normal)
        BackButton.addTarget(self, action: #selector(backtoLogin), for: .touchUpInside)
        
        RegistrationLabel.frame = CGRect(x: ScreenWitdh*0.075, y: 0.23*ScreenHeight, width:ScreenWitdh*0.85, height: 0.05*ScreenHeight)
        RegistrationLabel.text = "REGISTRATION"
        RegistrationLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        RegistrationLabel.textAlignment = .center
        RegistrationLabel.textColor = .black
        
    
        LoginLabel.frame = CGRect(x: 0.19*ScreenWitdh, y: 0.09*ScreenHeight, width: 0.25*ScreenWitdh, height: 0.04*ScreenHeight)
        LoginLabel.text = "LOGIN"
        LoginLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        LoginLabel.textColor = .black
    }
    @objc func SecureText(sender: UIButton){
        isSecureText = !isSecureText
        if isSecureText == true{
            PasswordTextField.isSecureTextEntry = false
        }else{
            PasswordTextField.isSecureTextEntry = true
        }
        
    }
    @objc func SecureText2(sender: UIButton){
        isSecureText2 = !isSecureText2
        if isSecureText2 == true{
            ConfirmPasswordField.isSecureTextEntry = false
        }else{
            ConfirmPasswordField.isSecureTextEntry = true
        }
        
    }
}


