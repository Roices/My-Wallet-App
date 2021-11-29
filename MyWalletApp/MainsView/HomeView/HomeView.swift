//
//  HomeView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/07/2021.
//

import UIKit
import Charts
import FirebaseDatabase
import MonthYearPicker

class HomeView: UIViewController,ChartViewDelegate, CAAnimationDelegate{
 
    lazy var ListAccount = [String]()
    lazy var ArrayCategory = [String]()
    lazy var IncomeArray = [String]()
    lazy var CategorySectionData = [CategorySection]()
    lazy var InComeSection = [CategorySection]()
    lazy var ColorForEachCategorySection: [String: UIColor] = [:]
    lazy var ColorForEachInComeSection: [String: UIColor] = [:]
  //  lazy var ColorForIconTable: [String: UIColor] = [:]
    lazy var TotalExpense = 0.0
    lazy var TotalInCome = 0.0
    
    lazy var DataForTabel = [CategorySection]()
    
    let buttonTime : UIButton = {
        let button = UIButton()
        let formatter = DateFormatter()
        let Time = Date()
        formatter.dateFormat = "MM-YYYY"
        let DateFormatter = formatter.string(from: Time)
//        button.frame = CGRect(x: UIScreen.main.bounds.width/2 - 150, y: 25, width: 300, height: 50)
        button.layer.cornerRadius = 15.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.backgroundColor = UIColor(hexString: "163058")
        button.setTitle("10-2021", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(HidingPickerView), for: .touchUpInside)
        return button
    }()
    
    
    let picker : MonthYearPickerView = {
        let picker = MonthYearPickerView(frame: CGRect(x: UIScreen.main.bounds.width/4, y: 100, width: UIScreen.main.bounds.width/2, height: 0.2*UIScreen.main.bounds.height))
        picker.addTarget(self, action: #selector (dateChanged), for: .valueChanged)
        picker.layer.borderWidth = 0.25
        return picker
    }()
    
  lazy var pieChart:PieChartView = {
    let pieChart = Charts.PieChartView()
  //  pieChart.legend.enabled = false
    pieChart.legend.horizontalAlignment = .center
    pieChart.legend.font = UIFont.systemFont(ofSize: 11)
    pieChart.frame = CGRect(x: InComeView.frame.size.width * 0.1, y: InComeView.frame.size.height/2 - 150, width: 0.8 * UIScreen.main.bounds.width, height: 0.85 * UIScreen.main.bounds.width)
    //pieChart.center = ViewForChart.center
    pieChart.holeRadiusPercent = 0.68
    pieChart.drawEntryLabelsEnabled = false
    pieChart.chartDescription?.text = ""
    pieChart.isUserInteractionEnabled = true
    return pieChart
    }()
    
    
    //BackGround
    let BackGroundImage:UIImageView = {
        let BackGround = UIImageView(image: UIImage(named: "Background"))
        BackGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return BackGround
    }()
    
   //View for PieChart
    lazy var ViewForChart : UIView = {
        let ViewForChart = UIView()
        ViewForChart.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 225)/2 + 30)
        //ViewForChart.backgroundColor = .purple
        return ViewForChart
    }()
    
    
    //MainView
    let MainView : UIView = {
        let MainView = UIView()
        MainView.backgroundColor  = .white
        MainView.layer.cornerRadius = 15.0
        MainView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100 )
        return MainView
    }()
    

    let codeSegmented : CustomSegmentedControl = {
        let y = (UIScreen.main.bounds.height - 200)/2 + 120
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 50), buttonTitle: ["All Assets","Spending","Income"])
        
        let color = UIColor(hexString: "797979")
        let colorForLine = UIColor(hexString: "C0C0C0")
        let blue = UIColor(hexString: "116AEE")
        
        codeSegmented.backgroundColor = .clear
        codeSegmented.textColor = color
        codeSegmented.selectorViewColor = blue
        codeSegmented.selectorTextColor = blue
        codeSegmented.LineViewColor = colorForLine
        return codeSegmented
    }()
    

    lazy var ListAssets:UITableView = {
        let OriginY = codeSegmented.frame.origin.y + 54
        let List = UITableView()
        List.frame = CGRect(x: 0, y: OriginY, width: UIScreen.main.bounds.width, height: 300)
        List.translatesAutoresizingMaskIntoConstraints = false
        List.backgroundColor = UIColor(hexString: "F1F0F6")
        List.separatorStyle = .none
        return List
    }()
    
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect =
            CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 10.0)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        path.fill()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    let InComeView : UIView = {
        let ViewForChart = UIView()
        ViewForChart.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 225)/2 - 30)
        //ViewForChart.backgroundColor = .yellow
        return ViewForChart
    }()
    
    lazy var InComePieChart:PieChartView = {
      let piEChart = Charts.PieChartView()
      piEChart.legend.enabled = true
      piEChart.legend.horizontalAlignment = .center
      piEChart.legend.font = UIFont.systemFont(ofSize: 11)
      piEChart.frame = CGRect(x: InComeView.frame.size.width * 0.1, y: InComeView.frame.size.height/2 - 150, width: 0.8 * UIScreen.main.bounds.width, height: 0.85 * UIScreen.main.bounds.width)
        
   //   piEChart.center = InComeView.center
      piEChart.holeRadiusPercent = 0.68
      piEChart.drawEntryLabelsEnabled = false
      piEChart.chartDescription?.text = ""
      piEChart.isUserInteractionEnabled = true
      return piEChart
      }()

    lazy var Left : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 5, y: (UIScreen.main.bounds.height - 225 + 85)/3, width: 30, height: 30)
        button.setTitle("Left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "LeftButton"), for: .normal)
        button.addTarget(self, action: #selector(LeftView), for: .touchUpInside)
        return button
    }()
    
    lazy var Right : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: UIScreen.main.bounds.width - 35, y: (UIScreen.main.bounds.height - 225 + 85)/3, width: 30, height: 30)
        button.setTitle("Left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(UIImage(named: "RightButton"), for: .normal)
        button.addTarget(self, action: #selector(LeftView), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeSegmented.delegate = self
        ListAssets.delegate = self
        ListAssets.dataSource = self

        
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarController?.tabBar.layer.shadowRadius = 8
        tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController?.tabBar.layer.shadowOpacity = 0.3
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    print("iPhone 5 or 5S or 5C or SE")
                    buttonTime.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 25, width: 150, height: 50)

                case 1334:
                    print("iPhone 6/6S/7/8")
                    buttonTime.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 25, width: 150, height: 50)

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    buttonTime.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 25, width: 150, height: 50)
                default:
                    print("Unknown")
                    buttonTime.frame = CGRect(x: UIScreen.main.bounds.width/2 - 75, y: 40, width: 150, height: 45)
                }
            }
        ConfigureDataDetail()
        picker.isHidden = true
        self.hideKeyboardWhenTappedAround()
        InComeView.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
