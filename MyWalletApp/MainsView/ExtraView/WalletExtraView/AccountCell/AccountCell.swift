//
//  AccountCell.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit

protocol AccountCellDelegate{
    func DetailAccount(cell:AccountCell)
}
class AccountCell: UITableViewCell {

    
    var delegate: AccountCellDelegate?
    lazy var Key = ""
    @IBOutlet var MainView:UIView!
    @IBOutlet var AccountLabel:UILabel!
    @IBOutlet var AccountImage:UIImageView!
    @IBOutlet var ValueLabel:UILabel!
    @IBOutlet var DetailButtonAccount:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ValueLabel.textColor = .gray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let Color = UIColor(hexString: "D1D1D6")
        if selected {
            MainView.backgroundColor =  Color
            AccountLabel.backgroundColor = Color
            ValueLabel.backgroundColor = Color
        } else {
            MainView.backgroundColor = UIColor.clear
            AccountLabel.backgroundColor = .clear
            ValueLabel.backgroundColor = .clear
        }
    }
    
    class func cellForTableView(tableView: UITableView) -> AccountCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "AccountCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! AccountCell
        return cell
    }
    
    @IBAction func DetailButtonAction() {
        delegate?.DetailAccount(cell: self)
        
    }
    
    
    
}
