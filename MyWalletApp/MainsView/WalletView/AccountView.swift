//
//  AccountView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/08/2021.
//

import UIKit
import FirebaseDatabase

class AccountView: UIViewController, CAAnimationDelegate {


    let TypeAccount = ["Cash","Banking","Credit card","e-Wallet"]
    lazy var AccountChoiced = ""
    lazy var Key = ""
    let transparentView = UIView()
    

   
  
    let backGround : UIImageView = {
        let backGround = UIImageView(image: UIImage(named: "Background"))
        backGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return backGround
    }()
    
    let MainView : UIView = {
        let MainView = UIView()
        MainView.backgroundColor = .white
        MainView.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
        MainView.layer.cornerRadius = 15.0
        return MainView
    }()
    
    let View : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        return view
    }()
    
    let TitleAccountLB : UILabel = {
        let label = UILabel()
        label.text = "Account"
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 - 50, y: 50, width: 100, height: 50)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(AccountView.BacktoWallet), for: .touchUpInside)
        return button
    }()
    
    let ValueTF: UITextField = {
        let tf = UITextField()
        tf.frame = CGRect(x: 30, y: 0.1 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        tf.layer.cornerRadius = 15.0
        tf.layer.borderWidth = 0.5
        tf.placeholder = "Value"
        let imageUSD = UIImage(named: "USD")!
        let imageVND = UIImage(named: "VND")!
        tf.withImage(direction: .Left, image: imageUSD)
        tf.withImage(direction: .Right, image: imageVND)
        return tf
    }()
    
    let NameAccountTf : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.2*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Name Account"
        let Image = UIImage(named: "NameAccount")
        Tf.withImage(direction: .Left, image: Image!)
        return Tf
    }()
    
    let TypeAccountBT : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.3 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(ChooseAccount), for: .touchUpInside)
        button.setTitle("------Type Account------", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    let ListAccount : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    @objc let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.4 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor(hexString: "090F52")
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

        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(TitleAccountLB)
        view.addSubview(BackButton)
        MainView.addSubview(ValueTF)
        MainView.addSubview(NameAccountTf)
        MainView.addSubview(TypeAccountBT)
        MainView.addSubview(DoneButton)
        MainView.addSubview(WarningView)
        MainView.addSubview(WarningCompletelyView)
        
        ValueTF.delegate = self
        
        WarningView.isHidden = true
        WarningCompletelyView.isHidden = true
        
        ListAccount.dataSource = self
        ListAccount.delegate = self
       
        self.hideKeyboardWhenTappedAround()
    }


}

//functions
extension AccountView{
    

    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
        mapView.UpdateDataforAccoutList()
     self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    
    
    @objc func Add(sender: UIButton){
        
        if ValueTF.text == "" || TypeAccountBT.titleLabel?.text == "------Type Account------" || NameAccountTf.text == ""{
            WarningView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningView.isHidden = true
            }
            return
        }else{
            
        let path = UserDefaults.standard.string(forKey: "Username")
//        let path = "tuan dep trai"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("Account")

            
            //Data
            let val: [String : Any] = [
                "Value": ValueTF.text as Any,
                "Name": NameAccountTf.text as Any,
                "TypeAccount": TypeAccountBT.titleLabel?.text as Any
            ]
           var ListAccountForHomeView = UserDefaults.standard.stringArray(forKey: "ListAccount")!

            //Push Data
            if Key.isEmpty{
                let newRef = ref.childByAutoId()
                newRef.setValue(val)
                ListAccountForHomeView.append(NameAccountTf.text!)
                
            }else{
                let newRef = ref.child(Key)
                newRef.setValue(val)
                ListAccountForHomeView =  ListAccountForHomeView.filter{$0 != NameAccountTf.text!}
                ListAccountForHomeView.append(NameAccountTf.text!)
            }
            
            //Push Notification
            WarningCompletelyView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.WarningCompletelyView.isHidden = true
            }
            
            //set UI to default
            ValueTF.text = ""
            TypeAccountBT.setTitle("------Type Account------", for: .normal)
            TypeAccountBT.setTitleColor(.lightGray, for: .normal)
            NameAccountTf.text = ""
            Key = ""
            UserDefaults.standard.stringArray(forKey: "ListAccount")
            print("ListAccountForHomeView: \(ListAccountForHomeView)")
            
            
        }
    }
    
    @objc func ChooseAccount(sender: UIButton){
        addTransparentView(frames: TypeAccountBT.frame)
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.MainView.addSubview(transparentView)
        
        ListAccount.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.MainView.addSubview(ListAccount)
        ListAccount.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        ListAccount.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.ListAccount.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.TypeAccount.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = TypeAccountBT.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.ListAccount.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
}

//ListAccountDelegate
extension AccountView : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return TypeAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = TypeAccount[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AccountChoiced = TypeAccount[indexPath.row]
        TypeAccountBT.setTitle(TypeAccount[indexPath.row], for: .normal)
        TypeAccountBT.setTitleColor(.black, for: .normal)
        removeTransparentView()
    }
}

extension AccountView:UITextFieldDelegate{
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
