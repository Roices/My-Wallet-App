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

class AccumulationView: UIViewController {

    
    let PeriodArray = ["1 Month","2 Months", "3 Months", "6 Months", "9 Months", "12 Months"]
    
    
    
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
        tf.withImage(direction: .Left, image: imageUSD)
        tf.withImage(direction: .Right, image: imageVND)
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
    
    let ListOfEndDate : UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 30, y: 0.475*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.2*UIScreen.main.bounds.height)
        tableView.layer.cornerRadius = 15.0
        tableView.layer.borderWidth = 0.5
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
        Mainview.addSubview(ListOfEndDate)
        
        Calendar.isHidden = true
        Calendar.delegate = self
        Calendar.dataSource = self
        
        
        ListOfEndDate.isHidden = true
        ListOfEndDate.delegate = self
        ListOfEndDate.dataSource = self
        
    }
    
    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
     self.navigationController?.pushViewController(mapView, animated: true)
    }
    

    @objc func StartedDate(sender : UIButton){
        Calendar.isHidden = !Calendar.isHidden
        ExpirationDate.isHidden = !ExpirationDate.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
    }
    
    @objc func ShowUpPeriod(sender: UIButton){
        ListOfEndDate.isHidden = !ListOfEndDate.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
    }

    @objc func Add(sender: UIButton){
        let path = UserDefaults.standard.string(forKey: "Username")
//        let path = "tuan dep trai"
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("Accumulation")

        // tạo ref đến dữ liệu mới
    //   let newRef = ref.child("Account")
        let newRef = ref.child("\(String(describing: NoteTf.text!))")

        // đẩy dữ liệu
        let val: [String : Any] = [
            "Value": ValueTf.text as Any,
            "Goal": NoteTf.text as Any,
            "Date": DateButton.titleLabel?.text as Any,
            "ExpirationDate": ExpirationDate.titleLabel!.text as Any
        ]
        
        newRef.setValue(val)
    }
}


extension AccumulationView: FSCalendarDelegate,FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
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
        ListOfEndDate.isHidden = !ListOfEndDate.isHidden
        DoneButton.isHidden = !DoneButton.isHidden
    }
}
