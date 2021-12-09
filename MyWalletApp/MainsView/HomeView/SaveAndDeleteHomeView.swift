//
//  SaveAndDeleteHomeView.swift
//  MyWalletApp
//
//  Created by Tuan on 23/11/2021.
//

import UIKit
import FSCalendar
import Firebase

class SaveAndDeleteHomeView: UIViewController, CAAnimationDelegate {

    lazy var AccountChoiced : String = ""
    lazy var isSelected = false
    lazy var key = ""
    lazy var Path = ""
    lazy var TimeDeleted = ""
    lazy var CategorySection = ""
    lazy var ValueTf = ""
    lazy var Detail = ""
    lazy var Datebt = ""
    lazy var NoteTf = ""
    lazy var Time = ""
    
    
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
        button.addTarget(self, action: #selector(SelectedCategory), for: .touchUpInside)
        button.layer.cornerRadius = 15.0
        button.backgroundColor = UIColor(hexString: "163058")
        button.setTitleColor(.white, for: .normal)
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
        button.addTarget(self, action: #selector(BacktoSpendingView), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(HidingTable), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(ShowCalendar), for: .touchUpInside)
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
       
        
        MainView.addSubview(Calendar)
        WarningView.isHidden = true
        WarningCompletelyView.isHidden = true
        
        MoneyInput.delegate = self

        ListCategory.delegate = self
        ListCategory.dataSource = self
        

        self.ListDetail.register(UITableViewCell.self, forCellReuseIdentifier: "ListDetail")
        ListDetail.delegate = self
        ListDetail.dataSource = self
        
        
        Calendar.isHidden = true
        Calendar.delegate = self
        Calendar.dataSource = self

        
        //call Function For UpdateData -> ListAccountTable
        self.hideKeyboardWhenTappedAround()
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    print("iPhone 5 or 5S or 5C or SE")
                    CategoryButton.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 35, width: 150, height: 50)
                    BackButton.frame = CGRect(x: 15, y: 35, width: 50, height: 50)

                case 1334:
                    print("iPhone 6/6S/7/8")
                    CategoryButton.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 35, width: 150, height: 50)
                    BackButton.frame = CGRect(x: 15, y: 35, width: 50, height: 50)

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    CategoryButton.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 35, width: 150, height: 50)
                    BackButton.frame = CGRect(x: 15, y: 35, width: 50, height: 50)
                default:
                    print("Unknown")
                    CategoryButton.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 50, width: 150, height: 45)
                    BackButton.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
                }
            }
    }
}
    
extension SaveAndDeleteHomeView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ListDetail{
            if CategoryButton.titleLabel?.text == "Category"{
            return Category["\(CategorySection)"]!.count
            }else{
                let CategorySection = (CategoryButton.titleLabel?.text)!
                return Category["\(CategorySection)"]!.count
            }
        }else{
            return SelectedCategoryArray.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ListDetail{
            let cell = ListDetail.dequeueReusableCell(withIdentifier: "ListDetail",for: indexPath)
            var SelectedCategory = ""
            if CategoryButton.titleLabel?.text == "Category"{
                SelectedCategory = CategorySection
            }else{
                SelectedCategory = (CategoryButton.titleLabel?.text)!
            }
            cell.textLabel?.text = Category["\(SelectedCategory)"]![indexPath.row]
            cell.textLabel?.textAlignment = .center
            return cell
        } else if tableView == ListCategory{
            let cell = UITableViewCell()
            cell.textLabel?.text = SelectedCategoryArray[indexPath.row]
            cell.textLabel?.textAlignment = .center
            return cell

        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ListDetail{
//            let CategorySelected = (CategoryButton.titleLabel?.text)!
            var SelectedCategory = ""
            if CategoryButton.titleLabel?.text == "Category"{
                SelectedCategory = CategorySection
            }else{
                SelectedCategory = (CategoryButton.titleLabel?.text)!
            }
            ButtonList.setTitle(Category["\(SelectedCategory)"]![indexPath.row], for: .normal)
            ButtonList.setTitleColor(.black, for: .normal)
            ButtonList.titleLabel?.textAlignment = .center
            removeTransparentView()
//            TheChoicedThing = Category["\(CategorySelected)"]![indexPath.row]
            
        }else{
            let Data = SelectedCategoryArray[indexPath.row]
            CategoryButton.setTitle(Data, for: .normal)
            ButtonList.setTitle("--------Category--------", for: .normal)
            ButtonList.setTitleColor(.lightGray, for: .normal)

            removeTransparentView()
        }
    }
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
            let mapView = (self.storyboard?.instantiateViewController(identifier: "DetailSpending"))! as DetailSpending
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
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
           // let CategoryHomeView = UserDefaults.standard.string(forKey: "Category")
            let Time = UserDefaults.standard.string(forKey: "Time")!
            let path = UserDefaults.standard.string(forKey: "Username")
            let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("\(AccountChoiced)")
            
            let refforHomeView = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("DataHomeView")
            
            let refforNotification = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Notification")
        // remove value
            DeleteData(childPath: TimeDeleted, key: key)
            DeleteDataAccount()

            let newRef = ref.childByAutoId()
            let newRefforHomeView = refforHomeView.childByAutoId()
            let NewRefforNotification = refforNotification.childByAutoId()
            //creat new data
        let val: [String : Any] = [
            "Category": CategoryButton.titleLabel?.text as Any,
            "Value": MoneyInput.text as Any,
            "Date": ScheduleButton.titleLabel?.text as Any,
            "Note": noteTextfield.text as Any,
            "Account": AccountButton.titleLabel?.text as Any,
            "Detail": ButtonList.titleLabel?.text as Any
        ]
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy/MM/dd HH:mm"
            let date = Date()
            let newDateformatter = dateFormatterPrint.string(from: date)
            let valforNotification: [String : Any] = [
                "Notification": "You updated \(ValueTf)đ for \(Detail) in  \((AccountButton.titleLabel?.text)!)",
                "Date": newDateformatter
            ]
        // push value
            newRef.setValue(val)
            newRefforHomeView.setValue(val)
            NewRefforNotification.setValue(valforNotification)
            let mapView = (self.storyboard?.instantiateViewController(identifier: "DetailSpending"))! as DetailSpending
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(mapView, animated: true)

        }
        
    }
    
    @objc func DeleteButtonAction(){
        DeleteData(childPath: TimeDeleted, key: key)
        DeleteDataAccount()
        let mapView = (self.storyboard?.instantiateViewController(identifier: "DetailSpending"))! as DetailSpending
    let transition = CATransition.init()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
    transition.type = CATransitionType.push //Transition you want like Push, Reveal
    transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
    transition.delegate = self
    view.window!.layer.add(transition, forKey: kCATransition)
    self.navigationController?.pushViewController(mapView, animated: true)
    }
