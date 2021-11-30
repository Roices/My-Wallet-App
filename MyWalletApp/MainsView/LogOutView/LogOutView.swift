//
//  LogOutView.swift
//  MyWalletApp
//
//  Created by Tuan on 30/11/2021.
//

import UIKit

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
        label.frame = CGRect(x: 30, y: 200, width: 150, height: 40)
        label.text = "About"
        label.textColor = .lightGray
        return label
    }()
    
    lazy var AboutView: UITableView = {
        let Tabel = UITableView()
        Tabel.frame = CGRect(x: 30, y: 260, width: UIScreen.main.bounds.width - 60, height: 200)
        Tabel.separatorStyle = .none
        //Tabel.backgroundColor = .red
        return Tabel
    }()
    
    let AppLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 500, width: 150, height: 40)
        label.text = "App"
        label.textColor = .lightGray
        return label
    }()
    
    lazy var AppTable : UITableView = {
        let Tabel = UITableView()
        Tabel.frame = CGRect(x: 30, y: 560, width: UIScreen.main.bounds.width - 60, height: 200)
        Tabel.separatorStyle = .none
       // Tabel.backgroundColor = .red
        return Tabel
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
        view.addSubview(AboutTable)
        view.addSubview(AppLabel)
        view.addSubview(AppTable)
    }
    

}

