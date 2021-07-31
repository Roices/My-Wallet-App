//
//  AddDetailView.swift
//  MyWalletApp
//
//  Created by Tuan on 28/07/2021.
//

import UIKit

class AddDetailView: UIViewController{

//    let ScreenH = UIScreen.main.bounds.height
//    let ScreenW = UIScreen.main.bounds.width
    
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
        tableview.frame = CGRect(x: 0, y: 240, width: UIScreen.main.bounds.width - 100, height: 150)
        tableview.layer.borderWidth = 0.25
        tableview.layer.cornerRadius = 15.0
        return tableview
    }()
    
    let MoneyInput : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.2*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        Tf.layer.borderWidth = 0.5
        Tf.layer.cornerRadius = 15.0
        
        return Tf
    }()
    
    let MoneyInputLabel : UILabel = {
        let label = UILabel()
        label.text = "Value"
        label.frame = CGRect(x: 50, y: 0.2*UIScreen.main.bounds.height - 10, width: 60, height: 20)
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    let ButtonList : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(HidingTable), for: .touchUpInside)
        return button
    }()
    
    let noteTextfield : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.4*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        Tf.layer.borderWidth = 0.5
        Tf.layer.cornerRadius = 15.0
        return Tf
    }()
    
    let noteLabel : UILabel = {
        let label = UILabel()
        label.text = "Note"
        label.frame = CGRect(x: 50, y: 0.4*UIScreen.main.bounds.height - 10, width: 60, height: 20)
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    let ScheduleButton : UIButton  = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.5*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 70)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15.0
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
       // view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(ListDetail)
        view.addSubview(MoneyInput)
        view.addSubview(MoneyInputLabel)
        view.addSubview(ButtonList)
        view.addSubview(noteTextfield)
        view.addSubview(noteLabel)
        view.addSubview(ScheduleButton)
        view.addSubview(AccountButton)
        view.addSubview(DoneButton)
       // view.addSubview(buttonTest)
        ListDetail.isHidden = true
        ListDetail.delegate = self
        ListDetail.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @objc  func HidingTable(_ sender: UIButton){
        ListDetail.isHidden = !ListDetail.isHidden

    }

 

}


extension AddDetailView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllAssetsCell.cellForTableView(tableView: ListDetail)
        return cell
    }
}
