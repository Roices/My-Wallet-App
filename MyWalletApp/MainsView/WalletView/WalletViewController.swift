//
//  WalletViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit
import FirebaseDatabase

class WalletViewController: UIViewController {

    
    lazy var ListAccount : [(TypeAccount: String, Value: String,Name: String,key: String)] = []
    lazy var ListSavingPlan : [(Name: String, Value: String, Rate: String, Date: String,Period: String,key: String)] = []
    lazy var ListAccumulationPlan : [(Target: String,TargetValue: String,ValueCompleted: String,Date: String,ExpirationDate: String,key: String)] = []
    lazy var TotalValueAccount = ""
    lazy var TotalValueSavingPlan = ""
    lazy var TotalValueAccumulation = ""
    
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
        MainView.backgroundColor = .white
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
      //  MoneyLabel.text = "Total: 100.000.000đ"
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
       tableWallet.frame = CGRect(x: 0, y: 360, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableWallet.translatesAutoresizingMaskIntoConstraints = false
        return tableWallet
    }()
    
    let SavingPlanTable : UITableView = {
        let tableWallet = UITableView()
       tableWallet.frame = CGRect(x: 0, y: 360, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableWallet.translatesAutoresizingMaskIntoConstraints = false
        return tableWallet
    }()
    
    let AccumulationPlanTable : UITableView = {
        let tableWallet = UITableView()
        tableWallet.frame = CGRect(x: 0, y: 360, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableWallet.translatesAutoresizingMaskIntoConstraints = false
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
        
        addConstraints()
        
        
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
    
    func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        
       constraints.append(tableWallet.leadingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableWallet.trailingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.trailingAnchor))
       constraints.append(tableWallet.bottomAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        constraints.append(tableWallet.topAnchor.constraint(equalTo: Segment.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        
        constraints.append(SavingPlanTable.leadingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.leadingAnchor))
         constraints.append(SavingPlanTable.trailingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(SavingPlanTable.bottomAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.bottomAnchor,constant: 0))
         constraints.append(SavingPlanTable.topAnchor.constraint(equalTo: Segment.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        
        constraints.append(AccumulationPlanTable.leadingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.leadingAnchor))
         constraints.append(AccumulationPlanTable.trailingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(AccumulationPlanTable.bottomAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.bottomAnchor,constant: 0))
         constraints.append(AccumulationPlanTable.topAnchor.constraint(equalTo: Segment.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        
        NSLayoutConstraint.activate(constraints)
    }

  
}

//Configure TableView

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
           // let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell",for: indexPath) as! AccountCell
        let cell = AccountCell.cellForTableView(tableView: tableWallet)
        let Data = ListAccount[indexPath.row]
        cell.AccountLabel.text = Data.Name
        cell.ValueLabel.text = Data.Value
        cell.Key = Data.key
        cell.delegate = self
        return cell
            
        }else if tableView == SavingPlanTable{
            let cell = SavingPlanCell.cellForTableView(tableView: SavingPlanTable)
            let Data = ListSavingPlan[indexPath.row]
            cell.SavingPlanLabel.text = Data.Name
           // cell.ImageSavingPlan.image = UIImage(named: "\(Data.Name)")
            cell.ValueLabel.text = Data.Value
            cell.DateLabel.text = CalculatorTime(Data.Date, Data.Period)
            cell.key = Data.key
            cell.delegate = self
            return cell
            
        }else if tableView == AccumulationPlanTable{
            let cell = AccumulationPlanCell.cellForTableView(tableView: AccumulationPlanTable)
            let Data = ListAccumulationPlan[indexPath.row]
            cell.TargetLabel.text = Data.Target
            cell.ValueCompleted.text = (Data.ValueCompleted)
            cell.ValueTarget.text = (Data.TargetValue)
            cell.key = Data.key
            cell.ProgressCompletedValue.progress =   Float(CalculateAmount(Data.ValueCompleted)/CalculateAmount(Data.TargetValue))
            cell.delegate = self
            return cell
        }else{
            return UITableViewCell()
        }
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableWallet{
            let Data = ListAccount[indexPath.row]
            let Date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-yyyy"
            let DateFormatted = formatter.string(from: Date)
            let mapView = self.storyboard?.instantiateViewController(identifier: "SpendingInWalletView") as! SpendingInWalletView
            mapView.Path = Data.Name
            mapView.TotalValue = Data.Value
            mapView.MonthChoiced = DateFormatted
            mapView.AccountTitleLabel.text = Data.Name
            mapView.totalValueLabel.text = "Total: " + "\(Data.Value)" + "đ"
            self.navigationController?.pushViewController(mapView, animated: true)
            
        }else if tableView == SavingPlanTable{
            let Mapview = self.storyboard?.instantiateViewController(identifier: "DetailSavingPlanView") as! DetailSavingPlanView
            let Data = ListSavingPlan[indexPath.row]
            Mapview.AccountTitleLabel.text = Data.Name
            Mapview.Title = Data.Name
            Mapview.InitialBalanceValue = Data.Value
            Mapview.InitialTime = Data.Date
            Mapview.Period = Data.Period
            Mapview.ProfitRate = Data.Rate
            self.navigationController?.pushViewController(Mapview, animated: true)
            
        }else if tableView == AccumulationPlanTable{
            let Mapview = self.storyboard?.instantiateViewController(identifier: "DetailAccumulation") as! DetailAccumulation
            
            let Data = ListAccumulationPlan[indexPath.row]
            Mapview.Time = Data.Date
            Mapview.TitleLabel.text = Data.Target
           // Mapview.TitleForAccumulation = Data.Target
            Mapview.CompletedValue = String(Data.ValueCompleted)
            Mapview.Value = String(Data.TargetValue)
            Mapview.Key = Data.key
            Mapview.ExpirationDate = Data.ExpirationDate
            self.navigationController?.pushViewController(Mapview, animated: true)
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
            MoneyLabel.text = "Total: " + TotalValueAccount + "đ"
           case 1:
            tableWallet.isHidden = true
            SavingPlanTable.isHidden = false
            AccumulationPlanTable.isHidden = true
            MoneyLabel.text = "Total: " + TotalValueSavingPlan + "đ"
           case 2:
            tableWallet.isHidden = true
            SavingPlanTable.isHidden = true
            AccumulationPlanTable.isHidden = false
            MoneyLabel.text = "Total: " + TotalValueAccumulation + "đ"
        default:
            //MoneyLabel.text = "Total: " + TotalValueAccount + "đ"
        print(0)
        }
    }
    
    func UpdateDataForAccumulationPlan(){
        var ValueforAccumulation = 0.0
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Accumulation")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.ListAccumulationPlan = [];
            ValueforAccumulation = 0.0
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                let key = postSnapshot.key
             if let TargetPlan = postSnapshot.childSnapshot(forPath: "Target").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let ValueCompleted = postSnapshot.childSnapshot(forPath: "ValueCompleted").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let ExpirationDate = postSnapshot.childSnapshot(forPath: "ExpirationDate").value as? String{
                self.ListAccumulationPlan.append((Target: TargetPlan, TargetValue: Value, ValueCompleted: ValueCompleted,Date: Date,ExpirationDate: ExpirationDate,key: key))
                ValueforAccumulation += CalculateAmount(Value)
              }
            }
          }
          // cập nhật ui
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            let ValueforAccumulation = formatter.string(from: ValueforAccumulation as NSNumber)
            TotalValueAccumulation = ValueforAccumulation!
           // MoneyLabel.text = "Total: " + TotalValueAccumulation + "đ"
          self.AccumulationPlanTable.reloadData()
        })
    }
    
    
    func UpdateDataForSavingPlan(){
        var ValueforSavingPlan = 0.0
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("SavingPlan")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.ListSavingPlan = [];
            ValueforSavingPlan = 0.0
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
               let key = postSnapshot.key
                if let SavingPlan = postSnapshot.childSnapshot(forPath: "NameAccount").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Rate = postSnapshot.childSnapshot(forPath: "Interest Rate").value as? String,
                let Period = postSnapshot.childSnapshot(forPath: "Period").value as? String{
                    self.ListSavingPlan.append((Name: SavingPlan, Value: Value, Rate: Rate, Date: Date,Period: Period,key: key))
                    ValueforSavingPlan += CalculateAmount(Value)
              }
            }
          }
          // cập nhật ui
            
             let formatter = NumberFormatter()
             formatter.numberStyle = .decimal
             formatter.groupingSeparator = "."
             let ValueforSavingPlan = formatter.string(from: ValueforSavingPlan as NSNumber)
             TotalValueSavingPlan = ValueforSavingPlan!
          //  MoneyLabel.text = "Total: " + TotalValueSavingPlan + "đ"
          self.SavingPlanTable.reloadData()
        })
    }
    
    func UpdateDataforAccoutList(){

        var ValueforAccount = 0.0
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Account")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.ListAccount = [];
            ValueforAccount = 0.0
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                let key = postSnapshot.key
              if let Account = postSnapshot.childSnapshot(forPath: "TypeAccount").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let NameAccount = postSnapshot.childSnapshot(forPath: "Name").value as? String{
                self.ListAccount.append((TypeAccount: Account,Value: Value,Name: NameAccount,key: key))
                ValueforAccount += CalculateAmount(Value)
              }
            }
          }
          // cập nhật ui
           // DispatchQueue.main.async{
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            let ValueforAccount = formatter.string(from: ValueforAccount as NSNumber)
            TotalValueAccount = ValueforAccount!
            MoneyLabel.text = "Total: " + TotalValueAccount + "đ"
           
            self.tableWallet.frame.size.height = CGFloat(ListAccount.count * 40)
            self.tableWallet.reloadData()
            
        })
    }
    
    
    
    
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

    func DeleteData(childPath:String,key: String){
        // tạo ref tới dữ liệu cha
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(childPath)")
        
        // tạo ref đến dữ liệu có key thỏa mãn
        let currentRef = ref.child(key)
        
        // xóa
        currentRef.removeValue { (err, ref) in
          if let err = err {
            print(err)
          } else {
            // thành công, bỏ chọn trên UI
            print("Done")
          }
        }
    }
    
    func CalculateAmount(_ Value: String) ->Double{
        var string = Value
        var amount:Double = 0
        let occurrencies = string.filter { $0 == "." }.count
        for index in 0...occurrencies{
            if let lastIndex = string.lastIndex(of: "."){
            let last = string.endIndex
            var subString2 = string[lastIndex..<last]
                string = string.replacingOccurrences(of: subString2, with: "")
                subString2.remove(at: subString2.startIndex)
                amount += Double(subString2)! * pow(1000, Double(index))
            }else{
                amount += Double(string)! * pow(1000, Double(index))
            }
            
        }
        return amount
    }

    func CalculatorTime(_ Date: String,_ AddingTime: String) ->String{
        let dateFormatter = DateFormatter()
        let AddingTime = AddingTime
            .components(separatedBy:CharacterSet.decimalDigits.inverted)
            .joined()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let InitialDate = dateFormatter.date(from: Date)!
        let NewDate = Calendar.current.date(byAdding: .month, value: Int(AddingTime)!, to: InitialDate)
        let Time = dateFormatter.string(from: NewDate!)
        return Time
        
    }
}

