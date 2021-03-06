//
//  AccumulationView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/08/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FSCalendar

class AccumulationView: UIViewController,UITextFieldDelegate, CAAnimationDelegate {

    
    let PeriodArray = ["1 Month","2 Months", "3 Months", "6 Months", "9 Months", "12 Months"]
    lazy var Key = ""
    lazy var State = ""
    lazy var Value = ""
    lazy var ValueCompleted = ""
    let transparentView = UIView()
    
    let Background : UIImageView = {
        let background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return background
    }()
    
    let TitleLB : UILabel = {
        let label = UILabel()
        label.text = "Accumulation Plan"
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 - 100, y: 50, width: 200, height: 50)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = .white
       // label.backgroundColor = .yellow
        return label
    }()
    let Mainview : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = 15.0
        View.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-150)
        return View
    }()
    
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(BacktoWallet), for: .touchUpInside)
        return button
    }()
    
    let ValueTf : UITextField = {
        let tf = UITextField()
        let imageUSD = UIImage(named: "USD")!
        let imageVND = UIImage(named: "VND")!
        tf.frame = CGRect(x: 30, y: 0.1*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        tf.layer.cornerRadius = 15.0
        tf.layer.borderWidth = 0.5
        tf.placeholder = "Value"
        tf.keyboardType = .numberPad
        tf.withImage(direction: .Left, image: imageUSD)
        tf.withImage(direction: .Right, image: imageVND)
      //  tf.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        return tf
    }()
    
    let NoteTf : UITextField = {
        let Tf = UITextField()
        let image = UIImage(named: "Note")
        Tf.frame = CGRect(x: 30, y: 0.2*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Goal"
        Tf.withImage(direction: .Left, image: image!)
     //   Tf.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        return Tf
    }()
     
    let DateButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(StartedDate), for: .touchUpInside)
        button.setTitle("------Date of dispatch------", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let Calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 30, y: 0.375*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.3 * UIScreen.main.bounds.height)
        calendar.layer.borderWidth = 0.5
        calendar.layer.cornerRadius = 15.0
        return calendar
    }()
  
    let ExpirationDate : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.4*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(ShowUpPeriod), for: .touchUpInside)
        button.setTitle("------How long?------", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let ListOfEndDateTable : UITableView = {
        let tableView = UITableView()
      //  tableView.frame = CGRect(x: 30, y: 0.475*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.2*UIScreen.main.bounds.height)
//        tableView.layer.cornerRadius = 15.0
//        tableView.layer.borderWidth = 0.5
        return tableView
    }()
    
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.5*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor(hexString: "090F52")
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(Add), for: .touchUpInside)
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
        view.addSubview(Background)
        view.addSubview(Mainview)
        view.addSubview(BackButton)
        view.addSubview(TitleLB)
        Mainview.addSubview(ValueTf)
        Mainview.addSubview(NoteTf)
        Mainview.addSubview(DateButton)
        Mainview.addSubview(ExpirationDate)
        Mainview.addSubview(DoneButton)
        Mainview.addSubview(Calendar)
      //  Mainview.addSubview(ListOfEndDate)
        Mainview.addSubview(WarningView)
        Mainview.addSubview(WarningCompletelyView)
        
        WarningView.isHidden = true
        WarningCompletelyView.isHidden = true
        
        Calendar.isHidden = true
        Calendar.delegate = self
        Calendar.dataSource = self
        
        
       // ListOfEndDate.isHidden = true
        ListOfEndDateTable.delegate = self
        ListOfEndDateTable.dataSource = self
        
        hideKeyboardWhenTappedAround()
        ValueTf.delegate = self

        
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
    
    @objc func StartedDate(sender : UIButton){
        Calendar.isHidden = !Calendar.isHidden
        ExpirationDate.isHidden = !ExpirationDate.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
     }
    
    @objc func ShowUpPeriod(sender: UIButton){
//        ListOfEndDate.isHidden = !ListOfEndDate.isHidden
//        DoneButton.isHidden = !DoneButton.isHidden
        addTransparentView(frames: ExpirationDate.frame)
    }

    @objc func Add(sender: UIButton){
        //Check if empty value
        if ValueTf.text == "" || NoteTf.text == "" || DateButton.titleLabel?.text == "------Date of dispatch------" || ExpirationDate.titleLabel?.text == "------How long?------"{
            //push warning
            WarningView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningView.isHidden = true
            }
            return
            
        }else{
        
        //creat a path for data
        let path = UserDefaults.standard.string(forKey: "Username")
//        let path = "tuan dep trai"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("Accumulation")

        // Data
        let val: [String : Any] = [
            "Value": ValueTf.text as Any,
            "Target": NoteTf.text as Any,
            "Date": DateButton.titleLabel?.text as Any,
            "ExpirationDate": ExpirationDate.titleLabel!.text as Any,
            "ValueCompleted": "0"
        ]
        
            if Key.isEmpty{
                let newRef = ref.childByAutoId()
                newRef.setValue(val)
            }else{
                let newRef = ref.child(Key)
                if State == "Edit"{
                    let val: [String : Any] = [
                        "Value": ValueTf.text as Any,
                        "Target": NoteTf.text as Any,
                        "Date": DateButton.titleLabel?.text as Any,
                        "ExpirationDate": ExpirationDate.titleLabel!.text as Any,
                        "ValueCompleted": ValueCompleted
                    ]
                    newRef.setValue(val)
                }
                else if State == "SendMoney"{
                    if let ValueAdding = ValueTf.text{
                        let Amount = CalculateAmount(ValueCompleted) + CalculateAmount(ValueAdding)
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        formatter.groupingSeparator = "."
                        let AmountAdding = formatter.string(from: Amount as NSNumber)
                        let val: [String : Any] = [
                            "Value": Value as Any,
                            "Target": NoteTf.text as Any,
                            "Date": DateButton.titleLabel?.text as Any,
                            "ExpirationDate": ExpirationDate.titleLabel!.text as Any,
                            "ValueCompleted": AmountAdding as Any
                        ]
                        newRef.setValue(val)
                    }else{
                        return
                    }
                   
                }
            }
      
            //push completely warning
            WarningCompletelyView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningCompletelyView.isHidden = true
            }
            
            //set UI to default
            ValueTf.text = ""
            NoteTf.text = ""
            DateButton.setTitle("------Date of dispatch------", for: .normal)
            DateButton.setTitleColor(.lightGray, for: .normal)
            ExpirationDate.setTitle("------How long?------", for: .normal)
            ExpirationDate.setTitleColor(.lightGray, for: .normal)
            Key = ""
            State = ""
    }
  }
    
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
          
    
    func CalculateAmount(_ Value: String) ->Int{
        var string = Value
        var amount:Int = 0
        let occurrencies = string.filter { $0 == "." }.count
        for index in 0...occurrencies{
            if let lastIndex = string.lastIndex(of: "."){
            let last = string.endIndex
            var subString2 = string[lastIndex..<last]
                string = string.replacingOccurrences(of: subString2, with: "")
                subString2.remove(at: subString2.startIndex)
                amount += Int(Double(subString2)! * pow(1000, Double(index)))
            }else{
                amount += Int(Double(string)! * pow(1000, Double(index)))
            }
            
        }
        return amount
    }
    

    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.Mainview.addSubview(transparentView)
        
        ListOfEndDateTable.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.Mainview.addSubview(ListOfEndDateTable)
        ListOfEndDateTable.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        ListOfEndDateTable.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.ListOfEndDateTable.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0.2*UIScreen.main.bounds.height )
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = ExpirationDate.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.ListOfEndDateTable.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}


extension AccumulationView: FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        let DateFormatter = formatter.string(from: date)
        
        DateButton.setTitle("\(DateFormatter)", for: .normal)
        DateButton.setTitleColor(.black, for: .normal)
        Calendar.isHidden = !Calendar.isHidden
        ExpirationDate.isHidden = !ExpirationDate.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
    }
}


extension AccumulationView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PeriodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = PeriodArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ExpirationDate.setTitle(PeriodArray[indexPath.row], for: .normal)
        ExpirationDate.setTitleColor(.black, for: .normal)
        removeTransparentView()
    }
    
}



