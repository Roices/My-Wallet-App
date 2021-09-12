//
//  SavingPlanCell.swift
//  MyWalletApp
//
//  Created by Tuan on 07/09/2021.
//

import UIKit

protocol SavingPlanCellDelegate {
    func DetailSavingPlan(cell: SavingPlanCell)
}
class SavingPlanCell: UITableViewCell {

    var delegate:SavingPlanCellDelegate?
    lazy var key = ""
    @IBOutlet var MainView:UIView!
    @IBOutlet var ImageSavingPlan:UIImageView!
    @IBOutlet var SavingPlanLabel:UILabel!
    @IBOutlet var ValueLabel:UILabel!
    @IBOutlet var DateLabel:UILabel!
    @IBOutlet var DetailButtonSaving:UIButton!
    
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
            SavingPlanLabel.backgroundColor = Color
            ValueLabel.backgroundColor = Color
            DateLabel.backgroundColor = Color
            DetailButtonSaving.backgroundColor = Color
        } else {
            MainView.backgroundColor = UIColor.clear
            SavingPlanLabel.backgroundColor = .clear
            ValueLabel.backgroundColor = .clear
            DateLabel.backgroundColor = .clear
            DetailButtonSaving.backgroundColor = .clear
        }
    }
    
    class func cellForTableView(tableView: UITableView) -> SavingPlanCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "SavingPlanCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! SavingPlanCell
        return cell
    }
    
    @IBAction func DetailSavingAction() {
        delegate?.DetailSavingPlan(cell: self)
    }
}
