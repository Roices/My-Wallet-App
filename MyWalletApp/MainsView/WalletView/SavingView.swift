//
//  SavingView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/08/2021.
//

import UIKit
import FSCalendar
import FirebaseDatabase


class SavingView: UIViewController, CAAnimationDelegate {

    
    let PeriodArray = ["2 week", "1 Month", "3 Months", "6 Months", "12 Month"]
    lazy var Key = ""
    
    let ScrollView : UIScrollView = {
        let ScrollView = UIScrollView()
        ScrollView.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
        return ScrollView
    }()
    
    let TitleLB : UILabel = {
        let label = UILabel()
        label.text = "Saving Plan"
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 - 100, y: 50, width: 200, height: 50)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = .white
       // label.backgroundColor = .yellow
        return label
    }()
    
    let background : UIImageView = {
        let background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return background
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
        view.backgroundColor = .white
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
    
    let valueTf : UITextField = {
        let Tf = UITextField()
        let imageUSD = UIImage(named: "USD")!
        Tf.frame = CGRect(x: 30, y: 0.1*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Value"
        Tf.withImage(direction: .Left, image: imageUSD)
        let label = UILabel()
        label.frame = CGRect(x: Tf.bounds.width - 60, y: 0.3*Tf.bounds.height, width: 45, height: 0.4*Tf.bounds.height)
        label.text = "VND"
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        Tf.addSubview(label)
        return Tf
    }()
    
    let NameAccountTf : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.2*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Your Account"
        let Image = UIImage(named: "NameAccount")
        Tf.withImage(direction: .Left, image: Image!)
        return Tf
    }()
    
    let DateButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(ShowUpCalendar), for: .touchUpInside)
        button.setTitle("------Date of dispatch------", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendar.frame = CGRect(x: 30, y: 0.375*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.215*UIScreen.main.bounds.height)
        calendar.layer.cornerRadius = 15.0
        calendar.layer.borderWidth = 0.5
        return calendar
    }()
    
    let periodTf : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.4*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Period"
        Tf.keyboardType = .numberPad
        let label = UILabel()
        label.frame = CGRect(x: Tf.bounds.width - 60, y: 0.3*Tf.bounds.height, width: 45, height: 0.4*Tf.bounds.height)
        label.text = "Month"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        let Image = UIImage(named: "Period")
        Tf.withImage(direction: .Left, image: Image!)
        Tf.addSubview(label)
       // Tf.withImage(direction: .Right, image: UIImage(named: "Month")!)
        return Tf
    }()
    
    
    let Bankrate : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.5*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Interest Rates"
        Tf.keyboardType = .decimalPad
        let Image = UIImage(named: "InterestRate")
        Tf.withImage(direction: .Left, image: Image!)
        let label = UILabel()
        label.frame = CGRect(x: Tf.bounds.width - 80, y: 0.3*Tf.bounds.height, width: 65, height: 0.4*Tf.bounds.height)
        label.text = "%/Month"
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        Tf.addSubview(label)
        return Tf
    }()
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.6*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
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

        view.addSubview(background)
        view.addSubview(MainView)
        view.addSubview(BackButton)
        view.addSubview(TitleLB)
        view.addSubview(ScrollView)
        ScrollView.addSubview(MainView)
        MainView.addSubview(valueTf)
        MainView.addSubview(NameAccountTf)
        MainView.addSubview(DateButton)
        MainView.addSubview(periodTf)
        MainView.addSubview(Bankrate)
        MainView.addSubview(DoneButton)
        MainView.addSubview(calendar)
        MainView.addSubview(WarningView)
        MainView.addSubview(WarningCompletelyView)
        
        valueTf.delegate = self
        periodTf.delegate = self
        Bankrate.delegate = self
   
        calendar.isHidden = true
        calendar.delegate = self
        calendar.dataSource = self
        // Do any additional setup after loading the view.
  
        WarningView.isHidden = true
        WarningCompletelyView.isHidden = true
       
        
        self.hideKeyboardWhenTappedAround()
        registerNotifications()
    }
    
}


extension SavingView:FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let DateFormatter = formatter.string(from: date)
        
        DateButton.setTitle("\(DateFormatter)", for: .normal)
        DateButton.setTitleColor(.black, for: .normal)
        
        calendar.isHidden = !calendar.isHidden
        periodTf.isHidden = !periodTf.isHidden
        Bankrate.isHidden = !Bankrate.isHidden
        
        
    }
}


extension SavingView: UITextFieldDelegate{
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
              let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.groupingSeparator = "."
                formatter.locale = Locale.current
                formatter.maximumFractionDigits = 0
               // Uses the grouping separator corresponding to your Locale
               // e.g. "," in the US, a space in France, and so on
        if textField == valueTf && textField.text!.count < 19{
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
        }else if textField == periodTf && textField.text!.count < 3{
                //textField.deleteBackward()
            return true
        }else if textField == Bankrate && textField.text!.count < 3{
            //textField.deleteBackward()
            return true
        }else{
            textField.deleteBackward()
        }
        return true
    }
    
}




extension SavingView{
    @objc func keyboardWillShow(notification: Notification) {
             guard let userInfo = notification.userInfo,
                   let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                     return
    }

     if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {

        ScrollView.frame.origin.y = -frame.height + 325

     }else{
         ScrollView.frame.origin.y = 150
     }
         }

     func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func ShowUpCalendar(sender: UIButton){
        calendar.isHidden = !calendar.isHidden
        periodTf.isHidden = !periodTf.isHidden
        Bankrate.isHidden = !Bankrate.isHidden
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
    
    @objc func Add(sender: UIButton){
        //check if value empty
        if valueTf.text == "" || NameAccountTf.text == "" || DateButton.titleLabel?.text == "------Date of dispatch------" || periodTf.text == "" || Bankrate.text == ""{
            //if empty push warning
            WarningView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningView.isHidden = true
            }
            return
        }else{
            
            if Bankrate.text?.IsANumber == false{
                Bankrate.text = "0"
            }
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("SavingPlan")

        // đẩy dữ liệu
        let val: [String : Any] = [
            "NameAccount": NameAccountTf.text as Any,
            "Value": valueTf.text as Any,
            "Date": DateButton.titleLabel?.text as Any,
            "Period": periodTf.text as Any,
            "Interest Rate": Bankrate.text as Any
        ]
            if Key.isEmpty{
            let newRef = ref.childByAutoId()
                newRef.setValue(val)
            }else{
                let newRef = ref.child(Key)
                newRef.setValue(val)
            }

            //push completely warning
            WarningCompletelyView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningCompletelyView.isHidden = true
            }
            
            //set UI to default
            valueTf.text = ""
            NameAccountTf.text = ""
            DateButton.setTitle("------Date of dispatch------", for: .normal)
            DateButton.setTitleColor(.lightGray, for: .normal)
            periodTf.text = ""
            Bankrate.text = ""
            Key = ""
    }

}
}
