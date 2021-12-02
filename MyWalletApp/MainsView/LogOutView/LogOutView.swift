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
        MainView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100 )
        return MainView
    }()
    
    let WalletImage : UIImageView = {
       let WalletImage = UIImageView(image: UIImage(named: "Wallet"))
        WalletImage.frame = CGRect(x: 30, y: 120, width: 40, height: 40)
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
        AlertLabel.frame = CGRect(x: 90, y: 125, width: 200, height: 30)
        AlertLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        AlertLabel.text = UserDefaults.standard.string(forKey: "Username")
       // UserAccountLabel.textAlignment = .center
        return AlertLabel
    }()
    
    let AboutLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 190, width: 150, height: 40)
        label.text = "About"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var AboutView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 30, y: 230, width: UIScreen.main.bounds.width - 60, height: 180)
      //  view.backgroundColor = .red
        
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: 150, height: 30))
        label.text = "Currency"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let VNDLabel = UILabel(frame: CGRect(x: view.frame.width - 80, y: 15, width: 50, height: 40))
        VNDLabel.text = "VND"
        VNDLabel.textAlignment = .right
        VNDLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let IconRightImage = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 25, width: 20, height: 20))
        IconRightImage.image = UIImage(named: "icons8-forward-60")
        let line1 = UIView(frame: CGRect(x: 0, y: 59, width: view.frame.width, height: 1))
        line1.backgroundColor = .lightGray
        line1.alpha = 0.5
        
        //2
        let label2 = UILabel(frame: CGRect(x: 0, y: 75, width: 150, height: 30))
        label2.text = "Privacy Policy"
        label2.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage2 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 75, width: 20, height: 20))
        IconRightImage2.image = UIImage(named: "icons8-forward-60")
        
        let line2 = UIView(frame: CGRect(x: 0, y: 119, width: view.frame.width, height: 1))
        line2.backgroundColor = .lightGray
        line2.alpha = 0.5
        
        //3
        let label3 = UILabel(frame: CGRect(x: 0, y: 135, width: 150, height: 30))
        label3.text = "Terms of use"
        label3.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage3 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 145, width: 20, height: 20))
        IconRightImage3.image = UIImage(named: "icons8-forward-60")
        
        let line3 = UIView(frame: CGRect(x: 0, y: 179, width: view.frame.width, height: 1))
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
        label.frame = CGRect(x: 30, y: 430, width: 150, height: 40)
        label.text = "App"
        label.textColor = .lightGray
        //label.backgroundColor = .red
        return label
    }()
    
    lazy var AppView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 30, y: 470, width: UIScreen.main.bounds.width - 60, height: 240)
      //  view.backgroundColor = .red
        
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: 150, height: 30))
        label.text = "Touch ID"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let Switch = UISwitch(frame: CGRect(x: view.frame.width - 50, y: 15, width: 20, height: 50))
        
        let line1 = UIView(frame: CGRect(x: 0, y: 59, width: view.frame.width, height: 1))
        line1.backgroundColor = .lightGray
        line1.alpha = 0.5
        
        //2
        let label2 = UILabel(frame: CGRect(x: 0, y: 75, width: 150, height: 30))
        label2.text = "Support"
        label2.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage2 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 75, width: 20, height: 20))
        IconRightImage2.image = UIImage(named: "icons8-forward-60")
        
        let line2 = UIView(frame: CGRect(x: 0, y: 119, width: view.frame.width, height: 1))
        line2.backgroundColor = .lightGray
        line2.alpha = 0.5
        
        //3
        let label3 = UILabel(frame: CGRect(x: 0, y: 135, width: 150, height: 30))
        label3.text = "Report a Bug"
        label3.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage3 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 145, width: 20, height: 20))
        IconRightImage3.image = UIImage(named: "icons8-forward-60")
        
        let line3 = UIView(frame: CGRect(x: 0, y: 179, width: view.frame.width, height: 1))
        line3.backgroundColor = .lightGray
        line3.alpha = 0.5
        
        //4
        let label4 = UILabel(frame: CGRect(x: 0, y: 205, width: 150, height: 30))
        label4.text = "App Version 1.0"
        label4.font = UIFont.boldSystemFont(ofSize: 16.0)

        
        let IconRightImage4 = UIImageView(frame: CGRect(x: view.frame.width - 20, y: 215, width: 20, height: 20))
        IconRightImage4.image = UIImage(named: "icons8-forward-60")
        
        let line4 = UIView(frame: CGRect(x: 0, y: 239, width: view.frame.width, height: 1))
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
        let Icon = UIImageView(frame: CGRect(x: 30, y: 730, width: 20, height: 20))
        Icon.image = UIImage(named: "Logout")
        return Icon
    }()
    
    let LogoutButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 45, y: 730, width: 100, height: 20))
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(LogOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    print("iPhone 5 or 5S or 5C or SE")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 25, width: 150, height: 50)

                case 1334:
                    print("iPhone 6/6S/7/8")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 25, width: 150, height: 50)

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 25, width: 150, height: 50)
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
        self.present(controller, animated: true, completion: nil)
        //self.navigationController?.pushViewController(mapView, animated: true)
        
    }
}

