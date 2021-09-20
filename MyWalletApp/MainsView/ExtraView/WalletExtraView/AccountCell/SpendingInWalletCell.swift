//
//  SpendingInWalletCell.swift
//  MyWalletApp
//
//  Created by Tuan on 18/09/2021.
//

import UIKit

class SpendingInWalletCell: UITableViewCell {

    @IBOutlet var ImageCategory:UIImageView!
    @IBOutlet var NoteLabel: UILabel!
    @IBOutlet var ValueLabel: UILabel!
    @IBOutlet var CategoryLabel : UILabel!
    @IBOutlet var Background : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let Color = UIColor(hexString: "D1D1D6")
        if selected {
            Background.backgroundColor =  Color
            NoteLabel.backgroundColor = Color
            ValueLabel.backgroundColor = Color
            CategoryLabel.backgroundColor = Color
        } else {
            Background.backgroundColor = UIColor.clear
             NoteLabel.backgroundColor = .clear
            ValueLabel.backgroundColor = .clear
            CategoryLabel.backgroundColor = .clear
        }
        // Configure the view for the selected state
    }
    
    class func cellForTableView(tableView: UITableView) -> SpendingInWalletCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "SpendingInWalletCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! SpendingInWalletCell
        return cell
    }
}
