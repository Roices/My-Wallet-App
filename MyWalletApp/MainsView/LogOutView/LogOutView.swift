//
//  LogOutView.swift
//  MyWalletApp
//
//  Created by Tuan on 30/11/2021.
//

import UIKit
import Firebase

class LogOutView: UIViewController {

    let AboutArray = ["Currency","Privacy Policy","Terms of use"]
    let AppArray = ["Support","Report a Bug","App Version 1.0"]
    let CurrencyArray = ["VND", "", ""]
    let BackGroundImage:UIImageView = {
        let BackGround = UIImageView(image: UIImage(named: "Background"))
        BackGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return BackGround
    }()
    
    let MainView : UIView = {
        let MainView = UIView()
        MainView.backgroundColor  = .white
        MainView.layer.cornerRadius = 10.0
        MainView.frame = CGRect(x: 0, y: 0.111*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.889)
        return MainView
    }()
    
    let WalletImage : UIImageView = {
       let WalletImage = UIImageView(image: UIImage(named: "Wallet"))
        WalletImage.frame = CGRect(x: 30, y: 0.134*UIScreen.main.bounds.height, width: 0.04*UIScreen.main.bounds.height, height: 0.04*UIScreen.main.bounds.height)
      //  WalletImage.backgroundColor = .red
        return WalletImage
    }()
    
