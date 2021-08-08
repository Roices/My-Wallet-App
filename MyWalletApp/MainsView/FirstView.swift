//
//  FirstView.swift
//  MyWalletApp
//
//  Created by Tuan on 19/07/2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class FirstView: UIViewController,UITextFieldDelegate {
    
    let label:UILabel = {
        let label = UILabel()
        label.text = "CREAT A WALLET"
        label.frame = CGRect(x: 0, y: UIScreen.main.bounds.height*0.3, width: UIScreen.main.bounds.width, height: 50)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26.0)
        return label
    }()
    
    
    var TextFld_Account:UITextField = {
        let textFld = UITextField()
        let image = UIImage(named: "USD")
        let VND = UIImage(named: "VND")
        textFld.withImage(direction: .Right, image: VND!)
        textFld.withImage(direction: .Left, image: image!)
        textFld.frame = CGRect(x: 25, y: UIScreen.main.bounds.height*0.4, width: UIScreen.main.bounds.width - 50, height: 60)
        textFld.layer.borderWidth = 0.22
        textFld.layer.cornerRadius = 10.0
        textFld.keyboardType = .numberPad
        
        return textFld
    }()
    
    
    let StartButton:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 25, y: UIScreen.main.bounds.height*0.5, width: UIScreen.main.bounds.width - 50, height: 60)
        button.setTitle("Let's Start!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "090F52")
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.addTarget(self, action: #selector(Start), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TextFld_Account.delegate = self
      
        view.addSubview(TextFld_Account)
        view.addSubview(label)
        view.addSubview(StartButton)
        // Do any additional setup after loading the view.
    }

}

    

extension FirstView{
    
    @objc func Start(sender: UIButton){
        self.view.endEditing(true)
        
        if TextFld_Account.text == ""{
            let alert = UIAlertController(title: "", message: "You need to enter an amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            // Go to SecondView
            let mapView = (self.storyboard?.instantiateViewController(identifier: "MainsView"))! as UITabBarController
            self.navigationController?.pushViewController(mapView, animated: true)
        }
        
        guard let Value = self.TextFld_Account.text
        else {
          return
        }

        // tạo ref tới dữ liệu cha
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!)

        // tạo ref đến dữ liệu mới
       let newRef = ref.child("Account")

        // tạo value cho dữ liệu mới
        let val: [String : Any] = [
          "Cash": Value
        ]

        // đẩy dữ liệu
       newRef.setValue(val)
      //  ref.setValue(val)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
              let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.locale = Locale.current
                formatter.maximumFractionDigits = 0
               // Uses the grouping separator corresponding to your Locale
               // e.g. "," in the US, a space in France, and so on
               if let groupingSeparator = formatter.groupingSeparator {

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
               return true
           }


}