//
    func DeleteData(childPath:String,key: String){
        // tạo ref tới dữ liệu cha
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(childPath)").child("DataHomeView")
        let refforNotification = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Notification")
        // tạo ref đến dữ liệu có key thỏa mãn
        let currentRef = ref.child(key)
        let NewRefforNotification = refforNotification.childByAutoId()
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy/MM/dd HH:mm"
        let date = Date()
        let newDateformatter = dateFormatterPrint.string(from: date)
        let valforNotification: [String : Any] = [
            "Notification": "You deleted the spending \(ValueTf)đ of \(Detail) in \((AccountButton.titleLabel?.text)!)",
            "Date": newDateformatter
        ]

        NewRefforNotification.setValue(valforNotification)
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
    
    func DeleteDataAccount(){
       // let CategoryHomeView = UserDefaults.standard.string(forKey: "Category")
        let Time = UserDefaults.standard.string(forKey: "Time")!
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("\(Time)").child("\(AccountChoiced)")
        
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                let Key = postSnapshot.key
                if let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Detail = postSnapshot.childSnapshot(forPath: "Detail").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Note = postSnapshot.childSnapshot(forPath: "Note").value as? String,
                let Account = postSnapshot.childSnapshot(forPath: "Account").value as? String{
                    print(Category,Value,Detail,Note,Account,Key)
                    if Category == CategorySection && Value == ValueTf
                        && Detail == self.Detail && Account == AccountChoiced
                        && Note == NoteTf && Date == Datebt{
                        
                        let currentRef = ref.child(Key)
                        currentRef.removeValue{ (err, ref) in
                          if let err = err {
                            print(err)
                          } else {
                            // thành công, bỏ chọn trên UI
                            print("Done")
                            print("keyABC: \(Key)")
                          }
                        }
                        
                    }
                    
              }
            }
          }
        })
    }
}

extension SaveAndDeleteHomeView:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

              let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.groupingSeparator = "."
                formatter.locale = Locale.current
                formatter.maximumFractionDigits = 0
               // Uses the grouping separator corresponding to your Locale
               // e.g. "," in the US, a space in France, and so on
        if textField.text!.count < 12{
              if let groupingSeparator = formatter.groupingSeparator{
                  if string == groupingSeparator {
                     return true
                  }
                  if let textWithoutGroupingSeparator = textField.text?.replacingOccurrences(of: groupingSeparator, with: "") {
                      var totalTextWithoutGroupingSeparators = textWithoutGroupingSeparator + string
                      if string.isEmpty { // pressed Backspace key
                          totalTextWithoutGroupingSeparators.removeLast()
                      }
                      if let numberWithoutGroupingSeparator = formatter.number(from: totalTextWithoutGroupingSeparators),
                          let formattedText = formatter.string(from: numberWithoutGroupingSeparator) {
                          textField.text = formattedText
                          return false
                      }
                  }
              }
        }else{
            textField.deleteBackward()
        }
        return true
    }
}