//Edit
extension WalletViewController:AccountCellDelegate,SavingPlanCellDelegate,AccumulationPlancellDelegate{
    
    func DetailAccount(cell: AccountCell){
        let indexPath =  tableWallet.indexPath(for: cell)
        let Data = ListAccount[indexPath!.row]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // add action cancel, edit, delete
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alert.addAction(cancel)
        
        let share = UIAlertAction(title: "Edit", style: .default) { (action) in
            let mapView = self.storyboard?.instantiateViewController(identifier: "AccountView") as! AccountView
            mapView.NameAccountTf.text = Data.Name
            mapView.ValueTF.text = Data.Value
            mapView.TypeAccountBT.setTitle( Data.TypeAccount, for: .normal)
            mapView.TypeAccountBT.setTitleColor(.black, for: .normal)
            mapView.Key = Data.key
            self.navigationController?.pushViewController(mapView, animated: true)
        }
        alert.addAction(share)

        let save = UIAlertAction(title: "Delete", style: .default) {  (action) in
            self.DeleteData(childPath:"Account" ,key: self.ListAccount[indexPath!.row].key)
        }
        alert.addAction(save)
        // hiển thị sheet
        present(alert, animated: true, completion: nil)
    }
    
    func DetailSavingPlan(cell: SavingPlanCell) {
        let indexPath =  SavingPlanTable.indexPath(for: cell)
        let Data = ListSavingPlan[indexPath!.row]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // add action cancel, edit, delete
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alert.addAction(cancel)
        
        let share = UIAlertAction(title: "Edit", style: .default) { (action) in
            let MapView = self.storyboard?.instantiateViewController(identifier: "SavingView") as! SavingView
            MapView.valueTf.text = Data.Value
            MapView.NameAccountTf.text = Data.Name
            MapView.Bankrate.text = Data.Rate
            MapView.DateButton.setTitle(Data.Date, for: .normal)
            MapView.DateButton.setTitleColor(.black, for: .normal)
            MapView.periodTf.text = Data.Period
            MapView.Key = Data.key
            self.navigationController?.pushViewController(MapView, animated: true)
        }
        alert.addAction(share)

        let save = UIAlertAction(title: "Delete", style: .default) {  (action) in
            self.DeleteData(childPath: "SavingPlan", key: self.ListSavingPlan[indexPath!.row].key)
        }
        
        alert.addAction(save)
        // hiển thị sheet
        present(alert, animated: true, completion: nil)
    }

