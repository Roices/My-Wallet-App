//
//  AddDetailView.swift
//  MyWalletApp
//
//  Created by Tuan on 28/07/2021.
//

import UIKit
import FirebaseDatabase
import FSCalendar

class AddDetailView: UIViewController, CAAnimationDelegate{

//    lazy var TheChoicedThing = ""
    lazy var Time = ""
    lazy var SelectedArray : String = ""
    lazy var SelectedLabel : String = ""
    lazy var AccountChoiced : String = ""
    lazy var TypeAccount : [(TypeAccount: String, Value: String)] = []
    
    
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
                                    "Entertain":["Travel","Cosmetics","Game","Cinema"],
                                    "Income":["Wage","Bonus","interest","Other"],
                                    "Loan":["Loan"]]
                                    
    
  
    let backGround : UIImageView = {
        let Image = UIImageView(image: UIImage(named: "Background"))
        Image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Image
    }()
    
    let TitleLB : UILabel = {
        let label = UILabel()
        label.text = ""
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 - 50, y: 50, width: 100, height: 50)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
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
        button.addTarget(self, action: #selector(BackToAddView), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(ShowListAccount), for: .touchUpInside)
        button.setTitle("-----Account-----", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    
    let ListAccount : UITableView = {
        let table = UITableView()
        return table
    }()
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.575*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.backgroundColor = UIColor(hexString: "090F52")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(Save), for: .touchUpInside)
        button.setTitle("Done", for: .normal)
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

        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(TitleLB)
        view.addSubview(BackButton)
        MainView.addSubview(WarningCompletelyView)
        MainView.addSubview(WarningView)
        MainView.addSubview(MoneyInput)
        MainView.addSubview(ButtonList)
        MainView.addSubview(noteTextfield)
        MainView.addSubview(ScheduleButton)
        MainView.addSubview(AccountButton)
        MainView.addSubview(DoneButton)
        MainView.addSubview(Calendar)
       
        
      //  MainView.addSubview(Calendar)
        TitleLB.text = self.SelectedLabel
        WarningView.isHidden = true
        WarningCompletelyView.isHidden = true
        
        MoneyInput.delegate = self

        ListAccount.delegate = self
        ListAccount.dataSource = self
        

        self.ListDetail.register(UITableViewCell.self, forCellReuseIdentifier: "ListDetail")
        ListDetail.delegate = self
        ListDetail.dataSource = self
        
        
        Calendar.isHidden = true
        Calendar.delegate = self
        Calendar.dataSource = self

        
        //call Function For UpdateData -> ListAccountTable
        UpdateDataforAccoutList()
        self.hideKeyboardWhenTappedAround()
       
        // Do any additional setup after loading the view.
    }
    
   
}

//ListDetail and ListAccount configure
extension AddDetailView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ListDetail{
        return Category["\(SelectedArray)"]!.count
        }else{
            return TypeAccount.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ListDetail{
            let cell = ListDetail.dequeueReusableCell(withIdentifier: "ListDetail",for: indexPath)
            cell.textLabel?.text = Category["\(SelectedArray)"]![indexPath.row]
            cell.textLabel?.textAlignment = .center
            return cell
        } else if tableView == ListAccount{
            var cell = tableView.dequeueReusableCell(withIdentifier: "ListAccount")
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "ListAccount")
                let Data = TypeAccount[indexPath.row]
                cell?.textLabel?.text = Data.TypeAccount
                cell?.detailTextLabel?.text = Data.Value + " VND"
                cell?.textLabel?.textAlignment = .left
                cell?.detailTextLabel?.textAlignment = .right
            }
            return cell!

        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == ListDetail{
        ButtonList.setTitle(Category["\(SelectedArray)"]![indexPath.row], for: .normal)
        ButtonList.setTitleColor(.black, for: .normal)
        ButtonList.titleLabel?.textAlignment = .center
        removeTransparentView()
//        TheChoicedThing = Category["\(SelectedArray)"]![indexPath.row]
//
        }else{
            let Data = TypeAccount[indexPath.row]
            let Account = Data.TypeAccount
            AccountButton.setTitle(Account, for: .normal)
            AccountButton.setTitleColor(.black, for: .normal)
            AccountChoiced = Account
            removeTransparentView()
        }
    }
}




//Functions
extension AddDetailView{
    
    func UpdateDataforAccoutList(){
     //   let path = "Account"
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Account")
        ref.observe(.value, with: { (snapshot) in
          // cập nhật data
          self.TypeAccount = [];
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
//              let key = postSnapshot.key
              if let Account = postSnapshot.childSnapshot(forPath: "Name").value as? String,
                let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String {
                self.TypeAccount.append((TypeAccount: Account,Value: Value))
              }
            }
          }
          
          // cập nhật ui
          self.ListAccount.reloadData()
        })
    }
    @objc func BackToAddView(sender: UIButton){
            let mapView = (self.storyboard?.instantiateViewController(identifier: "AddViewController"))! as AddViewController
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
        noteTextfield.isHidden = !noteTextfield.isHidden
    }
    
    @objc func HidingTable(_ sender: UIButton){
        TableView = ListDetail
        selectedButton = ButtonList
        addTransparentView(frames: ButtonList.frame)

    }
    
    
    @objc func ShowListAccount(sender: UIButton){
        TableView = ListAccount
        selectedButton = AccountButton
        addTransparentView(frames: AccountButton.frame)
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.MainView.addSubview(transparentView)
        
        TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.MainView.addSubview(TableView)
        TableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
       // TableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0.2*UIScreen.main.bounds.height)
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.TableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
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

        let newRef = ref.childByAutoId()
        let newRefforHomeView = refforHomeView.childByAutoId()
        // creat new value
            
        let val: [String : Any] = [
            "Category": SelectedArray,
            "Value": MoneyInput.text as Any,
            "Date": ScheduleButton.titleLabel?.text as Any,
            "Note": noteTextfield.text as Any,
            "Account": AccountButton.titleLabel?.text as Any,
            "Detail": ButtonList.titleLabel?.text as Any
        ]

        // push value
            newRef.setValue(val)
            newRefforHomeView.setValue(val)
            
            MoneyInput.text = ""
            ButtonList.setTitle("--------Category--------", for: .normal)
            ButtonList.setTitleColor(.lightGray, for: .normal)
            ScheduleButton.setTitle("--------Date--------", for: .normal)
            ScheduleButton.setTitleColor(.lightGray, for: .normal)
            noteTextfield.text = ""
            AccountButton.setTitle("-----Account-----", for: .normal)
            AccountButton.setTitleColor(.lightGray, for: .normal)
            
            
            //Push Compeletely notification
            WarningCompletelyView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningCompletelyView.isHidden = true
            }


        }
        
    }
    
}


extension AddDetailView: FSCalendarDataSource, FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let DateFormatter = formatter.string(from: date)
        formatter.dateFormat = "MM-YYYY"
        Time = formatter.string(from: date)
        
        
        ScheduleButton.setTitle("\(DateFormatter)", for: .normal)
        ScheduleButton.setTitleColor(.black, for: .normal)
        
        
        Calendar.isHidden = !Calendar.isHidden
        AccountButton.isHidden = !AccountButton.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
        noteTextfield.isHidden = !noteTextfield.isHidden
        
    }
}


extension AddDetailView:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

              let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.groupingSeparator = "."
                formatter.locale = Locale.current
                formatter.maximumFractionDigits = 0
               // Uses the grouping separator corresponding to your Locale
               // e.g. "," in the US, a space in France, and so on
        if textField.text!.count < 19{
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
