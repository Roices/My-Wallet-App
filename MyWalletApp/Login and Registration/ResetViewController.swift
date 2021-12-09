//
//  ResetPasswordView.swift
//  MyWallet
//
//  Created by Tuan on 27/06/2021.
//

import UIKit
import Firebase
import FirebaseAuth


class ResetView: UIViewController,UITextFieldDelegate, CAAnimationDelegate {

    let EmailTField = UITextField()
    let ResetPassWord = UIButton()
    let NoticeLabel = UILabel()
    let DontHaveAcountLabel = UILabel()
    
    let SignUpButton = UIButton()
    let BackButton = UIButton()
    let LoginLabel =  UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(BackButton)
        view.addSubview(EmailTField)
        view.addSubview(ResetPassWord)
        view.addSubview(NoticeLabel)
        view.addSubview(DontHaveAcountLabel)
        view.addSubview(SignUpButton)
        view.addSubview(LoginLabel)

        
        EmailTField.delegate = self
        customUI()
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
         return false
}
    
    @objc func ResetPassword(sender: UIButton) {
        
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
    
    
    @objc func Keyboard(sender: UIButton) {
        for view in view.subviews {
            if view.isFirstResponder {
                view.resignFirstResponder()
              }
       }
    }
    
    
    @objc func SignUp(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "RegistrationView"))! as RegistrationViewcontroller
                 self.navigationController?.pushViewController(mapView, animated: true)
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
    
}


extension ResetView{
    func customUI(){
        let ScreenWitdh = UIScreen.main.bounds.width
        let ScreenHeight = UIScreen.main.bounds.height
        
        EmailTField.frame = CGRect(x: ScreenWitdh*0.075, y: 0.44*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        EmailTField.layer.borderWidth = 0.65
        EmailTField.layer.borderColor = UIColor.lightGray.cgColor
        EmailTField.layer.cornerRadius = 10
        EmailTField.clipsToBounds = true
        EmailTField.autocapitalizationType = .none
        EmailTField.withImage(direction: .Left, image: UIImage(named:"Gmail")!)
        EmailTField.placeholder = "Email"
        

        ResetPassWord.frame = CGRect(x: ScreenWitdh*0.075, y: 0.54*ScreenHeight, width: ScreenWitdh*0.85, height: 0.08*ScreenHeight)
        ResetPassWord.layer.cornerRadius = 10
        ResetPassWord.backgroundColor = UIColor(hexString: "090F52")
        ResetPassWord.setTitle("RESET PASSWORD", for: .normal)
        ResetPassWord.setTitleColor(.white, for: .normal)
        ResetPassWord.addTarget(self, action: #selector(ResetPassword), for: .touchUpInside)
        ResetPassWord.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//
        
        NoticeLabel.frame = CGRect(x: ScreenWitdh*0.075, y: 0.25*ScreenHeight, width:ScreenWitdh*0.85, height: 0.038*ScreenHeight)
        NoticeLabel.text = "RESET PASSWORD"
        NoticeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        NoticeLabel.textAlignment = .center
        NoticeLabel.textColor = .black
        
        

        DontHaveAcountLabel.frame = CGRect(x: 0.3*ScreenWitdh, y: 0.835*ScreenHeight, width: 0.4*ScreenWitdh, height: 50)
        DontHaveAcountLabel.text = "Don't Have an Account"
        DontHaveAcountLabel.textAlignment = .center
        DontHaveAcountLabel.font = UIFont.boldSystemFont(ofSize: 12)
        DontHaveAcountLabel.textColor = UIColor.lightGray
        

        SignUpButton.frame = CGRect(x: 0.3*ScreenWitdh, y: 0.86*ScreenHeight, width: 0.4*ScreenWitdh, height: 50)
        SignUpButton.setTitle("SIGN UP", for: .normal)
        SignUpButton.setTitleColor(UIColor(hexString: "090F52"), for: .normal)
        SignUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        SignUpButton.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
        
        
        
        
        BackButton.frame = CGRect(x: 0.021*ScreenWitdh, y: 0.05*ScreenHeight, width: 0.2*ScreenWitdh, height: 0.079*ScreenHeight)
        BackButton.setImage(UIImage(named: "BacktoLogin"), for: .normal)
        BackButton.addTarget(self, action: #selector(backtoLogin), for: .touchUpInside)
        
        
        LoginLabel.frame = CGRect(x: 0.19*ScreenWitdh, y: 0.07*ScreenHeight, width: 0.25*ScreenWitdh, height: 0.04*ScreenHeight)
        LoginLabel.font = UIFont.boldSystemFont(ofSize: 20)
        LoginLabel.text = "Login"
        
    }
}