    func DetailAccumulationPlan(cell: AccumulationPlanCell){
        let indexPath =  AccumulationPlanTable.indexPath(for: cell)
        let Data = ListAccumulationPlan[indexPath!.row]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // add action cancel, edit, delete
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alert.addAction(cancel)
        
        let share = UIAlertAction(title: "Edit", style: .default) { (action) in
            let MapView = self.storyboard?.instantiateViewController(identifier: "AccumulationView") as! AccumulationView
            MapView.ValueTf.text = String(Data.TargetValue)
            MapView.NoteTf.text = String(Data.Target)
            MapView.DateButton.setTitle( Data.Date , for: .normal)
            MapView.DateButton.setTitleColor(.black, for: .normal)
            MapView.ExpirationDate.setTitle(Data.ExpirationDate, for: .normal)
            MapView.ExpirationDate.setTitleColor(.black, for: .normal)
            MapView.ValueCompleted = Data.ValueCompleted
            MapView.Key = Data.key
            MapView.State = "Edit"
            self.navigationController?.pushViewController(MapView, animated: true)
          
        }
        alert.addAction(share)

        let save = UIAlertAction(title: "Delete", style: .default) {  (action) in
            self.DeleteData(childPath: "Accumulation", key: self.ListAccumulationPlan[indexPath!.row].key)
            
        }
        alert.addAction(save)
        // hiển thị sheet
        present(alert, animated: true, completion: nil)
    }
    
    
}
