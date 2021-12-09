//
//  ReportViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit
import Charts
import Firebase
import MonthYearPicker
import UserNotifications

class ReportViewController: UIViewController, UNUserNotificationCenterDelegate {

    //InCome and Expense
    lazy var NotifiArray : [(Noti: String, Time: String)] = []
    
    let Background : UIImageView = {
        let Background = UIImageView(image: UIImage(named: "Background"))
        Background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Background
    }()
    
    let MainView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0.111*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.889)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let Title : UILabel = {
        let title = UILabel()
        title.text = "Report"
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    let WalletImage : UIImageView = {
       let WalletImage = UIImageView(image: UIImage(named: "Alarm"))
        WalletImage.frame = CGRect(x: 30, y: 120, width: 40, height: 40)
       // WalletImage.backgroundColor = .red
        return WalletImage
    }()
    
    let AlertMainLabel : UILabel = {
        let AlertLabel = UILabel()
        AlertLabel.frame = CGRect(x: 80, y: 125, width: 200, height: 30)
        AlertLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        AlertLabel.text = "Nhắc nhở nhập liệu"
       // UserAccountLabel.textAlignment = .center
        return AlertLabel
    }()
    
    let SwichAlert : UISwitch = {
        let Switch = UISwitch()
        Switch.frame.origin.x = UIScreen.main.bounds.width - 80
        Switch.frame.origin.y = 125
        Switch.addTarget(self, action: #selector(TurnOnAlert), for: .valueChanged)
        return Switch
    }()
    
    
    let AlertExtraLabel : UILabel = {
        let AlertLabel = UILabel()
        AlertLabel.frame = CGRect(x: 80, y: 160, width: 300, height: 20)
        AlertLabel.text = "Hệ thống sẽ nhắc nhở bạn mỗi ngày"
        AlertLabel.font = UIFont.boldSystemFont(ofSize: 11.0)
        AlertLabel.textColor = .lightGray
       // UserAccountLabel.textAlignment = .center
        return AlertLabel
    }()
    
    lazy var TimeAlertView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 180, width: UIScreen.main.bounds.width, height: 40)
        
        let line = UIView(frame: CGRect(x: 80, y: 0, width: view.bounds.width - 110, height: 1))
        line.backgroundColor = UIColor(hexString: "D6D6D6")
        
        let label = UILabel(frame: CGRect(x: 80, y: view.frame.height/2 - 5, width: 70, height: 15))
        label.text = "Thời gian"
        label.font =  UIFont.boldSystemFont(ofSize: 14.0)
        
        
//        let UIDate = UIDatePicker()
//        UIDate.frame.origin.x = UIScreen.main.bounds.width - 115
//        UIDate.frame.origin.y = view.frame.height/2 - 13
//        UIDate.datePickerMode = .time
//        UIDate.addTarget(self, action: #selector(PushNotification), for: .valueChanged)
        
        view.addSubview(label)
        view.addSubview(line)
       // view.backgroundColor = .red
        return view
    }()
    
    lazy var Datepicker : UIDatePicker = {
        let UIDate = UIDatePicker()
        UIDate.frame.origin.x = UIScreen.main.bounds.width - 115
        UIDate.frame.origin.y = TimeAlertView.frame.height/2 - 13
        UIDate.datePickerMode = .time
        UIDate.addTarget(self, action: #selector(PushNotificationValueChanged), for: .valueChanged)
        return UIDate
    }()
    
    let Line : UIView = {
        let Line = UIView()
        Line.backgroundColor = UIColor(hexString: "D6D6D6")
        Line.frame = CGRect(x: 30, y: 195, width: UIScreen.main.bounds.width - 60, height: 1)
        return Line
    }()
    
    let TabelNotification : UITableView = {
        let table = UITableView()
        table.frame = CGRect(x: 0, y: 198, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    var savedNotificationDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: "notificationDate") as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "notificationDate")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(Background)
        view.addSubview(MainView)
        view.addSubview(Title)
        view.addSubview(WalletImage)
        view.addSubview(AlertMainLabel)
        view.addSubview(AlertExtraLabel)
        view.addSubview(SwichAlert)
        view.addSubview(Line)
        TimeAlertView.addSubview(Datepicker)
        view.addSubview(TimeAlertView)
        view.addSubview(TabelNotification)
        
        //TimeAlertView.addSubview(Datepicker)
   
        TabelNotification.delegate = self
        TabelNotification.dataSource = self
        TabelNotification.separatorStyle = .none
        TabelNotification.backgroundColor = UIColor(hexString: "F1F0F6")
//        print("Height: \(test.frame.width)")
        TimeAlertView.isHidden = true
        ConfigureData()
        SwichAlert.isOn =  UserDefaults.standard.bool(forKey: "switchState")
        if SwichAlert.isOn{
            TimeAlertView.isHidden = false
            self.Line.frame.origin.y = 230
            self.TabelNotification.frame.origin.y = 232
            PushNotification()
            if let savedNotificationDate = savedNotificationDate {
                Datepicker.date = savedNotificationDate
            }
        }else{
            
        }
        AddConstraints()
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1334:
                    print("iPhone 6/6S/7/8")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 15, width: 150, height: 50)

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 15, width: 150, height: 50)
                default:
                    print("Unknown")
                    Title.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 40, width: 150, height: 45)
                }
            }
}

}

