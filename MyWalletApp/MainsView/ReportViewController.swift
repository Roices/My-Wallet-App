//
//  ReportViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit
import Charts

class ReportViewController: UIViewController {

    
    let Background : UIImageView = {
        let Background = UIImageView(image: UIImage(named: "Background"))
        Background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Background
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(Background)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
