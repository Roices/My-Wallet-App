//
//  DetailSpending.swift
//  MyWalletApp
//
//  Created by Tuan on 21/07/2021.
//

import UIKit
import Firebase

class DetailSpending: UIViewController, CAAnimationDelegate {

    lazy var CategoryData : [(Detail: String, Value: String, Note: String, Date: String,Account: String, Key: String)] = []
    lazy var IncomeData : [(Detail: String, Value: String, Note: String, Date: String,Account: String, Key: String)] = []
    lazy var DataForTabel : [(Detail: String, Value: String, Note: String, Date: String,Account: String, Key: String)] = []

    lazy var ColorForIconTable: [String: UIColor] = [:]
    let backGround:UIImageView = {
        let background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return background
    }()
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
//        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(BacktoWallet), for: .touchUpInside)
        return button
    }()

    
    let CategoryLabel : UILabel = {
        let Label = UILabel()
        Label.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 50, width: 150, height: 50)
        Label.font = UIFont.boldSystemFont(ofSize: 20.0)
        Label.textColor = .white
        Label.textAlignment = .center
        return Label
    }()
    
    let MainView : UIView = {
        let MainView = UIView()
       // MainView.backgroundColor  = .lightGray
        MainView.layer.cornerRadius = 15.0
        MainView.frame = CGRect(x: 0, y: 0.134*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.866)
        
        return MainView
    }()
    
    lazy var tableDetail:UITableView = {
       let table = UITableView()
        table.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        table.layer.cornerRadius = 15.0
        table.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor(hexString: "F1F0F6")
        table.separatorStyle = .none
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(backGround)
      //  view.addSubview(tableDetail)
        view.addSubview(BackButton)
        view.addSubview(MainView)
        view.addSubview(CategoryLabel)
        MainView.addSubview(tableDetail)
        AddConstraints()
        
        UpdateData()
        tableDetail.delegate = self
        tableDetail.dataSource = self
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1334:
                    print("iPhone 6/6S/7/8")
                    CategoryLabel.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 35, width: 150, height: 50)
                    BackButton.frame = CGRect(x: 15, y: 35, width: 35, height: 50)

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    CategoryLabel.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 35, width: 150, height: 50)
                    BackButton.frame = CGRect(x: 15, y: 35, width: 50, height: 50)
                default:
                    print("Unknown")
                    CategoryLabel.frame = CGRect(x: 0.3*UIScreen.main.bounds.width, y: 50, width: 0.4*UIScreen.main.bounds.width, height: 50)
                    BackButton.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
                }
            }
    }
}

extension DetailSpending{
    
    func AddConstraints(){
        var constraints = [NSLayoutConstraint]()
        
       constraints.append(tableDetail.leadingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(tableDetail.trailingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.trailingAnchor))
        
      constraints.append(tableDetail.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        constraints.append(tableDetail.topAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.topAnchor,constant: 10))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "HomeView"))! as HomeView
        mapView.ConfigureDataDetail()
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    
    func UpdateData(){
        let CategoryHomeView = UserDefaults.standard.string(forKey: "Category")
        let Time = UserDefaults.standard.string(forKey: "Time")!
        let path = UserDefaults.standard.string(forKey: "Username")
        CategoryLabel.text = CategoryHomeView
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("DataHomeView")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                let key = postSnapshot.key
             if let Detail = postSnapshot.childSnapshot(forPath: "Detail").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Note = postSnapshot.childSnapshot(forPath: "Note").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String,
                let Account = postSnapshot.childSnapshot(forPath: "Account").value as? String{
                if Category == CategoryHomeView{
                    self.CategoryData.append((Detail: Detail, Value: Value, Note: Note, Date: Date,Account: Account, Key: key))
                }else if Category == "Income"{
                    self.IncomeData.append((Detail: Detail, Value: Value, Note: Note, Date: Date, Account: Account, Key: key))
                }
              }
            }
          }
          // cập nhật u
        // self.tableDetail.frame.size.height = CGFloat(100 * CategoryData.count)
            print(IncomeData)
          self.tableDetail.reloadData()
        })
    }
}
extension DetailSpending: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if CategoryData.isEmpty{
            DataForTabel = IncomeData
        }else{
            DataForTabel = CategoryData
        }
        let CategoryHomeView = UserDefaults.standard.string(forKey: "Category")!
        let cell = SpendingCell.cellForTableView(tableView: tableDetail)
        let Data = DataForTabel[indexPath.row]
        cell.DetailLabel.text = Data.Detail
        cell.AccountLabel.text = "Account: " + Data.Account
        cell.ImageView.image = UIImage(named: "\(CategoryHomeView)")
        cell.NoteLabel.text = "Note: " + Data.Note
        cell.ValueLabel.text = Data.Value + "đ"
        cell.ImageView.backgroundColor = ColorForIconTable["\(CategoryHomeView)"]
        cell.ImageView?.layer.borderWidth = 0.25
        cell.ImageView?.layer.cornerRadius = 10.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CategoryData.isEmpty{
            DataForTabel = IncomeData
        }else{
            DataForTabel = CategoryData
        }
        return DataForTabel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MapView = self.storyboard?.instantiateViewController(identifier: "SaveAndDeleteHomeView") as! SaveAndDeleteHomeView
        if CategoryData.isEmpty{
            DataForTabel = IncomeData
        }else{
            DataForTabel = CategoryData
        }
        let Data = DataForTabel[indexPath.row]
        let CategoryHomeView = UserDefaults.standard.string(forKey: "Category")!
        let Time = UserDefaults.standard.string(forKey: "Time")!
        MapView.MoneyInput.text = Data.Value
        MapView.ButtonList.setTitle(Data.Detail, for: .normal)
        MapView.ButtonList.setTitleColor(.black, for: .normal)
        MapView.ScheduleButton.setTitle(Data.Date, for: .normal)
        MapView.ScheduleButton.setTitleColor(.black, for: .normal)
        MapView.noteTextfield.text = Data.Note
        MapView.AccountButton.setTitle(Data.Account, for: .normal)
        MapView.AccountButton.setTitleColor(.black, for: .normal)
        MapView.key = Data.Key
        MapView.Time = Time
        MapView.TimeDeleted = Time
        MapView.AccountChoiced = Data.Account
        MapView.ValueTf = Data.Value
        MapView.Datebt = Data.Date
        MapView.NoteTf = Data.Note
        MapView.Detail = Data.Detail
        MapView.CategorySection = CategoryHomeView
        MapView.CategoryButton.setTitle(CategoryHomeView, for: .normal)
        self.navigationController?.pushViewController(MapView, animated: true)
    }
}
