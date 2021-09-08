//
//  SavingPlanCell.swift
//  MyWalletApp
//
//  Created by Tuan on 07/09/2021.
//

import UIKit

protocol SavingPlanCellDelegate {
    func Detail(cell: SavingPlanCell)
}
class SavingPlanCell: UITableViewCell {

    var delegate:SavingPlanCellDelegate?
    @IBOutlet var ImageSavingPlan:UIImageView!
    @IBOutlet var SavingPlanLabel:UILabel!
    @IBOutlet var ValueLabel:UILabel!
    @IBOutlet var DateLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellForTableView(tableView: UITableView) -> SavingPlanCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "SavingPlanCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! SavingPlanCell
        return cell
    }
    
    @IBAction func DetailSavingPlan(_ sender: Any) {
        delegate?.Detail(cell: self)
    }
}
