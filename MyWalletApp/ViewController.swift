//
//  ViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 01/07/2021.
//

import UIKit
import FirebaseDatabase
import Firebase
import Charts

class ViewController: UIViewController, UITextFieldDelegate,ChartViewDelegate {

var pieChart = PieChartView()


    let ViewTo:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = 15.0
        View.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 150))
        return View
    }()
    let TestView:UIView = {
        let View = UIView()
       View.backgroundColor = .purple
        View.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 150)/2)

        return View
    }()

    
    let Segment:UISegmentedControl = {
        let Segment = UISegmentedControl()
        Segment.frame = CGRect(x: 0, y: 700, width: UIScreen.main.bounds.width, height: 70)
      //  Segment.backgroundColor = .white
        
     //   Segment.selectedSegmentTintColor = .white
        Segment.insertSegment(withTitle: "1", at: 0, animated: true)
        Segment.insertSegment(withTitle: "2", at: 1, animated: true)
        Segment.insertSegment(withTitle: "3", at: 2, animated: true)
        Segment.selectedSegmentIndex = 0
     //   Segment.addTarget(self, action: #selector(<#T##@objc method#>), for: <#T##UIControl.Event#>)
        return Segment
    }()

    let codeSegmented : CustomSegmentedControl = {
        let y = (UIScreen.main.bounds.height - 200)/2 + 250
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 50), buttonTitle: ["All Assets","Cash","Loan"])
        
        let color = UIColor(hexString: "797979")
        let colorForLine = UIColor(hexString: "C0C0C0")
        let blue = UIColor(hexString: "116AEE")
        
        codeSegmented.backgroundColor = .clear
        codeSegmented.textColor = color
        codeSegmented.selectorViewColor = blue
        codeSegmented.selectorTextColor = blue
        codeSegmented.LineViewColor = colorForLine
        return codeSegmented
    }()
    
    let AssetLabel:UILabel = {
        let Label = UILabel()
        Label.text = "ALL ASSETS"
//        Label.font = UIFont(name: "System Light", size: 14)
        Label.font = Label.font.withSize(13)
        Label.textColor = .darkGray
        let ScreenW = UIScreen.main.bounds.width
        let ScreenH = UIScreen.main.bounds.height
        Label.frame = CGRect(x: ScreenW/2 - 38, y: (150+(ScreenH - 150)/2)/2, width: 80, height: 50)
        return Label
    }()

    let MoneyLabel:UILabel = {
        let Label = UILabel()
        Label.text = "100.000.000đ"
//        Label.font = UIFont(name: "System-Bold", size: 15)
        Label.font = UIFont.boldSystemFont(ofSize: 17.0)
//        Label.textColor = .darkGray
        Label.textAlignment = .center
        let ScreenW = UIScreen.main.bounds.width
        let ScreenH = UIScreen.main.bounds.height
        Label.frame = CGRect(x: ScreenW/2 - 60, y: (150+(ScreenH - 150)/2)/2 + 22, width: 120, height: 55)
        return Label
    }()

    
    let TextFld : UITextField = {
        let textF = UITextField()
        textF.frame = CGRect(x: 20, y: 190, width: 200, height: 50)
        return textF
    }()


    let players = ["All Assets", "Loan", "Cash"]
    let goals = [66, 12 , 27]
    override func viewDidLoad() {
        super.viewDidLoad()

        pieChart.delegate = self

//        let path = "User"
//        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path)




    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

            }
    //


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.view.endEditing(true)
         return false
    }


    @IBOutlet var TF2:UITextField!
    @IBOutlet var TField: UITextField!


    @IBAction func Edittt(_ sender: Any) {
                let path2 = "User"
                let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path2)
                ref.observe(.value, with: { (snapshot) in
                  // cập nhật data
        
                  for children in snapshot.children {
                    if let postSnapshot = children as? DataSnapshot {
        //              let key = postSnapshot.key
                        if let Food = postSnapshot.childSnapshot(forPath: "TestA").value as? String{
                       print(children)
                      }
                    }
                  }
                })
    }

    @IBAction func Button(_ sender: Any) {
        guard let subject = self.TF2.text,
          let content = self.TField.text,
          let email = Auth.auth().currentUser?.email else {
          return
        }

        // tạo ref tới dữ liệu cha
        let path = "NewUser"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path)

        // tạo ref đến dữ liệu mới
        let newRef = ref.child("contentA")

        // tạo value cho dữ liệu mới
        let val: [String : Any] = [
          "contentA": content,
          "subjectA": subject,
            "sotietkiem1": content
        ]

        // đẩy dữ liệu
        newRef.setValue(val)
    }

}

