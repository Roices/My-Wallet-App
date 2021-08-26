//
//  WalletViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit

class WalletViewController: UIViewController {

    
    let backGround : UIImageView = {
        let backGround = UIImageView(image: UIImage(named: "Background"))
        backGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return backGround
    }()
    
    let MainView : UIView = {
        let MainView = UIView()
        MainView.backgroundColor = .white
        MainView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        MainView.layer.cornerRadius = 15.0
        return MainView
    }()
    
    let WalletImage : UIImageView = {
       let WalletImage = UIImageView(image: UIImage(named: "Wallet"))
        WalletImage.frame = CGRect(x: 30, y: 120, width: 60, height: 60)
        return WalletImage
    }()
    
    let UserAccountLabel : UILabel = {
        let UserAccountLabel = UILabel()
        UserAccountLabel.frame = CGRect(x: 90, y: 135, width: 250, height: 30)
        UserAccountLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        UserAccountLabel.text = "USER's ACCOUNT"
        UserAccountLabel.textAlignment = .center
        return UserAccountLabel
    }()
    
    
    let Line : UIView = {
        let Line = UIView()
        Line.backgroundColor = UIColor(hexString: "D6D6D6")
        Line.frame = CGRect(x: 30, y: 205, width: UIScreen.main.bounds.width - 60, height: 1)
        return Line
    }()
    
    let MoneyLabel : UILabel = {
        let MoneyLabel = UILabel()
        MoneyLabel.frame = CGRect(x: 0, y: 205 + 32, width: UIScreen.main.bounds.width, height: 30)
        MoneyLabel.text = "Total: 100.000.000đ"
        MoneyLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        MoneyLabel.textAlignment = .center
        return MoneyLabel
        
    }()
    
    let Segment:UISegmentedControl = {
        let Segment = UISegmentedControl()
        Segment.frame = CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 60)

        Segment.insertSegment(withTitle: "Account", at: 0, animated: true)
        Segment.insertSegment(withTitle: "Saving", at: 1, animated: true)
        Segment.insertSegment(withTitle: "Accumulation", at: 2, animated: true)
        Segment.selectedSegmentIndex = 0
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            Segment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let TextForSelectedColor = [NSAttributedString.Key.foregroundColor: UIColor.black]
            Segment.setTitleTextAttributes(TextForSelectedColor, for: .selected)
       // Segment.addTarget(self, action: #selector(Add), for: .valueChanged )
        return Segment
    }()
    
    let tableWallet : UITableView = {
        let tableWallet = UITableView()
        tableWallet.frame = CGRect(x: 0, y: 360, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 265)
        return tableWallet
    }()
    
    
    let AddWalletButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "Plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor(hexString: "090F52")
        button.addTarget(self, action: #selector(Add), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableWallet.delegate = self
        tableWallet.dataSource = self
        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(WalletImage)
        view.addSubview(UserAccountLabel)
        view.addSubview(Line)
        view.addSubview(MoneyLabel)
        view.addSubview(Segment)
        view.addSubview(tableWallet)
       // view.addSubview(AddWalletButton)
        // Do any additional setup after loading the view.
        let tabarY = self.tabBarController!.tabBar.frame.origin.y
        AddWalletButton.frame = CGRect(x: UIScreen.main.bounds.width - 75, y: tabarY - 75, width: 50, height: 50)
        view.addSubview(AddWalletButton)
        
         self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Background"), for: .default)
     //   self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "090F52")
//            UIColor(hexString: "090F52")
      //  backGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (navigationController?.navigationBar.frame.height)!)
    }
    

  
}


extension WalletViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AccountCell.cellForTableView(tableView: tableWallet)
        return cell
    }
    
    
}


extension WalletViewController{
//    @objc func Add(sender: UISegmentedControl){
//        switch sender.selectedSegmentIndex {
//        case 0:
//
//
//        case 1:
//
//        default:
//
//        }
//    }
    
    @objc func Add(sender: UIButton){
        if Segment.selectedSegmentIndex == 0{
        let mapView = (self.storyboard?.instantiateViewController(identifier: "AccountView"))! as AccountView
         self.navigationController?.pushViewController(mapView, animated: true)
       


            }
        else if Segment.selectedSegmentIndex == 1{
        let mapView = (self.storyboard?.instantiateViewController(identifier: "SavingView"))! as SavingView
            self.navigationController?.pushViewController(mapView, animated: true)

        }
        else{
        let mapView = (self.storyboard?.instantiateViewController(identifier: "AccumulationView"))! as AccumulationView
            self.navigationController?.pushViewController(mapView, animated: true)

    }
}


}
