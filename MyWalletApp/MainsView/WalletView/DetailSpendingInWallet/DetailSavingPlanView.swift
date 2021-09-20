//
//  DetailSavingPlanView.swift
//  MyWalletApp
//
//  Created by Tuan on 20/09/2021.
//

import UIKit

class DetailSavingPlanView: UIViewController {

    lazy var textTest = ""
     
    let backGround : UIImageView = {
        let backGround = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backGround.image = UIImage(named: "Background")
        return backGround
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    let LabelValueStart : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: 0, width: 0.3*UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        label.text = "Initial balance"
        return label
    }()
    
    let LabelValueEnd : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0.4*UIScreen.main.bounds.width - 25, y: 0, width: 0.6*UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        label.text = "5.000.000đ"
        label.textAlignment = .right
     //   label.backgroundColor = .yellow
        return label
    }()
    
    let LineView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0.08*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.01*UIScreen.main.bounds.height))
        view.backgroundColor =  UIColor(hexString: "D6D6D6")
        return view
    }()
    
    let TimeView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.09*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        view.layer.borderWidth = 0.2
        
        let ImageView = UIImageView(frame: CGRect(x: 20, y: 0.25*view.bounds.height, width: 0.5*view.bounds.height, height: 0.5*view.bounds.height))
        ImageView.image = UIImage(named: "Period")
        ImageView.contentMode = .scaleAspectFit
        
        let label = UILabel(frame: CGRect(x: 0.5*view.bounds.height + 35, y: 0.15*view.bounds.height, width: 200, height: 0.3*view.bounds.height))
        label.text = "Started"
        label.textColor = UIColor(hexString: "D6D6D6")
        
        let Datelabel = UILabel(frame: CGRect(x: 0.5*view.bounds.height + 35, y: 0.55*view.bounds.height, width: 200, height: 0.3*view.bounds.height))
        Datelabel.text = "20-10-2021"
        Datelabel.textColor = .black
        
        view.addSubview(ImageView)
        view.addSubview(label)
        view.addSubview(Datelabel)
        return view
    }()
    
    let PeriodView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.09*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        view.layer.borderWidth = 0.2
       // view.backgroundColor = .yellow
        return view
    }()
    
    let ProfitView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.09*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        view.layer.borderWidth = 0.2
       // view.backgroundColor = .yellow
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        view.addSubview(backGround)
        view.addSubview(MainView)
        MainView.addSubview(LabelValueEnd)
        MainView.addSubview(LabelValueStart)
        MainView.addSubview(LineView)
        MainView.addSubview(TimeView)
        
        
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
