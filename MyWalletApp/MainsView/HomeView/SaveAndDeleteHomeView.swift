//
//  SaveAndDeleteHomeView.swift
//  MyWalletApp
//
//  Created by Tuan on 23/11/2021.
//

import UIKit
import FSCalendar
import Firebase

class SaveAndDeleteHomeView: UIViewController, UITextFieldDelegate, CAAnimationDelegate {

    lazy var TheChoicedThing = ""
    lazy var Time = ""
    lazy var AccountChoiced : String = ""
//    lazy var TypeAccount : [(TypeAccount: String, Value: String)] = []
    lazy var isSelected = false
    lazy var key = ""
    lazy var Path = ""
    lazy var TimeDeleted = ""
    lazy var CategorySection = ""
    lazy var ValueTf = ""
    lazy var Detail = ""
    lazy var Datebt = ""
    lazy var NoteTf = ""
    
    
    let transparentView = UIView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    var TableView = UITableView()

    
    let Category: [String : [String]] = ["Children":["Tuition","Books","Toy","Pocket money"],
                                    "Service":["Electric","Water","Internet","Gas","Mobile","Television"],
                                    "Study":["Tuition","Relationship"],
                                    "Health":["Medication","Sport","Medical examination"],
                                    "Food":["Dining out","Cafe","Supermarket","Dinner","Lunch","Breakfast"],
                                    "Vehicles":["Gas", "Insurance", "Parking", "Car wash", "Maintenance", "Taxi"],
                                    "House":["Furniture","Fixing","Rent"],
                                    "Gift":["Wedding","Visit"],
                                    "Bank":["Transfer fee"],
                                    "Entertain":["Travel","Cosmetics","Game","Cinema"]]
    let SelectedCategoryArray = ["Children","Service","Study","Health","Food","Vehicles","House",
                                   "Gift","Bank","Entertain" ]
  
    let backGround : UIImageView = {
        let Image = UIImageView(image: UIImage(named: "Background"))
        Image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Image
    }()
    
    let CategoryButton : UIButton = {
        let button = UIButton()
        button.setTitle("Category", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 50, width: 150, height: 50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
      //  button.addTarget(self, action: #selector(SelectedCategory), for: .touchUpInside)
        button.layer.cornerRadius = 15.0
        button.backgroundColor = UIColor(hexString: "163058")
        return button
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120)
        view.backgroundColor = .white
        view.layer.cornerRadius = 15.0
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
      //  button.addTarget(self, action: #selector(BacktoSpendingView), for: .touchUpInside)
        return button
    }()
    
