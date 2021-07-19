//
//  FirstView.swift
//  MyWalletApp
//
//  Created by Tuan on 19/07/2021.
//

import UIKit

class FirstView: UIViewController,UITextFieldDelegate {

    let backGround: UIImageView = {
        let background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return background
    }()
    
    let MainView : UIView = {
        let mainView = UIView(frame: CGRect(x: 40, y: 100, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 200))
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 15.0
        return mainView
    }()
    
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
        textFld.withImage(direction: .Left, image: image!)
        textFld.frame = CGRect(x: 25, y: UIScreen.main.bounds.height*0.4, width: UIScreen.main.bounds.width - 50, height: 60)
        textFld.layer.borderWidth = 0.22
        textFld.layer.cornerRadius = 10.0
        
        return textFld
    }()
    
    
    let StartButton:UIButton = {
        let button = UIButton()
      //  let Image = UIImage(named: "Background")
        button.frame = CGRect(x: 25, y: UIScreen.main.bounds.height*0.5, width: UIScreen.main.bounds.width - 50, height: 60)
        button.setTitle("Let's Start!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "090F52")
     //   button.setBackgroundImage(Image, for: .normal)
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TextFld_Account.delegate = self
       // view.addSubview(backGround)
      //  view.addSubview(MainView)
        view.addSubview(TextFld_Account)
        view.addSubview(label)
        view.addSubview(StartButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

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

    
