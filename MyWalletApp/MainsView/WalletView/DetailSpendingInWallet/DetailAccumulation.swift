//
//  DetailAccumulation.swift
//  MyWalletApp
//
//  Created by Tuan on 26/09/2021.
//

import UIKit

class DetailAccumulation: UIViewController, CAAnimationDelegate {

    lazy var Time = ""
    lazy var Value = ""
    lazy var CompletedValue = ""
    lazy var TitleForAccumulation = ""
    lazy var Key = ""
    lazy var ExpirationDate = ""
    lazy var Note = ""
    
    let TitleLabel : UILabel = {
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
        button.addTarget(self, action: #selector(BacktoAccumulation), for: .touchUpInside)
        return button
    }()
    
    let TimeView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1*UIScreen.main.bounds.height)
        let LineView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 0.01*view.bounds.height))
        LineView.backgroundColor = .lightGray
        view.addSubview(LineView)
        return view
    }()
    
    let ProgressView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.11*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.08*UIScreen.main.bounds.height)
        let LineView = UIView(frame: CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 0.01*view.bounds.height))
        LineView.backgroundColor = .lightGray
        view.addSubview(LineView)
        return view
    }()
    
    let SentButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "090F52")
        button.addTarget(self, action: #selector(Sent), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backGround)
        view.addSubview(BackButton)
        view.addSubview(MainView)
        view.addSubview(TitleLabel)
        MainView.addSubview(TimeView)
        MainView.addSubview(ProgressView)
        // Do any additional setup after loading the view.
        
        let ImageView = UIImageView(frame: CGRect(x: 20, y: 0.25*TimeView.bounds.height, width: 0.5*TimeView.bounds.height, height: 0.5*TimeView.bounds.height))
        ImageView.image = UIImage(named: "Period")
        ImageView.contentMode = .scaleAspectFit
        
        let label = UILabel(frame: CGRect(x: 0.5*TimeView.bounds.height + 35, y: 0.15*TimeView.bounds.height, width: 200, height: 0.3*TimeView.bounds.height))
        label.text = "Time"
        label.textColor = UIColor(hexString: "C0C0C0")
        
        let DatelabelPeriod = UILabel(frame: CGRect(x: 0.5*TimeView.bounds.height + 35, y: 0.55*TimeView.bounds.height, width: 200, height: 0.3*TimeView.bounds.height))
        DatelabelPeriod.text = self.Time + " - " + CalculatorTime(Time, ExpirationDate)
        DatelabelPeriod.textColor = .black
        
        TimeView.addSubview(ImageView)
        TimeView.addSubview(label)
        TimeView.addSubview(DatelabelPeriod)
        
        let ValueLabel = UILabel(frame: CGRect(x: 0.5*ProgressView.bounds.width - 20, y: 0.1*ProgressView.bounds.height, width: 0.5*ProgressView.bounds.width, height: 0.2*ProgressView.bounds.height))
        ValueLabel.text = self.Value + "đ"
        ValueLabel.textAlignment = .right
        
        let ProgressValueCompleted = UIProgressView(frame: CGRect(x: 20, y: 0.45*ProgressView.bounds.height, width: UIScreen.main.bounds.width - 40, height: 0.1*ProgressView.bounds.height))
        ProgressValueCompleted.progress = Float(CalculateAmount(CompletedValue)/CalculateAmount(Value))
        ProgressValueCompleted.progressTintColor = .green
        
        let RestValueLabel = UILabel(frame: CGRect(x: 0.5*ProgressView.bounds.width - 20, y: 0.65*ProgressView.bounds.height, width: 0.5*ProgressView.bounds.width, height: 0.2*ProgressView.bounds.height))
        RestValueLabel.textAlignment = .right
        RestValueLabel.font = UIFont.systemFont(ofSize: 12)
        RestValueLabel.textColor = .lightGray
        let RestValue = CalculateAmount(Value) - CalculateAmount(CompletedValue)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        let RestAmount = formatter.string(from: RestValue as NSNumber)
        RestValueLabel.text = "Need more: \(RestAmount!)đ"
        
        let CompletedLabel = UILabel(frame: CGRect(x: 20, y: 0.65*ProgressView.bounds.height, width: 0.5*ProgressView.bounds.width - 40, height: 0.2*ProgressView.bounds.height))
        CompletedLabel.textColor = .green
        CompletedLabel.font = UIFont.systemFont(ofSize: 12.0)
        CompletedLabel.text = self.CompletedValue + "đ"
                
        ProgressView.addSubview(ValueLabel)
        ProgressView.addSubview(ProgressValueCompleted)
        ProgressView.addSubview(RestValueLabel)
        ProgressView.addSubview(CompletedLabel)
        
        let tabarY = self.tabBarController!.tabBar.frame.origin.y
        SentButton.frame = CGRect(x: 20, y: tabarY - 0.1*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 40, height: 0.075*UIScreen.main.bounds.height)
        view.addSubview(SentButton)

        
    }
    

    @objc func BacktoAccumulation(sender: UIButton){
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
    
    @objc func Sent(sender: UIButton){
        let MapView = self.storyboard?.instantiateViewController(identifier: "AccumulationView") as! AccumulationView
        MapView.Value = Value
        MapView.NoteTf.text = TitleForAccumulation
        MapView.DateButton.setTitle(Time , for: .normal)
        MapView.DateButton.setTitleColor(.black, for: .normal)
        MapView.ExpirationDate.setTitle(ExpirationDate, for: .normal)
        MapView.ExpirationDate.setTitleColor(.black, for: .normal)
        MapView.Key = Key
        MapView.DoneButton.setTitle("Send", for: .normal)
        MapView.NoteTf.isUserInteractionEnabled = false
        MapView.NoteTf.text = Note
        MapView.DateButton.isEnabled = false
        MapView.ExpirationDate.isEnabled = false
        MapView.State = "SendMoney"
        MapView.ValueCompleted = self.CompletedValue
        self.navigationController?.pushViewController(MapView, animated: true)
    }

    func CalculateAmount(_ Value: String) ->Double{
        var string = Value
        var amount:Double = 0
        let occurrencies = string.filter { $0 == "." }.count
        for index in 0...occurrencies{
            
            if let lastIndex = string.lastIndex(of: "."){
            let last = string.endIndex
                var subString2 = string[lastIndex..<last]
                string = string.replacingOccurrences(of: subString2, with: "", range: lastIndex..<last)
                subString2.remove(at: subString2.startIndex)
                
                amount += Double(subString2)! * pow(1000, Double(index))
                
            }else{
                amount += Double(string)! * pow(1000, Double(index))
            }
        }
        return amount
    }
    
    func CalculatorTime(_ Date: String,_ AddingTime: String) ->String{
        let dateFormatter = DateFormatter()
        let AddingTime = AddingTime
            .components(separatedBy:CharacterSet.decimalDigits.inverted)
            .joined()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let InitialDate = dateFormatter.date(from: Date)!
        let NewDate = Calendar.current.date(byAdding: .month, value: Int(AddingTime)!, to: InitialDate)
        let Time = dateFormatter.string(from: NewDate!)
        return Time
        
    }
}
