//
//  ScheduleView.swift
//  MyWalletApp
//
//  Created by Tuan on 25/08/2021.
//


import UIKit
import FSCalendar


protocol ScheduleChanging{
    func SetTextForScheduleButton(text: String)
}

class ScheduleView: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    var SelectionDelegate:ScheduleChanging?
    lazy var DateChoiced = ""
    
    
    let Calendar : FSCalendar = {
          let calendar = FSCalendar()
          calendar.frame = CGRect(x: 30, y: 0.3*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height * 0.3)
          calendar.layer.cornerRadius = 10.0
          calendar.layer.borderWidth = 0.25
        calendar.backgroundColor = .white
          return calendar
      }()
    
    let DismissButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(Dismiss), for: .touchUpInside)
        return button
    }()
    
    let CancelScheduleButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 0.61*UIScreen.main.bounds.height, width: (UIScreen.main.bounds.width - 60)/2, height: UIScreen.main.bounds.height * 0.065)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.25
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(Dismiss), for: .touchUpInside)
        return button
    }()
    
    let DoneButton : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30 + (UIScreen.main.bounds.width - 60)/2, y: 0.61*UIScreen.main.bounds.height, width: (UIScreen.main.bounds.width - 60)/2, height: UIScreen.main.bounds.height * 0.065)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 0.25
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(Done), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        view.addSubview(DismissButton)
        view.addSubview(Calendar)
        view.addSubview(CancelScheduleButton)
        view.addSubview(DoneButton)
        
        Calendar.delegate = self
        Calendar.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @objc func Dismiss(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func Done(sender: UIButton){
        SelectionDelegate?.SetTextForScheduleButton(text: DateChoiced)
        dismiss(animated: true, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
          let formatter = DateFormatter()
          formatter.dateFormat = "dd-MM-YYYY"
          var DateFormatter = formatter.string(from: date)
          DateChoiced = "\(DateFormatter)"
     }

}