//        UserDefaults.standard.setValue("tuan dep trai", forKey: "Username")
     //   ListIncome.isHidden = true
//        InComePieChart.isHidden = true
                    
}

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        
        view.addSubview(BackGroundImage)
        view.addSubview(buttonTime)
        view.addSubview(MainView)
        ViewForChart.addSubview(pieChart)
      //  ViewForChart.addSubview(AllAssetLabel)
       // InComeView.addSubview(InComePieChart)
       // view.addSubview(InComeView)
        view.addSubview(ViewForChart)
        view.addSubview(codeSegmented)
      //  view.addSubview(searchController)
        view.addSubview(ListAssets)
        //view.addSubview(picker)
      //  view.addSubview(NoDataLabel)
        InComeView.addSubview(InComePieChart)
        view.addSubview(InComeView)
       // view.addSubview(InComePieChart)
        view.addSubview(picker)
        view.addSubview(Left)
        view.addSubview(Right)
       // view.addSubview(ListIncome)
    }
   

}



extension HomeView:CustomSegmentedControlDelegate{
    func change(to index: Int) {
        switch index {
        case 0:
            DataForTabel =  CategorySectionData + InComeSection
        case 1:
            DataForTabel = CategorySectionData
        case 2:
            DataForTabel = InComeSection
        default:
            print("Default")
           // ListAssets.reloadData()
        }
        ConfigureDataDetail()
        ListAssets.reloadData()
    }
}


