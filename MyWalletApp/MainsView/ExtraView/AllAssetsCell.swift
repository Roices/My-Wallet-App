//
//  AllAssetsCell.swift
//  MyWalletApp
//
//  Created by Tuan on 17/07/2021.
//

import UIKit

class AllAssetsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func cellForTableView(tableView: UITableView) -> AllAssetsCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "AllAssetsCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! AllAssetsCell
        return cell
    }
}
