//
//  SpendingCell.swift
//  MyWalletApp
//
//  Created by Tuan on 21/07/2021.
//

import UIKit

class SpendingCell: UITableViewCell {

    @IBOutlet var ImageView : UIImageView!
    @IBOutlet var DetailLabel: UILabel!
    @IBOutlet var NoteLabel: UILabel!
    @IBOutlet var AccountLabel: UILabel!
    @IBOutlet var ValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellForTableView(tableView: UITableView) -> SpendingCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "SpendingCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! SpendingCell
        return cell
    }
    
}