extension HomeView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllAssetsCell.cellForTableView(tableView: ListAssets)
        let Data = DataForTabel[indexPath.row]
        cell.CategoryLabel.text = Data.Category
        cell.ProgressValue.progress = Float(Data.TotalValue/TotalExpense)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        let ValueIncomeforAccount = formatter.string(from: Data.TotalValue as NSNumber)
        cell.Value.text = ValueIncomeforAccount! + "đ"
        formatter.groupingSeparator = ","
        let perCentValue = ((Data.TotalValue/TotalExpense)*100).rounded(toPlaces: 2)
        let NewPercentValue = formatter.string(from: perCentValue as NSNumber)
        cell.ValuePercent.text = "(" + NewPercentValue! + "%)"
        cell.IconImage.image = UIImage(named: "\(Data.Category)")
        cell.IconImage.backgroundColor = ColorForEachCategorySection[Data.Category]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataForTabel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SelectRow")
        let Mapview = self.storyboard?.instantiateViewController(identifier: "DetailSpending") as! DetailSpending
        let Data = DataForTabel[indexPath.row]
        let time = (buttonTime.titleLabel?.text)!
        UserDefaults.standard.setValue(Data.Category, forKey: "Category")
        UserDefaults.standard.setValue(time, forKey: "Time")
        self.navigationController?.pushViewController(Mapview, animated: true)
        //let Data = DataForTabel[indexPath.row]
        
    }
}

extension HomeView{
    
    @objc func LeftView(sender: UIButton){
        ViewForChart.isHidden = !ViewForChart.isHidden
        InComeView.isHidden = !InComeView.isHidden

    }
    
