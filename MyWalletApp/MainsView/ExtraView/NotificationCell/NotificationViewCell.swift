//
//  NotificationViewCell.swift
//  MyWalletApp
//
//  Created by Tuan on 29/11/2021.
//

import UIKit

class NotificationViewCell: UITableViewCell {

    @IBOutlet var NotiLabel : UILabel!
    @IBOutlet var DateLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // DateLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        NotiLabel.lineBreakMode = .byWordWrapping
        NotiLabel.numberOfLines = 2
        NotiLabel.sizeToFit()
        // Configure the view for the selected state
    }
    class func cellForTableView(tableView: UITableView) -> NotificationViewCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "NotificationViewCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! NotificationViewCell
        return cell
    }
}