extension ReportViewController{
    
    func AddConstraints(){
        var constraints = [NSLayoutConstraint]()
        
       constraints.append(TabelNotification.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(TabelNotification.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       constraints.append(TabelNotification.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        constraints.append(TabelNotification.topAnchor.constraint(equalTo: Line.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func ConfigureData(){
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath:path!).child("Notification")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
          self.NotifiArray = [];
          for children in snapshot.children {
            if let postSnapshot = children as? DataSnapshot {
                if let Noti = postSnapshot.childSnapshot(forPath: "Notification").value as? String,
                let Date = postSnapshot.childSnapshot(forPath: "Date").value as? String{
                    self.NotifiArray.append((Noti: Noti, Time: Date))
              }
            }
          }
          // cập nhật ui
          self.TabelNotification.reloadData()
        })
    }
    
    @objc func TurnOnAlert(sender: UISwitch){
        let center = UNUserNotificationCenter.current()
        if sender.isOn{
        TimeAlertView.isHidden = false
        self.Line.frame.origin.y = 230
            self.TabelNotification.frame.origin.y = 232
            savedNotificationDate = Datepicker.date
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                //  Enable or disable features based on authorization.
                 if(!granted){
                     print("not accept authorization")
                 }else{
                     print("accept authorization")

                     center.delegate = self
                    UNUserNotificationCenter.current().delegate = self

                 }

             }
            PushNotification()
    }else{
            //UIApplication.shared.unregisterForRemoteNotifications()
            center.removeAllPendingNotificationRequests()
            TimeAlertView.isHidden = true
            self.Line.frame.origin.y = 195
            self.TabelNotification.frame.origin.y = 197
        }
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
    }
    
     func PushNotification(){
        let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: "We have a new message for you", arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: "Open the app for see", arguments: nil)
                content.sound = UNNotificationSound.default

        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "h"
        let hour = dateFormatr.string(from: (Datepicker.date))
        
        dateFormatr.dateFormat = "m"
        let minute = dateFormatr.string(from: (Datepicker.date))

//        let center = UNUserNotificationCenter.current()
        let center = UNUserNotificationCenter.current()
        var dateInfo = DateComponents()
        dateInfo.hour = Int(hour)!
        dateInfo.minute = Int(minute)!

        print("dateInfo: \(dateInfo)")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        //let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("ErrorABC \(error.localizedDescription)")
            }else{
                print("send!!")
            }
        }


    }
    
    
    
 @objc func PushNotificationValueChanged(sender: UIDatePicker){
    //let center = UNUserNotificationCenter.current()
   // center.removeAllPendingNotificationRequests()
    savedNotificationDate = sender.date
    PushNotification()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.title)
        // Play a sound.
//        completionHandler(UNNotificationPresentationOptions.sound)
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.title)
    }
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NotifiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotificationViewCell.cellForTableView(tableView: TabelNotification)
        let Data = NotifiArray[indexPath.row]
        cell.DateLabel.text = "Thời gian: " + Data.Time
        cell.NotiLabel.text = Data.Noti
        return cell
    }
}