    let Title : UILabel = {
        let title = UILabel()
        title.text = "More"
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    lazy var AlertMainLabel : UILabel = {
        let AlertLabel = UILabel()
        AlertLabel.frame = CGRect(x: 90, y: 0.14*UIScreen.main.bounds.height, width: 200, height: 30)
        AlertLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        AlertLabel.text = UserDefaults.standard.string(forKey: "Username")
       // UserAccountLabel.textAlignment = .center
        return AlertLabel
    }()
    
    let AboutLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 0.212*UIScreen.main.bounds.height, width: 150, height: 0.04*UIScreen.main.bounds.height)
        label.text = "About"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var AboutView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 30, y: 0.256*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.2*UIScreen.main.bounds.height)
      //  view.backgroundColor = .red
        
        let label = UILabel(frame: CGRect(x: 0, y: 0.0167*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label.text = "Currency"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let VNDLabel = UILabel(frame: CGRect(x: view.frame.width - 80, y: 0.0167*UIScreen.main.bounds.height, width: 50, height: 0.04*UIScreen.main.bounds.height))
        VNDLabel.text = "VND"
        VNDLabel.textAlignment = .right
        VNDLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let IconRightImage = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 0.028*UIScreen.main.bounds.height, width: 0.022*UIScreen.main.bounds.height, height: 0.022*UIScreen.main.bounds.height))
        IconRightImage.image = UIImage(named: "icons8-forward-60")
        let line1 = UIView(frame: CGRect(x: 0, y: 0.065*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line1.backgroundColor = .lightGray
        line1.alpha = 0.5
        
        //2
        let label2 = UILabel(frame: CGRect(x: 0, y: 0.083*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label2.text = "Privacy Policy"
        label2.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage2 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 0.083*UIScreen.main.bounds.height, width: 0.022*UIScreen.main.bounds.height, height: 0.022*UIScreen.main.bounds.height))
        IconRightImage2.image = UIImage(named: "icons8-forward-60")
        
        let line2 = UIView(frame: CGRect(x: 0, y: 0.132*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line2.backgroundColor = .lightGray
        line2.alpha = 0.5
        
        //3
        let label3 = UILabel(frame: CGRect(x: 0, y: 0.15*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label3.text = "Terms of use"
        label3.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage3 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 0.161*UIScreen.main.bounds.height, width: 0.022*UIScreen.main.bounds.height, height: 0.022*UIScreen.main.bounds.height))
        IconRightImage3.image = UIImage(named: "icons8-forward-60")
        
        let line3 = UIView(frame: CGRect(x: 0, y: 0.199*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line3.backgroundColor = .lightGray
        line3.alpha = 0.5
        
        view.addSubview(label)
        view.addSubview(VNDLabel)
        view.addSubview(IconRightImage)
        view.addSubview(line1)
        view.addSubview(label2)
        view.addSubview(IconRightImage2)
        view.addSubview(line2)
        view.addSubview(label3)
        view.addSubview(IconRightImage3)
        view.addSubview(line3)
        
        return view
    }()
    
    let AppLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 0.48*UIScreen.main.bounds.height, width: 150, height: 0.04*UIScreen.main.bounds.height)
        label.text = "App"
        label.textColor = .lightGray
        //label.backgroundColor = .red
        return label
    }()
    
    lazy var AppView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 30, y: 0.52*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.267*UIScreen.main.bounds.height)
      //  view.backgroundColor = .red
        
        let label = UILabel(frame:  CGRect(x: 0, y: 0.0167*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label.text = "Touch ID"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let Switch = UISwitch(frame: CGRect(x: view.frame.width - 50, y: 0.0156*UIScreen.main.bounds.height, width: 20, height: 0.05*UIScreen.main.bounds.height))
        
        let line1 = UIView(frame: CGRect(x: 0, y: 0.065*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line1.backgroundColor = .lightGray
        line1.alpha = 0.5
        
        //2
        let label2 = UILabel(frame: CGRect(x: 0, y: 0.083*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label2.text = "Support"
        label2.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage2 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 0.083*UIScreen.main.bounds.height, width: 0.022*UIScreen.main.bounds.height, height: 0.022*UIScreen.main.bounds.height))
        IconRightImage2.image = UIImage(named: "icons8-forward-60")
        
        let line2 = UIView(frame:  CGRect(x: 0, y: 0.132*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line2.backgroundColor = .lightGray
        line2.alpha = 0.5
        
        //3
        let label3 = UILabel(frame: CGRect(x: 0, y: 0.15*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label3.text = "Report a Bug"
        label3.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage3 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 0.161*UIScreen.main.bounds.height, width: 0.022*UIScreen.main.bounds.height, height: 0.022*UIScreen.main.bounds.height))
        IconRightImage3.image = UIImage(named: "icons8-forward-60")
        
        let line3 = UIView(frame: CGRect(x: 0, y: 0.199*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line3.backgroundColor = .lightGray
        line3.alpha = 0.5
        
        //4
        let label4 = UILabel(frame: CGRect(x: 0, y: 0.218*UIScreen.main.bounds.height, width: 150, height: 0.033*UIScreen.main.bounds.height))
        label4.text = "App Version 1.0"
        label4.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage4 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 0.224*UIScreen.main.bounds.height, width:  0.022*UIScreen.main.bounds.height, height:  0.022*UIScreen.main.bounds.height))
        IconRightImage4.image = UIImage(named: "icons8-forward-60")
        
        let line4 = UIView(frame: CGRect(x: 0, y: 0.266*UIScreen.main.bounds.height, width: view.frame.width, height: 1))
        line4.backgroundColor = .lightGray
        line4.alpha = 0.5
        
        view.addSubview(label)
        view.addSubview(Switch)
        view.addSubview(line1)
        view.addSubview(label2)
        view.addSubview(IconRightImage2)
        view.addSubview(line2)
        view.addSubview(label3)
        view.addSubview(IconRightImage3)
        view.addSubview(line3)
        view.addSubview(label4)
        view.addSubview(IconRightImage4)
        view.addSubview(line4)
        return view
    }()
    
    let LogOutIcon : UIImageView = {
        let Icon = UIImageView(frame: CGRect(x: 30, y: 0.814*UIScreen.main.bounds.height, width: 0.022*UIScreen.main.bounds.height, height: 0.022*UIScreen.main.bounds.height))
        Icon.image = UIImage(named: "Logout")
        return Icon
    }()
    
    let LogoutButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 45, y: 0.814*UIScreen.main.bounds.height, width: 100, height: 0.022*UIScreen.main.bounds.height))
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(LogOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1334:
                    print("iPhone 6/6S/7/8")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 15, width: 150, height: 50)

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 15, width: 150, height: 50)
                default:
                    print("Unknown")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 40, width: 150, height: 45)
                }
            }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(BackGroundImage)
        view.addSubview(MainView)
        view.addSubview(Title)
        view.addSubview(WalletImage)
        view.addSubview(AlertMainLabel)
        view.addSubview(AboutLabel)
        view.addSubview(AboutView)
        view.addSubview(AppLabel)
        view.addSubview(AppView)
        view.addSubview(LogOutIcon)
        view.addSubview(LogoutButton)
    }
    
    @objc func LogOut(sender: UIButton){
            // call from any screen
        let mapView = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        let controller = UIAlertController.init(title: "", message: "Do you want to logout?", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",style: .default,handler: { (_) in
                do { try Auth.auth().signOut() }
                catch { print("already logged out") }
                self.navigationController?.pushViewController(mapView, animated: true)
          }))
        let Cancel = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Cancel",style: .cancel,handler: { (_) in
            print("OKOKOK")
        }))
        self.present(controller, animated: true, completion: nil)
        self.present(Cancel, animated: true, completion: nil)
        //self.navigationController?.pushViewController(mapView, animated: true)
        
    }
}

