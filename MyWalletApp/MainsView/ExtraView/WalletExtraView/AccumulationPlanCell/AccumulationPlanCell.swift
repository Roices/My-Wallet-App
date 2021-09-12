//
//  AccumulationPlanCell.swift
//  MyWalletApp
//
//  Created by Tuan on 07/09/2021.
//

import UIKit

protocol AccumulationPlancellDelegate {
    func DetailAccumulationPlan(cell: AccumulationPlanCell)
}

class AccumulationPlanCell: UITableViewCell {

    var delegate: AccumulationPlancellDelegate?
    lazy var key = ""
    @IBOutlet var MainView:UIView!
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
        
        let Color = UIColor(hexString: "D1D1D6")
        if selected {
            MainView.backgroundColor =  Color
            TargetLabel.backgroundColor = Color
            ValueTarget.backgroundColor = Color
            ValueCompleted.backgroundColor = Color
            DetailButton.backgroundColor = Color
        } else {
            MainView.backgroundColor = UIColor.clear
            TargetLabel.backgroundColor = .clear
            ValueTarget.backgroundColor = .clear
            ValueCompleted.backgroundColor = .clear
            DetailButton.backgroundColor = .clear
        }
    }
    
    class func cellForTableView(tableView: UITableView) -> AccumulationPlanCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "AccumulationPlanCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! AccumulationPlanCell
        return cell
    }
    
    @IBAction func DetailAccumulationAction() {
        delegate?.DetailAccumulationPlan(cell: self)
    }
}
