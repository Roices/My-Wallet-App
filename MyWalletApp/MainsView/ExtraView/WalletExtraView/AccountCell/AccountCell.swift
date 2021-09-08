//
//  AccountCell.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit

protocol AccountCellDelegate{
    func Detail(cell:AccountCell)
}
class AccountCell: UITableViewCell {

    var delegate: AccountCellDelegate?
    @IBOutlet var AccountLabel:UILabel!
    @IBOutlet var AccountImage:UIImageView!
    @IBOutlet var ValueLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellForTableView(tableView: UITableView) -> AccountCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "AccountCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! AccountCell
        return cell
    }
    
    @IBAction func DetailButton(_ sender: Any) {
        delegate?.Detail(cell: self)
    }
    
    
}
