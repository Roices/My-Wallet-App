//
//  AccumulationPlanCell.swift
//  MyWalletApp
//
//  Created by Tuan on 07/09/2021.
//

import UIKit

protocol AccumulationPlancellDelegate {
    func Detail(cell: AccumulationPlanCell)
}

class AccumulationPlanCell: UITableViewCell {

    var delegate: AccumulationPlancellDelegate?
    @IBOutlet var ImageOfAccumulation:UIImageView!
    @IBOutlet var TargetLabel:UILabel!
    @IBOutlet var ValueTarget:UILabel!
    @IBOutlet var ValueCompleted:UILabel!
    @IBOutlet var DetailButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellForTableView(tableView: UITableView) -> AccumulationPlanCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "AccumulationPlanCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! AccumulationPlanCell
        return cell
    }
    
    @IBAction func DetailAccumulationPlan(_ sender: Any) {
        delegate?.Detail(cell: self)
    }
}
