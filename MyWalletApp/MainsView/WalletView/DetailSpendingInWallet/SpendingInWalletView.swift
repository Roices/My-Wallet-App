//
//  SpendingInWalletView.swift
//  MyWalletApp
//
//  Created by Tuan on 15/09/2021.
//

import UIKit
import MonthYearPicker
import FirebaseDatabase
 

class SpendingInWalletView: UIViewController, CAAnimationDelegate {

    lazy var SectionFortable = [TimeSectionData]()
    lazy var AccountChoiced = ""
    lazy var TimeSection:[String] = []
    lazy var TotalValue = ""
    lazy var Path = ""
    lazy var MonthChoiced = ""
    lazy var ColorForEachCategorySection : [String:UIColor] = [:]

    let backGround : UIImageView = {
        let backGround = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backGround.image = UIImage(named: "Background")
        return backGround
    }()
    
    var AccountTitleLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0.3*UIScreen.main.bounds.width, y: 50, width: 0.4*UIScreen.main.bounds.width, height: 50)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120)
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
        button.layer.borderWidth = 0.2
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
        label.layer.borderWidth = 0.2
        return label
    }()
    
    let ExpenseIncomeView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.175*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.075*UIScreen.main.bounds.height)
        view.layer.borderWidth = 0.2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let LabelTotalValueExpense : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
        //label.text = "Total Spending:"
        return label
    }()

    let LabelTotalValueIncome : UILabel = {
        let label = UILabel()
        //label.text = "Total InCome3135:"
        label.textColor = .green
        label.textAlignment = .center
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
        picker.layer.borderWidth = 0.25
        return picker
    }()
    
    let tableData : UITableView = {
       let table = UITableView()
        table.frame = CGRect(x: 0, y: 0.25*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .purple
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(BackButton)
        view.addSubview(AccountTitleLabel)
        MainView.addSubview(ButtonHiddenPickerView)
        MainView.addSubview(ButtonTime)
        MainView.addSubview(LineView)
        MainView.addSubview(totalValueLabel)
        //MainView.addSubview(ExpenseIncomeView)
        MainView.addSubview(tableData)
        MainView.addSubview(picker)
        
        picker.isHidden = true
        tableData.delegate = self
        tableData.dataSource = self
        
        TotalValue = UserDefaults.standard.string(forKey: "\(Path)")!
        totalValueLabel.text = "Total: " + "\(TotalValue)đ"
        ConfigureDataForTable()
       // addConstraints()
        
        let LabelIncome = UILabel()
        LabelIncome.frame = CGRect(x: 0, y: 0.2*ExpenseIncomeView.frame.height, width: ExpenseIncomeView.frame.width/2 - 0.5, height: 0.25*ExpenseIncomeView.frame.height)
        LabelIncome.text = "Total Income: "
        LabelIncome.textAlignment = .center
        ExpenseIncomeView.addSubview(LabelIncome)
        
 
        LabelTotalValueIncome.frame = CGRect(x: 0, y: 0.6*ExpenseIncomeView.frame.height, width: ExpenseIncomeView.frame.width/2 - 0.5, height: 0.2*ExpenseIncomeView.frame.height)
        ExpenseIncomeView.addSubview(LabelTotalValueIncome)
        
        
        let LabelExpense = UILabel()
        LabelExpense.frame = CGRect(x: ExpenseIncomeView.frame.width/2 + 0.5, y: 0.2*ExpenseIncomeView.frame.height, width: ExpenseIncomeView.frame.width/2 - 0.5, height: 0.25*ExpenseIncomeView.frame.height)
        LabelExpense.text = "Total Spending: "
        LabelExpense.textAlignment = .center
        LabelExpense.textColor = .black
        ExpenseIncomeView.addSubview(LabelExpense)
        
        
    
        LabelTotalValueExpense.frame = CGRect(x: ExpenseIncomeView.frame.width/2 + 0.5, y: 0.6*ExpenseIncomeView.frame.height, width: ExpenseIncomeView.frame.width/2 - 0.5, height: 0.2*ExpenseIncomeView.frame.height)
        ExpenseIncomeView.addSubview(LabelTotalValueExpense)
        
        let Line = UIView()
        Line.frame = CGRect(x: ExpenseIncomeView.frame.width/2 - 0.5, y: 0.05*ExpenseIncomeView.frame.height, width: 1, height: 0.9*ExpenseIncomeView.frame.height)
        Line.backgroundColor = .lightGray
        ExpenseIncomeView.addSubview(Line)
        
        
        let color1 = UIColor(hexString: "FF6E2E")
        let color2 = UIColor(hexString: "00B358")
        let color3 = UIColor(hexString: "137FEC")
        let color4 = UIColor.red
        let color5 = UIColor.purple
        let color6 = UIColor.gray
        let color7 = UIColor(hexString: "945200")
        let color8 = UIColor(hexString: "FF40FF")
        let color9 = UIColor(hexString: "941751")
        let color10 = UIColor(hexString: "76D6FF")
        let color11 = UIColor(hexString: "AA7942")
        let color12 = UIColor(hexString: "FF2F92")
        self.ColorForEachCategorySection = ["Children": color1,
                                    "Service": color12,
                                    "Study": color3,
                                    "Health": color4,
                                    "Food": color5,
                                    "Vehicles": color6,
                                    "House": color7,
                                    "Gift": color8,
                                    "Bank": color9,
                                    "Entertain": color10,
                                    "Loan": color11,
                                    "Income": color2]

        
        MainView.addSubview(ExpenseIncomeView)
        addConstraints()
        
    }
    
    func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        
       constraints.append(tableData.leadingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.leadingAnchor))
       constraints.append(tableData.trailingAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.trailingAnchor))
       constraints.append(tableData.bottomAnchor.constraint(equalTo: MainView.safeAreaLayoutGuide.bottomAnchor,constant: 0))
       constraints.append(tableData.topAnchor.constraint(equalTo: ExpenseIncomeView.safeAreaLayoutGuide.bottomAnchor,constant: 0.5))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    @objc func dateChanged(sender: MonthYearPickerView){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-YYYY"
        let DateFormatter = formatter.string(from: picker.date)
        ButtonTime.setTitle("\(DateFormatter)", for: .normal)
        ConfigureDataForTable()
    }
    
    @objc func DateChosing(sender: UIButton){
        picker.isHidden = !picker.isHidden
        tableData.isHidden = !tableData.isHidden
        totalValueLabel.isHidden = !totalValueLabel.isHidden
        ExpenseIncomeView.isHidden = !ExpenseIncomeView.isHidden
    //    LabelTotalValueIncome.isHidden = !LabelTotalValueIncome.isHidden
        
        
    }
    
    @objc func HidingPickerView(sender: UIButton){
        picker.isHidden = !picker.isHidden
        tableData.isHidden = !tableData.isHidden
        totalValueLabel.isHidden = !totalValueLabel.isHidden
        ExpenseIncomeView.isHidden = !ExpenseIncomeView.isHidden
    }
    
    func CalculateAmount(_ Value: String) ->Double{
        var string = Value
        var amount:Double = 0
        let occurrencies = string.filter { $0 == "." }.count
        for index in 0...occurrencies{
            
            if let lastIndex = string.lastIndex(of: "."){
            let last = string.endIndex
                var subString2 = string[lastIndex..<last]
                string = string.replacingOccurrences(of: subString2, with: "", range: lastIndex..<last)
                subString2.remove(at: subString2.startIndex)
                
                amount += Double(subString2)! * pow(1000, Double(index))
                
            }else{
                amount += Double(string)! * pow(1000, Double(index))
            }
        }
        return amount
    }

    func ConfigureDataForTable(){
        var TotalValue = 0.0
        var ValueIncome = 0.0
        var DataBase = [DATA]()
        let MonthSection = (ButtonTime.titleLabel?.text)!
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("\(MonthSection)").child(Path)
        
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
            SectionFortable = []
            self.TimeSection = []
            ValueIncome = 0.0
            TotalValue = 0.0
            for children in snapshot.children {
                DataBase = []
                
                if let postSnapshot = children as? DataSnapshot {
                    let key = postSnapshot.key
             if let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Note = postSnapshot.childSnapshot(forPath: "Note").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String,
                let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String,
                let Account = postSnapshot.childSnapshot(forPath: "Account").value as? String,
                let Detail = postSnapshot.childSnapshot(forPath: "Detail").value as? String{
                Path = Account
                print("Path1234: \(Path)")
                let Data = DATA(Category: Category, Note: Note, Value: Value, Key: key, Date: Date,Account: Account,Detail: Detail)
                if TimeSection.contains(Date){
                    for index in 0..<SectionFortable.count{
                        if SectionFortable[index].Time == Date{
                            SectionFortable[index].Database.append(Data)
                       }
                    }
                }else{
                    TimeSection.append(Date)
                    DataBase.append(Data)
                    let Section = TimeSectionData(Time: Date, Database: DataBase)
                    SectionFortable.append(Section)
                    AccountTitleLabel.text = Path
                }
                //TotalValue += Int(CalculateAmount(Value))
                if Category == "Income"{
                    ValueIncome += (CalculateAmount(Value))
                    print("ValueINC: \(ValueIncome)")
                }else{
                    TotalValue += (CalculateAmount(Value))
                }
              }
            }
          }
          // cập nhật ui
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            let ValueIncomeforAccount = formatter.string(from: ValueIncome as NSNumber)
            let ValueExpenseforAccount = formatter.string(from: TotalValue as NSNumber)
            LabelTotalValueIncome.text = ValueIncomeforAccount
            LabelTotalValueExpense.text = ValueExpenseforAccount
                self.tableData.reloadData()
            
        })
    }
}


