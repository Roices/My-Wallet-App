//
//  AddDetailView.swift
//  MyWalletApp
//
//  Created by Tuan on 28/07/2021.
//

import UIKit

class AddDetailView: UIViewController {

    
    
    let backGround : UIImageView = {
        let Image = UIImageView(image: UIImage(named: "Background"))
        Image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Image
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