    func ConfigIncomePieChart(data: [String], ValueData: [Double], TotalValue: Double){
        var dataEntries: [ChartDataEntry] = []
        var dataPoints = data
        let values = ValueData
          for i in 0..<dataPoints.count {
            dataPoints[i] = dataPoints[i] +  "(\(String(values[i]))%)"
            let dataEntry = PieChartDataEntry(value: values[i] , label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
        let color1 = UIColor(hexString: "FF6E2E")
        let color2 = UIColor(hexString: "00B358")
        let color3 = UIColor(hexString: "137FEC")
        let color4 = UIColor.red
        self.ColorForEachInComeSection = ["Wage": color1,
                                    "Bonus": color2,
                                    "Interest": color3,
                                    "Other": color4]
        
        var colors:[UIColor] = []
        print("data: \(data)")
        
        for color in 0..<data.count{
            let UIcolor = ColorForEachInComeSection[data[color]]!
            colors.append(UIcolor)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colors
        
          // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let pFormatter = NumberFormatter()
            pFormatter.numberStyle = .percent
            pFormatter.maximumFractionDigits = 1
            pFormatter.multiplier = 1
            pFormatter.percentSymbol = "%"
        //
            pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
            pieChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 12)!)
            pieChartData.setValueTextColor(.white)
            pieChartDataSet.sliceSpace = 3
            pieChartDataSet.drawValuesEnabled = false
        
        
        let Formatter = NumberFormatter()
        Formatter.numberStyle = .decimal
        Formatter.groupingSeparator = "."
        
        let TotalValueIncome = Formatter.string(from: TotalValue as NSNumber)
        let attrStri = NSMutableAttributedString.init(string:"ALL INCOME\n \(TotalValueIncome!)đ")
        let nsRange = NSString(string: "ALL INCOME\n \(TotalValueIncome!)đ").range(of: "\(TotalValueIncome!)đ", options: String.CompareOptions.caseInsensitive)
        let FsRange = NSString(string: "ALL INCOME\n \(TotalValueIncome!)đ").range(of: "ALL INCOME", options: String.CompareOptions.caseInsensitive)
        attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hexString: "707070"),NSAttributedString.Key.font: UIFont.init(name: "HelveticaNeue-Light", size: 20.0) as Any], range: FsRange)
        attrStri.addAttributes([NSAttributedString.Key.font: UIFont.init(name: "HelveticaNeue-Bold", size: 19.0) as Any], range: nsRange)
        InComePieChart.centerAttributedText = attrStri

          //  pieChart.centerAttributedText = myTotalValue
            InComePieChart.data = pieChartData
    }
    
    
    
    func ConfigPieChart(data: [String], ValueData: [Double], TotalValue: Double){
        var dataEntries: [ChartDataEntry] = []
        var dataPoints = data
        let values = ValueData
          for i in 0..<dataPoints.count {
                dataPoints[i] = dataPoints[i] +  "(\(String(values[i]))%)"
                let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
            }
            
          // 2. Set ChartDataSet
        let color1 = UIColor(hexString: "FF6E2E")
        let color2 = UIColor(hexString: "00B358")
        let color3 = UIColor(hexString: "137FEC")
        let color4 = UIColor.red
        let color5 = UIColor.purple
        let color6 = UIColor.gray
        let color7 = UIColor(hexString: "945200")
        let color8 = UIColor(hexString: "FF40FF")
        let color9 = UIColor(hexString: "941751")
        let color10 = UIColor(hexString: "76D6FF")
        let color11 = UIColor(hexString: "AA7942")
        let color12 = UIColor(hexString: "FF2F92")
        self.ColorForEachCategorySection = ["Children": color1,
                                    "Service": color12,
                                    "Study": color3,
                                    "Health": color4,
                                    "Food": color5,
                                    "Vehicles": color6,
                                    "House": color7,
                                    "Gift": color8,
                                    "Bank": color9,
                                    "Entertain": color10,
                                    "Loan": color11,
                                    "Income": color2]
        
        var colors:[UIColor] = []
        
        for color in 0..<data.count{
            let UIcolor = ColorForEachCategorySection[data[color]]
            colors.append(UIcolor!)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colors
        
          // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let pFormatter = NumberFormatter()
            pFormatter.numberStyle = .percent
            pFormatter.maximumFractionDigits = 2
            pFormatter.multiplier = 1
            pFormatter.percentSymbol = "%"
        //
            pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
            pieChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 12)!)
            pieChartData.setValueTextColor(.white)
            pieChartDataSet.sliceSpace = 1
            pieChartDataSet.drawValuesEnabled = false

        
            let Formatter = NumberFormatter()
            Formatter.numberStyle = .decimal
            Formatter.groupingSeparator = "."
        
            let TotalValueExpense = Formatter.string(from: TotalValue as NSNumber)
            let attrStri = NSMutableAttributedString.init(string:"ALL ASSETS\n\(TotalValueExpense!)đ")
            let nsRange = NSString(string: "ALL ASSETS\n\(TotalValueExpense!)đ").range(of: "\(TotalValueExpense!)đ", options: String.CompareOptions.caseInsensitive)
            let FsRange = NSString(string: "ALL ASSETS\n\(TotalValueExpense!)đ").range(of: "ALL ASSETS", options: String.CompareOptions.caseInsensitive)
            attrStri.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hexString: "707070"),NSAttributedString.Key.font: UIFont.init(name: "HelveticaNeue-Light", size: 20.0) as Any], range: FsRange)
            attrStri.addAttributes([NSAttributedString.Key.font: UIFont.init(name: "HelveticaNeue-Bold", size: 20.0) as Any], range: nsRange)
            pieChart.centerAttributedText = attrStri
            pieChart.data = pieChartData
         
    }
    
    func AddConstraints(){
        var constraints = [NSLayoutConstraint]()
        
       constraints.append(ListAssets.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(ListAssets.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       constraints.append(ListAssets.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        constraints.append(ListAssets.topAnchor.constraint(equalTo: codeSegmented.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func ConfigureDataDetail(){
      //  var DataBase = [Details]()
//        var IncomeArray = [String]()
        let MonthSection = (buttonTime.titleLabel?.text)!
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("\(MonthSection)").child("DataHomeView")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
            CategorySectionData = []
            ArrayCategory = []
            InComeSection = []
            TotalExpense = 0.0
            IncomeArray = []
            TotalInCome = 0.0
            for children in snapshot.children {
              //  DataBase = []
                if let postSnapshot = children as? DataSnapshot {
                   // let key = postSnapshot.key
             if let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String,
                let Detail = postSnapshot.childSnapshot(forPath: "Detail").value as? String{
               // TotalExpense += CalculateAmount(Value)
//                let Data = Details(Note: Note, Value: Value, Key: key, Date: Date, Account: Account, Detail: Detail)
                print("TotalValue: \(Value)")
                
                if Category == "Income"{
                    TotalInCome += CalculateAmount(Value)
                    if IncomeArray.contains(Detail){
                        for index in 0..<InComeSection.count{
                           if InComeSection[index].Category == Detail{
                                InComeSection[index].TotalValue += CalculateAmount(Value)
                            }
                      }
                    }else{
                        IncomeArray.append(Detail)
                        let DataIncome = CategorySection(Category: Detail, TotalValue: CalculateAmount(Value))
                        InComeSection.append(DataIncome)
                    }
                }else{
                    TotalExpense += CalculateAmount(Value)
                if ArrayCategory.contains(Category){
                    for index in 0..<CategorySectionData.count{
                        var TotalValue = 0.0
                        if CategorySectionData[index].Category == Category{
//                            CategorySectionData[index].Database.append(Data)
                            TotalValue = CalculateAmount(Value)
                            CategorySectionData[index].TotalValue += TotalValue
                            
                        }
                    }
                }else{
                    ArrayCategory.append(Category)
                   // DataBase.append(Data)
                    let Section = CategorySection(Category: Category, TotalValue: CalculateAmount(Value))
                    CategorySectionData.append(Section)
                }
              } //CheckPoint
            }
          }
            }
//            if CategorySectionData.isEmpty{
//               // self.pieChart.isHidden = true
//                self.NoDataLabel.isHidden = false
//            }else{
//              //  self.pieChart.isHidden = false
//                self.NoDataLabel.isHidden = true
//            }
            var ArrayValue:[Double] = []
            var ArrayValueforIncome:[Double] = []
            
            for value in 0..<CategorySectionData.count{
                let perCentValue = ((CategorySectionData[value].TotalValue/TotalExpense)*100).rounded(toPlaces: 2)
                    ArrayValue.append(perCentValue)
                }
            
            
            ConfigPieChart(data: ArrayCategory, ValueData: ArrayValue, TotalValue: TotalExpense)
            
            for value in 0..<IncomeArray.count{
                let PerCentValue = ((InComeSection[value].TotalValue/TotalInCome)*100).rounded(toPlaces: 2)
                ArrayValueforIncome.append(PerCentValue)
                }
                
            ConfigIncomePieChart(data: IncomeArray, ValueData: ArrayValueforIncome, TotalValue: TotalInCome)
            self.ListAssets.reloadData()
        })
    }

    @objc func HidingPickerView(sender: UIButton){
        picker.isHidden = !picker.isHidden

    }
    


    @objc func dateChanged(sender: MonthYearPickerView){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-YYYY"
        let DateFormatter = formatter.string(from: picker.date)
        buttonTime.setTitle("\(DateFormatter)", for: .normal)
        ConfigureDataDetail()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.picker.isHidden = !self.picker.isHidden
        }
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
    
}


struct CategorySection{
    var Category : String
//    var Database : [Details]
    var TotalValue : Double
}

//struct Details{
//    var Note : String
//    var Value : String
//    var Key : String
//    var Date : String
//    var Account : String
//    var Detail : String
//}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


