//
//  WalletViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit
import FirebaseDatabase

class WalletViewController: UIViewController {

    
    lazy var ListAccount : [(TypeAccount: String, Value: String)] = []
    lazy var ListSavingPlan : [(Name: String, Value: String, Rate: String, Date: String)] = []
    lazy var ListAccumulationPlan : [(Target: String,TargetValue: String,ValueComplete: String)] = []
    
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
        Segment.addTarget(self, action: #selector(SelectTableData), for: .valueChanged )
        return Segment
    }()
    
    let tableWallet : UITableView = {
        let tableWallet = UITableView()
       tableWallet.frame = CGRect(x: 0, y: 360, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 265)
        return tableWallet
    }()
    
    let SavingPlanTable : UITableView = {
        let tableWallet = UITableView()
       tableWallet.frame = CGRect(x: 0, y: 360, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 265)
        return tableWallet
    }()
    
    let AccumulationPlanTable : UITableView = {
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
        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(WalletImage)
        view.addSubview(UserAccountLabel)
        view.addSubview(Line)
        view.addSubview(MoneyLabel)
        view.addSubview(Segment)
        view.addSubview(tableWallet)
        view.addSubview(SavingPlanTable)
        view.addSubview(AccumulationPlanTable)

        SavingPlanTable.isHidden = true
        AccumulationPlanTable.isHidden = true
        // Do any additional setup after loading the view.
        let tabarY = self.tabBarController!.tabBar.frame.origin.y
        AddWalletButton.frame = CGRect(x: UIScreen.main.bounds.width - 75, y: tabarY - 75, width: 50, height: 50)
        view.addSubview(AddWalletButton)
        
        
        //Configure navigation bar
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Background"), for: .default)
        
        
        tableWallet.delegate = self
        tableWallet.dataSource = self
        SavingPlanTable.delegate = self
        SavingPlanTable.dataSource = self
        AccumulationPlanTable.delegate = self
        AccumulationPlanTable.dataSource = self
        //Configure data for Accoutlist,SavingPlanList,AccumulationPlanList
        UpdateDataforAccoutList()
        UpdateDataForSavingPlan()
        UpdateDataForAccumulationPlan()
       
 
        

    
    }
    

  
}


extension WalletViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableWallet{
            return ListAccount.count
        }else if tableView == SavingPlanTable{
            return ListSavingPlan.count
        }else{
            return ListAccumulationPlan.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableWallet{
            
        let cell = AccountCell.cellForTableView(tableView: tableWallet)
        let Data = ListAccount[indexPath.row]
        cell.AccountLabel.text = Data.TypeAccount
        cell.ValueLabel.text = Data.Value
        return cell
            
        }else if tableView == SavingPlanTable{
            
            let cell = SavingPlanCell.cellForTableView(tableView: SavingPlanTable)
            let Data = ListSavingPlan[indexPath.row]
            cell.SavingPlanLabel.text = Data.Name
           // cell.ImageSavingPlan.image = UIImage(named: "\(Data.Name)")
            cell.ValueLabel.text = Data.Value
            cell.DateLabel.text = Data.Date
            return cell
            
        }else if tableView == AccumulationPlanTable{
            let cell = AccumulationPlanCell.cellForTableView(tableView: AccumulationPlanTable)
            let Data = ListAccumulationPlan[indexPath.row]
            cell.TargetLabel.text = Data.Target
            cell.ValueCompleted.text = Data.ValueComplete
            cell.ValueTarget.text = Data.TargetValue
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    
}

//Functions
extension WalletViewController{

    @objc func SelectTableData(sender: UISegmentedControl){
        switch Segment.selectedSegmentIndex {
           case 0:
            tableWallet.isHidden = false
            SavingPlanTable.isHidden = true
            AccumulationPlanTable.isHidden = true
           case 1:
            tableWallet.isHidden = true
            SavingPlanTable.isHidden = false
            AccumulationPlanTable.isHidden = true
           case 2:
            tableWallet.isHidden = true
            SavingPlanTable.isHidden = true
            AccumulationPlanTable.isHidden = false
        default:
            print(0)
        }
    }
    
    func UpdateDataForAccumulationPlan(){
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Accumulation")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.ListAccumulationPlan = [];
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {

             if let TargetPlan = postSnapshot.childSnapshot(forPath: "Target").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let ValueCompleted = postSnapshot.childSnapshot(forPath: "ValueCompleted").value as? String{
                self.ListAccumulationPlan.append((Target: TargetPlan, TargetValue: Value, ValueComplete: ValueCompleted))
              }
            }
          }
          
          // cập nhật ui
          self.AccumulationPlanTable.reloadData()
            print(ListAccumulationPlan)
        })
    }
    
    
    func UpdateDataForSavingPlan(){
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("SavingPlan")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.ListSavingPlan = [];
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
//              let key = postSnapshot.key
              if let SavingPlan = postSnapshot.childSnapshot(forPath: "NameAccount").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Rate = postSnapshot.childSnapshot(forPath: "Interest Rate").value as? String{
                self.ListSavingPlan.append((Name: SavingPlan, Value: Value, Rate: Rate, Date: Date))
              }
            }
          }
          
          // cập nhật ui
          self.SavingPlanTable.reloadData()
        })
    }
    
    func UpdateDataforAccoutList(){
     //   let path = "Account"
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Account")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.ListAccount = [];
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
//              let key = postSnapshot.key
              if let Account = postSnapshot.childSnapshot(forPath: "TypeAccount").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String {
                self.ListAccount.append((TypeAccount: Account,Value: Value))
              }
            }
          }
          
          // cập nhật ui
          self.tableWallet.reloadData()
        })
    }
    
    
    
    
    @objc func Add(sender: UIButton){
        print(ListAccumulationPlan)
        print(ListAccount)
        if Segment.selectedSegmentIndex == 0{
        let mapView = (self.storyboard?.instantiateViewController(identifier: "AccountView"))! as AccountView
         self.navigationController?.pushViewController(mapView, animated: true)
//            tableWallet.isHidden = !tableWallet.isHidden
       
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

extension WalletViewController:AccountCellDelegate,SavingPlanCellDelegate,AccumulationPlancellDelegate{
    func Detail(cell: AccountCell) {
        <#code#>
    }
    
    func Detail(cell: SavingPlanCell) {
        <#code#>
    }
    
    func Detail(cell: AccumulationPlanCell) {
        <#code#>
    }
    
    
}
