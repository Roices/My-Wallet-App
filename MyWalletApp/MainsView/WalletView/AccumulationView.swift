//
//  AccumulationView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/08/2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class AccumulationView: UIViewController {

    
    let Background : UIImageView = {
        let background = UIImageView(image: UIImage(named: "Background"))
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return background
    }()
    
    let Mainview : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = 15.0
        View.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-150)
        return View
    }()
    
    
    let BackButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Back"), for: .normal)
        button.frame = CGRect(x: 25, y: 50, width: 50, height: 50)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(BacktoWallet), for: .touchUpInside)
        return button
    }()
    
    let ValueTf : UITextField = {
        let tf = UITextField()
        let imageUSD = UIImage(named: "USD")!
        let imageVND = UIImage(named: "VND")!
        tf.frame = CGRect(x: 30, y: 0.1*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        tf.layer.cornerRadius = 15.0
        tf.layer.borderWidth = 0.5
        tf.withImage(direction: .Left, image: imageUSD)
        tf.withImage(direction: .Right, image: imageVND)
        return tf
    }()
    
    let NoteTf : UITextField = {
        let Tf = UITextField()
        Tf.frame = CGRect(x: 30, y: 0.2*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: 0.075*UIScreen.main.bounds.height)
        Tf.layer.cornerRadius = 15.0
        Tf.layer.borderWidth = 0.5
        Tf.placeholder = "Note"
        return Tf
    }()
     
    let DateButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        return button
    }()
    
  
    let EndDateButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.4*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        return button
    }()
    
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.6*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height*0.075)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor(hexString: "090F52")
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(Background)
        view.addSubview(Mainview)
        view.addSubview(BackButton)
        Mainview.addSubview(ValueTf)
        Mainview.addSubview(NoteTf)
        Mainview.addSubview(DateButton)
        Mainview.addSubview(EndDateButton)
        Mainview.addSubview(DoneButton)
        
        
    }
    
    @objc func BacktoWallet(sender: UIButton){
        let mapView = (self.storyboard?.instantiateViewController(identifier: "WalletViewController"))! as WalletViewController
     self.navigationController?.pushViewController(mapView, animated: true)
    }
    

  

}
