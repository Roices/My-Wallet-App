//
//  LoginView.swift
//  Financial_management
//
//  Created by Tuan on 21/06/2021.
//

import UIKit

import Firebase

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
            let mapview = (self.storyboard?.instantiateViewController(identifier: "FirstView"))! as FirstView
            self.navigationController?.pushViewController(mapview, animated: true)
            
            
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
                strongSelf.showCreateAccount()
                return
            }
            print("U have signed in")
            //Change -> View
        })
    }
    
    func showCreateAccount(){
        
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

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UITextField {

enum Direction {
    case Left
    case Right
}
    

// add image to textfield
    func withImage(direction: Direction, image: UIImage){
    
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: 45))
    let imageView = UIImageView(image: image)

    if(Direction.Left == direction){ // image left
        self.leftViewMode = .always
        self.leftView = view
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 20.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
    } else { // image right
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = view
    }

}
    
   

}
