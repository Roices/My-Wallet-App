//
//  AddDetailView.swift
//  MyWalletApp
//
//  Created by Tuan on 28/07/2021.
//

import UIKit

class AddDetailView: UIViewController{

    lazy var SelectedArray : String = ""
    let Category: [String : [String]] = ["Children":["Tuition","Books","Toy","Pocket money"],
                                    "Service":["Electric","Water","Internet","Gas","Mobile","Television"],
                                    "Study":["Tuition","Relationship"],
                                    "Health":["Medication","Sport","Medical examination"],
                                    "Food":["Dining out","Cafe","Supermarket","Dinner","Lunch","Breakfast"],
                                    "Vehicles":["Gas", "Insurance", "Parking", "Car wash", "Maintenance", "Taxi"],
                                    "House":["Furniture","Fixing","Rent"],
                                    "Gift":["Wedding","Visit"],
                                    "Bank":["Transfer fee"],
                                    "Entertain":["Travel","Cosmetics","Game","Cinema"]]
    
    let backGround : UIImageView = {
        let Image = UIImageView(image: UIImage(named: "Background"))
        Image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Image
    }()
    
    
    let MainView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = .white
        return view
    }()
    
    
    let ListDetail : UITableView = {
        let tableview = UITableView()
        tableview.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height + 70, width: UIScreen.main.bounds.width - 60, height: 200)
        tableview.layer.borderWidth = 0.25
        tableview.layer.cornerRadius = 15.0
        tableview.backgroundColor = .purple
        return tableview
    }()
    
    let MoneyInput : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.2*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
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
        let down = UIImage(named: "Down")
        let QuestionMark = UIImage(named: "MarkQuestion")
        button.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.setImages(right: QuestionMark, left: down)
      //  button.setImages(direction: .left, image: QuestionMark!)
        button.addTarget(self, action: #selector(HidingTable), for: .touchUpInside)
        return button
    }()
    
    let noteTextfield : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.4*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        Tf.layer.borderWidth = 0.5
        Tf.layer.cornerRadius = 15.0
        Tf.placeholder = "Note"
        let image = UIImage(named: "Note")
        Tf.withImage(direction: .Left, image: image!)
        
        return Tf
    }()
    

    
    let ScheduleButton : UIButton  = {
        let button = UIButton()
        let image = UIImage(named: "Schedule")
        button.frame = CGRect(x: 30, y: 0.5*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.setImages(right: nil, left: image)
        return button
    }()
    
    
    let AccountButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.6*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        return button
    }()
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.7*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.backgroundColor = UIColor(hexString: "090F52")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(MainView)
        view.addSubview(ListDetail)
        view.addSubview(MoneyInput)
        view.addSubview(ButtonList)
        view.addSubview(noteTextfield)
        view.addSubview(ScheduleButton)
        view.addSubview(AccountButton)
        view.addSubview(DoneButton)
        
        

        ListDetail.isHidden = true
        ListDetail.delegate = self
        ListDetail.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc  func HidingTable(_ sender: UIButton){
        ListDetail.isHidden = !ListDetail.isHidden
        noteTextfield.isHidden = !noteTextfield.isHidden
        ScheduleButton.isHidden = !ScheduleButton.isHidden

    }
}


extension AddDetailView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category["\(SelectedArray)"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = Category["\(SelectedArray)"]![indexPath.row]
       // let cell = UITableViewCell()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ListDetail.isHidden = !ListDetail.isHidden
        noteTextfield.isHidden = !noteTextfield.isHidden
        ScheduleButton.isHidden = !ScheduleButton.isHidden
    }
}