    let MoneyInput : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.075*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.borderWidth = 0.5
        Tf.layer.cornerRadius = 15.0
        let image = UIImage(named: "USD")
        let VND = UIImage(named: "VND")
        Tf.withImage(direction: .Right, image: VND!)
        Tf.withImage(direction: .Left, image: image!)
        Tf.keyboardType = .numberPad
        Tf.placeholder = "Value"
        return Tf
    }()

    
    let ButtonList : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.175*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
     //   button.addTarget(self, action: #selector(HidingTable), for: .touchUpInside)
        button.setTitle("--------Category--------", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let ListDetail : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    let ScheduleButton : UIButton  = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.275*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.setTitle("--------Date--------", for: .normal)
        button.contentHorizontalAlignment = .center
        button.setTitleColor(.lightGray, for: .normal)
       // button.addTarget(self, action: #selector(ShowCalendar), for: .touchUpInside)
        return button
    }()
    
    let Calendar : FSCalendar = {
          let calendar = FSCalendar()
          calendar.frame = CGRect(x: 30, y: 0.35*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height * 0.3)
          calendar.layer.cornerRadius = 10.0
          calendar.layer.borderWidth = 0.25
          return calendar
      }()
    
    let noteTextfield : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.375*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.borderWidth = 0.5
        Tf.layer.cornerRadius = 15.0
        Tf.placeholder = "Note"
        let image = UIImage(named: "Note")
        Tf.withImage(direction: .Left, image: image!)
        Tf.font = UIFont.systemFont(ofSize: 15)
        
        return Tf
    }()

    let AccountButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.475*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
       // button.addTarget(self, action: #selector(ShowListAccount), for: .touchUpInside)
        button.setTitle("-----Account-----", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    
    let ListCategory : UITableView = {
        let table = UITableView()
        return table
    }()
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: UIScreen.main.bounds.width/2 + 5, y: 0.575*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width/2 - 35, height: 0.075*UIScreen.main.bounds.height)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.backgroundColor = UIColor(hexString: "090F52")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(Save), for: .touchUpInside)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    let DeleteButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.575*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width/2 - 35, height: 0.075*UIScreen.main.bounds.height)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.layer.borderColor = UIColor.red.cgColor   //  button.backgroundColor = UIColor(hexString: "090F52")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(DeleteButtonAction), for: .touchUpInside)
        return button
    }()
    

    let WarningView : UIButton = {
        let label = UIButton()
        label.frame = CGRect(x: 60, y: 0.015*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 120, height: UIScreen.main.bounds.height * 0.04)
        label.backgroundColor = .red
        label.setTitle("Please fill out the information completely", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.layer.cornerRadius = 19.0
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.7
        return label
    }()
    
    let WarningCompletelyView : UIButton = {
        let label = UIButton()
        label.frame = CGRect(x: 60, y: 0.015*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 120, height: UIScreen.main.bounds.height * 0.04)
        label.backgroundColor = .green
        label.setTitle("Completely", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.layer.cornerRadius = 19.0
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowRadius = 15
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.7
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(CategoryButton)
        view.addSubview(BackButton)
        MainView.addSubview(WarningCompletelyView)
        MainView.addSubview(WarningView)
        MainView.addSubview(MoneyInput)
        MainView.addSubview(ButtonList)
        MainView.addSubview(noteTextfield)
        MainView.addSubview(ScheduleButton)
        MainView.addSubview(AccountButton)
        MainView.addSubview(DoneButton)
        MainView.addSubview(DeleteButton)
        MainView.addSubview(Calendar)
       
        
      //  MainView.addSubview(Calendar)
//        WarningView.isHidden = true
//        WarningCompletelyView.isHidden = true
//        
//        MoneyInput.delegate = self
//
//        ListCategory.delegate = self
//        ListCategory.dataSource = self
        

//        self.ListDetail.register(UITableViewCell.self, forCellReuseIdentifier: "ListDetail")
//        ListDetail.delegate = self
//        ListDetail.dataSource = self
        
        
        Calendar.isHidden = true
        Calendar.delegate = self
        Calendar.dataSource = self

        
        //call Function For UpdateData -> ListAccountTable
        self.hideKeyboardWhenTappedAround()
        print("key: \(key)")
       
        CategoryButton.setTitle(CategorySection, for: .normal)
        // Do any additional setup after loading the view.\
//        let path = UserDefaults.standard.string(forKey: "Username")
//            let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("\(AccountChoiced)")
//
//            ref.observe(.value, with: { [self] (snapshot) in
//              // cập nhật data
//                for children in snapshot.children {
//                    if let postSnapshot = children as? DataSnapshot {
//                      if let Account = postSnapshot.childSnapshot(forPath: "Account").value as? String{
//                        Path = Account
//                  }
//                }
//              }
//              // cập nhật u
//            })
    }
}
    
extension SaveAndDeleteHomeView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
    
    
}

extension SaveAndDeleteHomeView: FSCalendarDelegate, FSCalendarDataSource{
    
}

extension SaveAndDeleteHomeView{
    @objc func SelectedCategory(sender: UIButton){
        isSelected = !isSelected
        TableView = ListCategory
        selectedButton = ButtonList
        if isSelected{
        addTransparentView(frames: ButtonList.frame)
        }else{
         removeTransparentView()

        }
      }

    
    @objc func BacktoSpendingView(sender: UIButton){
            let mapView = (self.storyboard?.instantiateViewController(identifier: "SpendingInWalletView"))! as SpendingInWalletView
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        mapView.Path = self.Path
        mapView.ButtonTime.setTitle(TimeDeleted, for: .normal)
        mapView.ButtonTime.setTitleColor(.blue, for: .normal)
        self.navigationController?.pushViewController(mapView, animated: true)

    }
    
    @objc func ShowCalendar(){
        Calendar.isHidden = !Calendar.isHidden
        AccountButton.isHidden = !AccountButton.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
        DeleteButton.isHidden = !DeleteButton.isHidden
        noteTextfield.isHidden = !noteTextfield.isHidden
    }
    
    @objc func HidingTable(_ sender: UIButton){
        TableView = ListDetail
        selectedButton = ButtonList
        addTransparentView(frames: ButtonList.frame)

    }
    
//
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.MainView.frame
        self.MainView.addSubview(transparentView)

        TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.MainView.addSubview(TableView)
        TableView.layer.cornerRadius = 5

        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
       // TableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [self] in
            self.transparentView.alpha = 0.5
            if TableView == ListCategory{
            self.TableView.frame = CGRect(x: frames.origin.x, y: 0, width: frames.width, height: 0.2*UIScreen.main.bounds.height)
            }else{
                self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0.2*UIScreen.main.bounds.height)
            }
        }, completion: nil)
    }
//
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { [self] in
            self.transparentView.alpha = 0
            if selectedButton == CategoryButton{
                self.transparentView.alpha = 0
            self.TableView.frame = CGRect(x: frames.origin.x, y: 0, width: frames.width, height: 0)
            }else{
                self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            }
        }, completion: nil)
    }
    
    @objc func Save(sender: UIButton){
       //check if it contains data
        if MoneyInput.text == "" || ButtonList.titleLabel?.text == "--------Category--------" || ScheduleButton.titleLabel?.text == "--------Date--------" || AccountButton.titleLabel?.text == "-----Account-----"{
            //Push up Warning
            WarningView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningView.isHidden = true
            }
            return
        }else{
        //Creat a path for data
        let path = UserDefaults.standard.string(forKey: "Username")
            let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("\(AccountChoiced)")
            
            let refforHomeView = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("DataHomeView")
        // remove value
            DeleteData(childPath: TimeDeleted, key: key)

            let newRef = ref.childByAutoId()
            let newRefforHomeView = refforHomeView.childByAutoId()
            //creat new data
        let val: [String : Any] = [
            "Category": CategoryButton.titleLabel?.text as Any,
            "Value": MoneyInput.text as Any,
            "Date": ScheduleButton.titleLabel?.text as Any,
            "Note": noteTextfield.text as Any,
            "Account": AccountButton.titleLabel?.text as Any,
            "Detail": ButtonList.titleLabel?.text as Any
        ]

        // push value
        newRef.setValue(val)
            newRefforHomeView.setValue(val)
            let mapView = (self.storyboard?.instantiateViewController(identifier: "SpendingInWalletView"))! as SpendingInWalletView
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        mapView.Path = self.Path
        mapView.ButtonTime.setTitle(TimeDeleted, for: .normal)
        mapView.ButtonTime.setTitleColor(.blue, for: .normal)
        self.navigationController?.pushViewController(mapView, animated: true)

        }
        
    }
    
    @objc func DeleteButtonAction(){
        DeleteData(childPath: TimeDeleted, key: key)
        DeleteDataHomeView()
        let mapView = (self.storyboard?.instantiateViewController(identifier: "SpendingInWalletView"))! as SpendingInWalletView
    let transition = CATransition.init()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
    transition.type = CATransitionType.push //Transition you want like Push, Reveal
    transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
    transition.delegate = self
    view.window!.layer.add(transition, forKey: kCATransition)
    mapView.Path = self.Path
    mapView.ButtonTime.setTitle(TimeDeleted, for: .normal)
    mapView.ButtonTime.setTitleColor(.blue, for: .normal)
    self.navigationController?.pushViewController(mapView, animated: true)
    }
//
    func DeleteData(childPath:String,key: String){
        // tạo ref tới dữ liệu cha
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(childPath)").child(AccountChoiced)
        
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
    
    func DeleteDataHomeView(){
        let path = UserDefaults.standard.string(forKey: "Username")
        let refforHomeView = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("DataHomeView")
        
        refforHomeView.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                let key = postSnapshot.key
                if let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Detail = postSnapshot.childSnapshot(forPath: "Detail").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Note = postSnapshot.childSnapshot(forPath: "Note").value as? String,
                let Account = postSnapshot.childSnapshot(forPath: "Account").value as? String{
                    print(Category,Value,Detail,Note,Account,key)
                    if Category == CategorySection && Value == ValueTf
                        && Detail == self.Detail && Account == AccountChoiced
                        && Note == NoteTf && Date == Datebt{
                        
                        let currentRef = refforHomeView.child(key)
                        currentRef.removeValue{ (err, ref) in
                          if let err = err {
                            print(err)
                          } else {
                            // thành công, bỏ chọn trên UI
                            print("Done")
                          }
                        }
                        
                    }
                    
              }
            }
          }
        })
    }
}
