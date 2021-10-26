//
//  DetailSavingPlanView.swift
//  MyWalletApp
//
//  Created by Tuan on 20/09/2021.
//

import UIKit

class DetailSavingPlanView: UIViewController, CAAnimationDelegate {

    lazy var textTest = ""
    lazy var Title = ""
    lazy var InitialBalanceValue = ""
    lazy var InitialTime = ""
    lazy var Period = ""
    lazy var ProfitRate = ""
     
    let AccountTitleLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0.3*UIScreen.main.bounds.width, y: 50, width: 0.4*UIScreen.main.bounds.width, height: 50)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
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
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 15, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(BacktoSavingPlan), for: .touchUpInside)
        return button
    }()
    
    let TitleLabelValueStart : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: 0, width: 0.3*UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        label.text = "Initial balance"
        return label
    }()
    
    let LabelValueStart : UILabel = {
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
        return view
    }()
    
    let PeriodView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.17*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        let LineView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 0.01*view.bounds.height))
        LineView.backgroundColor = .lightGray
        view.layer.borderWidth = 0.25
        view.addSubview(LineView)
        return view
    }()
    
    let ProfitView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.25*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        let LineView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 0.01*view.bounds.height))
        LineView.backgroundColor = .lightGray
        view.addSubview(LineView)
        return view
    }()
    
    let LineView2 : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0.33*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.01*UIScreen.main.bounds.height))
        view.backgroundColor =  UIColor(hexString: "D6D6D6")
        return view
    }()

    let ValueProfitView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.34*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        let LineView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 0.01*view.bounds.height))
        LineView.backgroundColor = .lightGray
        view.addSubview(LineView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        view.addSubview(backGround)
        view.addSubview(MainView)
        view.addSubview(AccountTitleLabel)
        view.addSubview(BackButton)
        MainView.addSubview(TitleLabelValueStart)
        MainView.addSubview(LabelValueStart)
        MainView.addSubview(LineView)
        MainView.addSubview(TimeView)
        MainView.addSubview(PeriodView)
        MainView.addSubview(ProfitView)
        MainView.addSubview(LineView2)
        MainView.addSubview(ValueProfitView)
        
        LabelValueStart.text = self.InitialBalanceValue + "đ"
        
        let ImageView = UIImageView(frame: CGRect(x: 20, y: 0.25*TimeView.bounds.height, width: 0.5*TimeView.bounds.height, height: 0.5*TimeView.bounds.height))
        ImageView.image = UIImage(named: "Period")
        ImageView.contentMode = .scaleAspectFit
        
        let label = UILabel(frame: CGRect(x: 0.5*TimeView.bounds.height + 35, y: 0.15*TimeView.bounds.height, width: 200, height: 0.3*TimeView.bounds.height))
        label.text = "Started"
        label.textColor = UIColor(hexString: "C0C0C0")
        
        let Datelabel = UILabel(frame: CGRect(x: 0.5*TimeView.bounds.height + 35, y: 0.55*TimeView.bounds.height, width: 200, height: 0.3*TimeView.bounds.height))
        Datelabel.text = self.InitialTime
        Datelabel.textColor = .black
        
        TimeView.addSubview(ImageView)
        TimeView.addSubview(label)
        TimeView.addSubview(Datelabel)
        
        
        let ImageViewForPeriod = UIImageView(frame: CGRect(x: 20, y: 0.25*TimeView.bounds.height, width: 0.5*TimeView.bounds.height, height: 0.5*TimeView.bounds.height))
        ImageViewForPeriod.image = UIImage(named: "Period")
        ImageViewForPeriod.contentMode = .scaleAspectFit
        
        let labelPeriod = UILabel(frame: CGRect(x: 0.5*PeriodView.bounds.height + 35, y: 0.15*PeriodView.bounds.height, width: 200, height: 0.3*PeriodView.bounds.height))
        labelPeriod.text = "Period"
        labelPeriod.textColor = UIColor(hexString: "C0C0C0")
        
        
        let DatelabelPeriod = UILabel(frame: CGRect(x: 0.5*PeriodView.bounds.height + 35, y: 0.55*PeriodView.bounds.height, width: 200, height: 0.3*PeriodView.bounds.height))
        DatelabelPeriod.text = self.Period + " Month"
        DatelabelPeriod.textColor = .black
        
        PeriodView.addSubview(ImageViewForPeriod)
        PeriodView.addSubview(labelPeriod)
        PeriodView.addSubview(DatelabelPeriod)
        
        
        let labelProfitRate = UILabel(frame: CGRect(x: 25, y: 0.25*ProfitView.bounds.height, width: 0.4*ProfitView.bounds.width, height: 0.5*ProfitView.bounds.height))
        labelProfitRate.text = "Profit Rate"
        labelProfitRate.textColor = .black
        
        let Rate = UILabel(frame: CGRect(x: 0.5*ProfitView.bounds.width - 25, y: 0.25*ProfitView.bounds.height, width: 0.5*ProfitView.bounds.width, height: 0.5*ProfitView.bounds.height))
        Rate.text = "\(self.ProfitRate)" + "%/Month"
        Rate.textAlignment = .right
        Rate.textColor = .black
        
        ProfitView.addSubview(labelProfitRate)
        ProfitView.addSubview(Rate)

        
        let TitlelabelProfit = UILabel(frame: CGRect(x: 25, y: 0.25*ValueProfitView.bounds.height, width: 0.4*ValueProfitView.bounds.width, height: 0.5*ValueProfitView.bounds.height))
        TitlelabelProfit.text = "Profit"
        TitlelabelProfit.textColor = .black
        
        let ValueProfit = UILabel(frame: CGRect(x: 0.5*ValueProfitView.bounds.width - 25, y: 0.25*ValueProfitView.bounds.height, width: 0.5*ValueProfitView.bounds.width, height: 0.5*ValueProfitView.bounds.height))
        ValueProfit.text = CaculatorProfit(Rate: ProfitRate, Value: InitialBalanceValue, Period: Period) + "đ"
        ValueProfit.textAlignment = .right
        print(ProfitRate)
        
        ValueProfitView.addSubview(TitlelabelProfit)
        ValueProfitView.addSubview(ValueProfit)
        
        AccountTitleLabel.text = Title
    }


    @objc func BacktoSavingPlan(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push //Transition you want like Push, Reveal
        transition.subtype = CATransitionSubtype.fromLeft // Direction like Left to Right, Right to Left
        transition.delegate = self
        view.window!.layer.add(transition, forKey: kCATransition)
     self.navigationController?.pushViewController(mapView, animated: true)
    }
    
    func CaculatorProfit(Rate: String,Value: String,Period: String) -> String{
        if Rate == "0"{
            return Value + "đ"
        }else{
        let rate = Double(Rate)!
        let value = Double(Value)!
        let period = Double(Period)!
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            let Value =  value * pow(1+rate/100,period)
            let Profit = formatter.string(from: Value as NSNumber)
            return Profit!
        }
    }
}
