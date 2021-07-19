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
       View.backgroundColor = .white
        View.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 150)/2)

        return View
    }()


    let AssetLabel:UILabel = {
        let Label = UILabel()
        Label.text = "ALL ASSETS"
//        Label.font = UIFont(name: "System Light", size: 14)
        Label.font = Label.font.withSize(13)
        Label.textColor = .darkGray
        let ScreenW = UIScreen.main.bounds.width
        Label.frame = CGRect(x: ScreenW/2 - 38, y: UIScreen.main.bounds.height/4 - 70, width: 80, height: 50)
        return Label
    }()

    let MoneyLabel:UILabel = {
        let Label = UILabel()
        Label.text = "$1,000.00"
//        Label.font = UIFont(name: "System-Bold", size: 15)
        Label.font = UIFont.boldSystemFont(ofSize: 19.0)
//        Label.textColor = .darkGray

        let ScreenW = UIScreen.main.bounds.width
        Label.frame = CGRect(x: ScreenW/2 - 50, y: UIScreen.main.bounds.height/4 - 45, width: 100, height: 55)
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

//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillHideNotification, object: nil)



    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var dataEntries: [ChartDataEntry] = []
        let dataPoints = players
        let values = goals.map{ Double($0) }
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
        let color1 = UIColor(hexString: "FF6E2E")
        let color2 = UIColor(hexString: "00B358")
        let color3 = UIColor(hexString: "137FEC")
        let colors:[UIColor] = [color1,color2,color3]
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colors



          // 3. Set ChartData

        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let pFormatter = NumberFormatter()
            pFormatter.numberStyle = .percent
            pFormatter.maximumFractionDigits = 1
            pFormatter.multiplier = 1
            pFormatter.percentSymbol = "%"
            pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
            pieChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 12)!)
            pieChartData.setValueTextColor(.white)
            pieChartDataSet.sliceSpace = 3
            pieChart.data = pieChartData


          // 4. Assign it to the chart’s data

        let legend = pieChart.legend
//        legend.xEntrySpace = 80
               legend.horizontalAlignment = .center
//        legend.verticalAlignment  = .bottom
//        legend.orientation = .horizontal
        legend.font = UIFont.systemFont(ofSize: 14)


        legend.xEntrySpace = 170
//        legend.yOffset = 0
//        legend.xOffset = 0////
        pieChart.frame.size.width = 310 // 0.75 * UIScreen.main.bounds.width
        pieChart.frame.size.height =  310 //0.4 * UIScreen.main.bounds.height
      //  pieChart.center = TestView.center
        pieChart.holeRadiusPercent = 0.65
         pieChart.drawEntryLabelsEnabled = false



      //  pieChart.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
//     pieChart.transparentCircleRadiusPercent = 100
//
//
//       pieChart.center = view.center
//
        pieChart.chartDescription?.text = ""
//
//        TestView.addSubview(pieChart)
//        view.addSubview(label)
//        view.addSubview(label2)
//        view.addSubview(label3)
        view.addSubview(ViewTo)
     //   view.addSubview(TestView)
        pieChart.center = TestView.center
        AssetLabel.center = TestView.center
        MoneyLabel.center = TestView.center
        view.addSubview(pieChart)
        view.addSubview(AssetLabel)
        view.addSubview(MoneyLabel)
        ViewTo.addSubview(TextFld)
    }
    //


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.view.endEditing(true)
         return false
    }

//   @objc func keyboardWillShow(notification: Notification) {
//            guard let userInfo = notification.userInfo,
//                  let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//                    return
//            }
//    if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
//
//        ScrollView.frame.origin.y = -frame.height
//
//    }else{
//        ScrollView.frame.origin.y = 0
//    }
//        }


    @IBAction func Edittt(_ sender: Any) {
        let path = "Teen User"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
        ref.child(path).childByAutoId().setValue(["Food": "20000k"])
    }

    @IBAction func Button(_ sender: Any) {
//        guard let subject = self.TF2.text,
//          let content = self.TField.text,
//          let email = Auth.auth().currentUser?.email else {
//          return
//        }
//
//        // tạo ref tới dữ liệu cha
//        let path = "User"
//        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path)
//
//        // tạo ref đến dữ liệu mới
//        let newRef = ref.childByAutoId()
//
//        // tạo value cho dữ liệu mới
//        let val: [String : Any] = [
//          "contentA": content,
//          "subjectA": subject,
//          "ownerA": email,
//          "timestampA": Date().timeIntervalSince1970,
//            "testA": "ayxz",
//            "TestA": "Testt"
//        ]
//
//        // đẩy dữ liệu
//        newRef.setValue(val)

        let path2 = "Teen User"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path2)
        ref.observe(.value, with: { (snapshot) in
          // cập nhật data

          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
//              let key = postSnapshot.key
                if let Food = postSnapshot.childSnapshot(forPath: "Food").value as? String{
               print(Food)
              }
            }
          }
        })
    }

}

