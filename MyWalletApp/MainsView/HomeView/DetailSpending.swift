//
//  DetailSpending.swift
//  MyWalletApp
//
//  Created by Tuan on 21/07/2021.
//

import UIKit

class DetailSpending: UIViewController {

    
    let backGround:UIImageView = {
        let background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return background
    }()
    
    let tableDetail:UITableView = {
       let table = UITableView()
        table.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        table.layer.cornerRadius = 15.0
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableDetail.delegate = self
        tableDetail.dataSource = self
        view.addSubview(backGround)
        view.addSubview(tableDetail)
    }
}

extension DetailSpending: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SpendingCell.cellForTableView(tableView: tableDetail)
        return cell

//        let cell = UITableViewCell()
//               cell.textLabel?.text = filterData[indexPath.row]
//               return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