extension SpendingInWalletView:UITableViewDelegate,UITableViewDataSource{
//
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionFortable.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SectionFortable[section].Database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = SpendingInWalletCell.cellForTableView(tableView: tableData)
            let Data = SectionFortable[indexPath.section].Database[indexPath.row]
            cell.CategoryLabel.text = Data.Detail
            cell.NoteLabel.text = "Note: " + Data.Note
            cell.ValueLabel.text = Data.Value
        cell.ImageCategory.backgroundColor = ColorForEachCategorySection[Data.Category]
        cell.ImageCategory.image = UIImage(named: "\(Data.Category)")
        if SectionFortable[indexPath.section].Database[indexPath.row].Category == "Income"{
            cell.ValueLabel.textColor = .green
        }else{
            cell.ValueLabel.textColor = .red
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MapView = self.storyboard?.instantiateViewController(withIdentifier: "SaveAndDeleteView") as! SaveAndDeleteView
        let Data = SectionFortable[indexPath.section].Database[indexPath.row]
        MapView.MoneyInput.text = Data.Value
        MapView.ButtonList.setTitle(Data.Detail, for: .normal)
        MapView.ButtonList.setTitleColor(.black, for: .normal)
        MapView.ScheduleButton.setTitle(Data.Date, for: .normal)
        MapView.ScheduleButton.setTitleColor(.black, for: .normal)
        MapView.noteTextfield.text = Data.Note
        MapView.AccountButton.setTitle(Data.Account, for: .normal)
        MapView.AccountButton.setTitleColor(.black, for: .normal)
        MapView.key = Data.Key
        let MonthSection = (ButtonTime.titleLabel?.text)!
        MapView.Time = MonthSection
        MapView.TimeDeleted = MonthSection
        MapView.AccountChoiced = Data.Account
        MapView.CategorySection = Data.Category
        MapView.ValueTf = Data.Value
        MapView.Datebt = Data.Date
        MapView.NoteTf = Data.Note
        MapView.Detail = Data.Detail
        self.navigationController?.pushViewController(MapView, animated: true)
    }
}


struct TimeSectionData{
    var Time : String
    var Database : [DATA]
}

struct DATA{
    var Category : String
    var Note : String
    var Value : String
    var Key : String
    var Date : String
    var Account : String
    var Detail : String
}

