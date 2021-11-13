//
//  AllAssetsCell.swift
//  MyWalletApp
//
//  Created by Tuan on 17/07/2021.
//

import UIKit

class AllAssetsCell: UITableViewCell {

    
    @IBOutlet var IconImage:UIImageView!
    @IBOutlet var CategoryLabel:UILabel!
    @IBOutlet var Value: UILabel!
    @IBOutlet var ProgressValue : UIProgressView!
    @IBOutlet var ValuePercent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        IconImage.layer.cornerRadius = 5.0
        IconImage.layer.borderWidth = 0.3
       // IconImage.backgroundColor = .green
      //  IconImage.contentMode = .scaleAspectFit
       // IconImage.image = UIImage(named: "Service")
        // Configure the view for the selected state
    }
    class func cellForTableView(tableView: UITableView) -> AllAssetsCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "AllAssetsCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! AllAssetsCell
        return cell
    }
}
