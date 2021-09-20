//
//  SpendingInWalletView.swift
//  MyWalletApp
//
//  Created by Tuan on 15/09/2021.
//

import UIKit
import MonthYearPicker
import FirebaseDatabase
 

class SpendingInWalletView: UIViewController {

    
    lazy var AccountChoiced = ""
    lazy var Data : [(Category: String, Value: String,Note: String,key: String)] = []
    lazy var TimeSection:[String] = []
    lazy var TotalValue = ""
    lazy var Path = ""
    lazy var MonthChoiced = ""

    let backGround : UIImageView = {
        let backGround = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backGround.image = UIImage(named: "Background")
        return backGround
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(BacktoWallet), for: .touchUpInside)
        return button
    }()
        
    let ButtonTime : UIButton = {
        let formatter = DateFormatter()
        let Time = Date()
        formatter.dateFormat = "MM-YYYY"
        let DateFormatter = formatter.string(from: Time)
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.075*UIScreen.main.bounds.height)
        button.setTitle("\(DateFormatter)", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(DateChosing), for: .touchUpInside)
        button.layer.borderWidth = 0.5
//        button.layer.cornerRadius = 15.0
        return button
    }()
    
    let LineView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0.075*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.025*UIScreen.main.bounds.height))
        let color = UIColor(hexString: "D6D6D6")
        view.backgroundColor =  color
        return view
    }()
    
    
    let totalValueLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0.1*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.075*UIScreen.main.bounds.height)
//        label.text = "Total: " + "\(TotalValue)đ"
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
        return label
    }()
    
    let ButtonHiddenPickerView : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(HidingPickerView), for: .touchUpInside)
        return button
    }()
    
    let picker : MonthYearPickerView = {
        let picker = MonthYearPickerView(frame: CGRect(x: 0, y: 0.075*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.3*UIScreen.main.bounds.height))
        picker.addTarget(self, action: #selector (dateChanged), for: .valueChanged)
        return picker
    }()
    
    let tableData : UITableView = {
       let table = UITableView()
        table.frame = CGRect(x: 0, y: 0.175*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.925)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(BackButton)
        MainView.addSubview(ButtonHiddenPickerView)
        MainView.addSubview(ButtonTime)
        MainView.addSubview(LineView)
        MainView.addSubview(totalValueLabel)
        MainView.addSubview(tableData)
        MainView.addSubview(picker)
        
        picker.isHidden = true
        tableData.delegate = self
        tableData.dataSource = self
        
        totalValueLabel.text = "Total: " + "\(TotalValue)đ"
        ConfigureDataForTable()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
     self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    @objc func dateChanged(sender: MonthYearPickerView){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-YYYY"
        let DateFormatter = formatter.string(from: picker.date)
        ButtonTime.setTitle("\(DateFormatter)", for: .normal)
        MonthChoiced = DateFormatter
        print(MonthChoiced)
        ConfigureDataForTable()

       
    }
    
    @objc func DateChosing(sender: UIButton){
        picker.isHidden = !picker.isHidden
        tableData.isHidden = !tableData.isHidden
        totalValueLabel.isHidden = !totalValueLabel.isHidden
        
        
    }
    
    @objc func HidingPickerView(sender: UIButton){
        picker.isHidden = !picker.isHidden
        tableData.isHidden = !tableData.isHidden
        totalValueLabel.isHidden = !totalValueLabel.isHidden
    }

    func ConfigureDataForTable(){        
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("\(MonthChoiced)").child(Path)
        
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
            self.Data = [];
            self.TimeSection = []
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                let key = postSnapshot.key
             if let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Note = postSnapshot.childSnapshot(forPath: "Note").value as? String,
                let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String{
                self.Data.append((Category: Category, Value: Value, Note: Note ,key: key ))
                self.TimeSection.append(Date)
              }
            }
          }
          // cập nhật ui
          self.tableData.reloadData()
            
        })
    }
}


extension SpendingInWalletView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
      return  TimeSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  Data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SpendingInWalletCell.cellForTableView(tableView: tableData)
        let Data = Data[indexPath.row]
        cell.CategoryLabel.text = Data.Category
        cell.NoteLabel.text = "Note: " + Data.Note
        cell.ValueLabel.text = Data.Value
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.025*UIScreen.main.bounds.height))
           let color = UIColor(hexString: "D6D6D6")
           view.backgroundColor =  color
             
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 0.025*UIScreen.main.bounds.height))
           lbl.font = UIFont.systemFont(ofSize: 15)
           lbl.text = TimeSection[section]
           view.addSubview(lbl)
           return view
         }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.025*UIScreen.main.bounds.height
    }
}
