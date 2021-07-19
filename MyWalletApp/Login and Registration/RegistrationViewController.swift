//
//
//  RegistrationView.swift
//  MyWallet
//
//  Created by Tuan on 26/06/2021.
//

import UIKit

import Firebase

class RegistrationViewcontroller: UIViewController,UITextFieldDelegate {
    
    //cmt
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    @IBOutlet weak var SignUp: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var RegistrationLabel: UILabel!
    @IBOutlet weak var LoginLabel: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    var isSecureText = false
    var isSecureText2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()


        EmailField.delegate = self
        UserNameField.delegate = self
        PasswordTextField.delegate = self
        ConfirmPasswordField.delegate = self
        
        CustomUI()
//        registerNotifications()

        
        ConfirmPasswordField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        registerNotifications()
        
        // Do any additional setup after loading the view.
    
    }
    

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @IBAction func SignUpAction(_ sender: Any) {
        guard let email = EmailField.text, !email.isEmpty, let password = PasswordTextField.text,!password.isEmpty else {
            //Missing data!!!!!
            
            //codehere
            
            //
            return
        }
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self]result, error in
            guard self != nil else{
                print("error")
                return
            }
            guard error == nil else{
                
                return
            }
            
            let alert = UIAlertController(title: "Success", message: "You have successfully registered!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default))
            self?.present(alert, animated: true, completion: nil)
            print("U have signed up")
            
        })
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
         return false
}
    
    
    
   @IBAction func backtoLogin(){
        let mapview = (self.storyboard?.instantiateViewController(identifier: "LoginViewController"))! as LoginViewController
        self.navigationController?.pushViewController(mapview, animated: true)
    }
    
    
    
    @objc func myTargetFunction(textField: UITextField) {
        registerNotifications()
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
        
        EmailField.frame = CGRect(x: 0.075*ScreenWitdh, y: 0.33*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        EmailField.layer.borderWidth = 0.65
        EmailField.layer.borderColor = UIColor.lightGray.cgColor
        EmailField.layer.cornerRadius = EmailField.frame.size.height/2
        EmailField.clipsToBounds = true
        
        
        UserNameField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.435*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        UserNameField.layer.borderWidth = 0.65
        UserNameField.layer.borderColor = UIColor.lightGray.cgColor
        UserNameField.layer.cornerRadius = EmailField.frame.size.height/2
        UserNameField.clipsToBounds = true
        
        
        
        PasswordTextField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.54*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        PasswordTextField.layer.borderWidth = 0.65
        PasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        PasswordTextField.layer.cornerRadius = PasswordTextField.frame.size.height/2
        PasswordTextField.clipsToBounds = true
        PasswordTextField.isSecureTextEntry = true
        
        
        
        ConfirmPasswordField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.645*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        ConfirmPasswordField.layer.borderWidth = 0.65
        ConfirmPasswordField.layer.borderColor = UIColor.lightGray.cgColor
        ConfirmPasswordField.layer.cornerRadius = ConfirmPasswordField.frame.size.height/2
        ConfirmPasswordField.clipsToBounds = true
        ConfirmPasswordField.isSecureTextEntry = true
        
        
        let color = UIColor(hexString: "3D87ED")
        SignUp.frame = CGRect(x: ScreenWitdh*0.075, y: 0.75*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        SignUp.layer.cornerRadius = SignUp.frame.size.height/2
        SignUp.backgroundColor = color
        SignUp.setTitleColor(.white, for: .normal)
        
        
        
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
        Button.setImage(UIImage(named: "eye"), for: .normal)
        Button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        Button.addTarget(self, action: #selector(SecureText2(sender:)), for: .touchUpInside)
        ConfirmPasswordField.rightView = Button
        ConfirmPasswordField.rightViewMode = .always
        
        
        
        BackButton.frame = CGRect(x: 0.021*ScreenWitdh, y: 0.07*ScreenHeight, width: 0.2*ScreenWitdh, height: 0.079*ScreenHeight)
        
        
        
        RegistrationLabel.frame = CGRect(x: ScreenWitdh*0.075, y: 0.23*ScreenHeight, width:ScreenWitdh*0.85, height: 0.05*ScreenHeight)
        
        
        
        LoginLabel.frame = CGRect(x: 0.19*ScreenWitdh, y: 0.09*ScreenHeight, width: 0.25*ScreenWitdh, height: 0.04*ScreenHeight)
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
        if isSecureText == true{
            ConfirmPasswordField.isSecureTextEntry = false
        }else{
            ConfirmPasswordField.isSecureTextEntry = true
        }
        
    }
}


