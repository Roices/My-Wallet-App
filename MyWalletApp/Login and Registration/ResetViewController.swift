//
//  ResetPasswordView.swift
//  MyWallet
//
//  Created by Tuan on 27/06/2021.
//

import UIKit
import Firebase
import FirebaseAuth


class ResetView: UIViewController,UITextFieldDelegate {

    let EmailTField = UITextField()
    let ResetPassWord = UIButton()
    let NoticeLabel = UILabel()
    let DontHaveAcountLabel = UILabel()
    
    let SignUpButton = UIButton()
    let BackButton = UIButton()
    let LoginLabel =  UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        

        
        EmailTField.delegate = self
        customUI()
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
         return false
}
    
    @IBAction func ResetPassword(_ sender: Any) {
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: EmailTField.text!) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",style: .default))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.ResetPassWord.setTitle("Send again", for: .normal)
            let alert = UIAlertController(title: "Success", message: "A password reset email has been sent!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default))
        
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func Keyboard(_ sender: Any) {
        for view in view.subviews {
            if view.isFirstResponder {
                view.resignFirstResponder()
              }
       }
    }
    
    
    @IBAction func SignUp(){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "RegistrationView"))! as RegistrationViewcontroller
                 self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    
   @IBAction func backtoLogin(){
        let mapview = (self.storyboard?.instantiateViewController(identifier: "LoginViewController"))! as LoginViewController
        self.navigationController?.pushViewController(mapview, animated: true)
    }
    
}


extension ResetView{
    func customUI(){
        let ScreenWitdh = UIScreen.main.bounds.width
        let ScreenHeight = UIScreen.main.bounds.height
        
        EmailTField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.44*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        EmailTField.layer.borderWidth = 0.65
        EmailTField.layer.borderColor = UIColor.lightGray.cgColor
        EmailTField.layer.cornerRadius = EmailTField.frame.size.height/2
        EmailTField.clipsToBounds = true
        
        
        
        
        let color = UIColor(hexString: "3D87ED")
        ResetPassWord.frame = CGRect(x: ScreenWitdh*0.075, y: 0.54*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        ResetPassWord.layer.cornerRadius = ResetPassWord.frame.size.height/2
        ResetPassWord.backgroundColor = color
        ResetPassWord.setTitle("RESET PASSWORD", for: .normal)
        ResetPassWord.setTitleColor(.white, for: .normal)
//
        
        
        NoticeLabel.frame = CGRect(x: ScreenWitdh*0.075, y: 0.25*ScreenHeight, width:ScreenWitdh*0.85, height: 0.038*ScreenHeight)
        
        
        DontHaveAcountLabel.frame.origin.x = 0.347*ScreenWitdh
        DontHaveAcountLabel.frame.origin.y = 0.835*ScreenHeight
        
        SignUpButton.frame.origin.x = 0.385*ScreenWitdh
        SignUpButton.frame.origin.y = 0.85*ScreenHeight
        
        
        
        BackButton.frame = CGRect(x: 0.021*ScreenWitdh, y: 0.07*ScreenHeight, width: 0.2*ScreenWitdh, height: 0.079*ScreenHeight)
        
        
        LoginLabel.frame = CGRect(x: 0.19*ScreenWitdh, y: 0.09*ScreenHeight, width: 0.25*ScreenWitdh, height: 0.04*ScreenHeight)
        
    }
}
