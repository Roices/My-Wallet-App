//
//  AccountView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/08/2021.
//

import UIKit
import FirebaseDatabase

class AccountView: UIViewController {

    
    let TypeAccount = ["Cash","Banking","Credit card","e-Wallet"]
    lazy var AccountChoiced = ""
    
  
    let backGround : UIImageView = {
        let backGround = UIImageView(image: UIImage(named: "Background"))
        backGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return backGround
    }()
    
    let MainView : UIView = {
        let MainView = UIView()
        MainView.backgroundColor = .white
        MainView.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
        MainView.layer.cornerRadius = 15.0
        return MainView
    }()
    
    let View : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        return view
    }()
    
    let TitleAccountLB : UILabel = {
        let label = UILabel()
        label.text = "Account"
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 - 50, y: 50, width: 100, height: 50)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(AccountView.BacktoWallet), for: .touchUpInside)
        return button
    }()
    
    let ValueTF: UITextField = {
        let tf = UITextField()
        tf.frame = CGRect(x: 30, y: 0.1 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        tf.layer.cornerRadius = 15.0
        tf.layer.borderWidth = 0.5
        tf.placeholder = "Value"
        let imageUSD = UIImage(named: "USD")!
        let imageVND = UIImage(named: "VND")!
        tf.withImage(direction: .Left, image: imageUSD)
        tf.withImage(direction: .Right, image: imageVND)
        return tf
    }()
    
    let TypeAccountBT : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.2 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(ChooseAccount), for: .touchUpInside)
        button.setTitle("------Type Account------", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let ListAccount : UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 30, y: 0.275 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.2*UIScreen.main.bounds.height)
        tableView.layer.cornerRadius = 15.0
        tableView.layer.borderWidth = 0.5
        return tableView
    }()
    
    
    @objc let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.3 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor(hexString: "090F52")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(Add), for: .touchUpInside)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(TitleAccountLB)
        MainView.addSubview(ValueTF)
        MainView.addSubview(TypeAccountBT)
        MainView.addSubview(DoneButton)
        MainView.addSubview(ListAccount)
        view.addSubview(BackButton)
        
        
        ListAccount.isHidden = true
        ListAccount.dataSource = self
        ListAccount.delegate = self
       
    }


}

//functions
extension AccountView{
    
    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
     self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    
    
    @objc func Add(sender: UIButton){
        let path = UserDefaults.standard.string(forKey: "Username")
//        let path = "tuan dep trai"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("Account")

        // tạo ref đến dữ liệu mới
    //   let newRef = ref.child("Account")
        let newRef = ref.child("\(AccountChoiced)")

        // đẩy dữ liệu
        newRef.setValue(ValueTF.text)
    }
    
    @objc func ChooseAccount(sender: UIButton){
        ListAccount.isHidden = !ListAccount.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
    }
}

//ListAccountDelegate
extension AccountView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return TypeAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = TypeAccount[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AccountChoiced = TypeAccount[indexPath.row]
        ListAccount.isHidden = !ListAccount.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
        TypeAccountBT.setTitle(TypeAccount[indexPath.row], for: .normal)
        TypeAccountBT.setTitleColor(.black, for: .normal)
    }
}
