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

class HomeView: UIViewController,ChartViewDelegate{
 
    lazy var ListAccount = [String]()
    lazy var ArrayCategory = [String]()
    lazy var CategorySectionData = [CategorySection]()
    lazy var ColorForEachSection: [String: UIColor] = [:]
    lazy var TotalExpense = 0.0

    let players = ["All Assets", "Cash", "Income"]
    let goals:[Double] = [11.0, 22.0, 33.0]
    let Games = [
        "LOL" , "PUBG" , "CF"
    ]
   
    let TVShow = [
        "Friends" , "Breaking bad" , "Preason of break"
    ]
    
    let gadgets = [
        "Laptop" , "PC" , "Bag" , "Mouse"
    ]
    
    var filterData:[String]!
    lazy var RowToDisplay = Games
    
    
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
    pieChart.legend.enabled = false
    pieChart.frame.size.width = 300 // 0.75 * UIScreen.main.bounds.width
    pieChart.frame.size.height =  300 //0.4 * UIScreen.main.bounds.height
    pieChart.frame = CGRect(x: ViewForChart.frame.size.width/2 - 150, y: ViewForChart.frame.size.height/2 - 150, width: 0.75 * UIScreen.main.bounds.width, height: 0.75 * UIScreen.main.bounds.width)
    //pieChart.center = ViewForChart.center
    pieChart.holeRadiusPercent = 0.68
    pieChart.drawEntryLabelsEnabled = false
    pieChart.chartDescription?.text = ""
    pieChart.isUserInteractionEnabled = true
    return pieChart
    }()
    
    lazy var NoDataLabel : UILabel = {
        let label = UILabel()
        label.text = "Data does not exist!"
        label.frame.size.width = 200
        label.frame.size.height = 40
        label.center = ViewForChart.center
        label.textAlignment = .center
        return label
    }()
    
    //BackGround
    let BackGroundImage:UIImageView = {
        let BackGround = UIImageView(image: UIImage(named: "Background"))
        BackGround.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return BackGround
    }()
    
   //View for PieChart
    let ViewForChart : UIView = {
        let ViewForChart = UIView()
        ViewForChart.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 225)/2)
       // ViewForChart.backgroundColor = .yellow
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
        let y = (UIScreen.main.bounds.height - 200)/2 + 65
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
    
    
   lazy var searchController: UISearchBar = {
        let OriginY = codeSegmented.frame.origin.y + 60
        let s = UISearchBar()
        s.frame = CGRect(x: 10, y: OriginY, width: UIScreen.main.bounds.width - 20, height: 80)
        s.placeholder = "Search for Games..."
        s.searchBarStyle = .minimal

        let color = UIColor(hexString: "EFEFEF")
        let image = self.getImageWithColor(color: color, size: CGSize(width: UIScreen.main.bounds.width - 20, height: 60))
        s.setSearchFieldBackgroundImage(image, for: .normal)
        s.showsCancelButton = false
        s.searchBarStyle = .minimal
           
        return s
        
        
    }()
    
    lazy var ListAssets:UITableView = {
        let OriginY = codeSegmented.frame.origin.y + 60 + 80
        let List = UITableView()
        List.frame = CGRect(x: 0, y: OriginY, width: UIScreen.main.bounds.width, height: 282)
        List.translatesAutoresizingMaskIntoConstraints = false
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
        ViewForChart.backgroundColor = .systemPink
        ViewForChart.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 225)/2)
        return ViewForChart
    }()
    
    lazy var InComePieChart:PieChartView = {
      let piEChart = Charts.PieChartView()
        var dataEntries: [ChartDataEntry] = []
        let dataPoints = players
        let values = goals
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
        let color1 = UIColor(hexString: "FF6E2E")
        let color2 = UIColor(hexString: "00B358")
        let color3 = UIColor(hexString: "137FEC")
      //  pieChartDataSet.colors = colors
        let colors:[UIColor] = [color1,color2,color3]
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
      piEChart.legend.enabled = false
      piEChart.frame.size.width = 300 // 0.75 * UIScreen.main.bounds.width
      piEChart.frame.size.height =  300 //0.4 * UIScreen.main.bounds.height
      piEChart.center = ViewForChart.center
      piEChart.holeRadiusPercent = 0.68
      piEChart.drawEntryLabelsEnabled = false
      piEChart.chartDescription?.text = ""
      piEChart.isUserInteractionEnabled = true
      piEChart.data = pieChartData
      return piEChart
      }()

    let Left : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 200, width: 30, height: 30)
        button.setTitle("Left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(LeftView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeSegmented.delegate = self
        ListAssets.delegate = self
        ListAssets.dataSource = self
        searchController.delegate = self

        
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
        InComePieChart.isHidden = true
                    
}

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        
        view.addSubview(BackGroundImage)
        view.addSubview(buttonTime)
        view.addSubview(MainView)
        ViewForChart.addSubview(pieChart)
        view.addSubview(ViewForChart)
        //view.addSubview(pieChart)
        view.addSubview(codeSegmented)
        view.addSubview(searchController)
        view.addSubview(ListAssets)
        view.addSubview(picker)
        view.addSubview(NoDataLabel)
        view.addSubview(InComeView)
        view.addSubview(InComePieChart)
        view.addSubview(Left)
    }
   

}


extension HomeView:CustomSegmentedControlDelegate{
    func change(to index: Int) {
        switch index {
        case 0:
            RowToDisplay = Games
            filterData = Games
            searchController.placeholder = "Search for Games...."
            searchController.text = ""
        case 1:
            RowToDisplay = TVShow
            filterData = TVShow
            searchController.placeholder = "Search for TVShow...."
            searchController.text = ""
        default:
            RowToDisplay = gadgets
            filterData = gadgets
            searchController.placeholder = "Search for Gadgets...."
            searchController.text = ""
        }
        ListAssets.reloadData()
    }
}


extension HomeView:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == ""{
            filterData = RowToDisplay
        }else{
            for data in RowToDisplay{
                if data.lowercased().contains(searchText.lowercased()){
                    filterData.append(data)
                }
            }
        }
        self.ListAssets.reloadData()
    }
}

extension HomeView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllAssetsCell.cellForTableView(tableView: ListAssets)
        let Data = CategorySectionData[indexPath.row]
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
        cell.IconImage.backgroundColor = ColorForEachSection[Data.Category]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategorySectionData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapView = (self.storyboard?.instantiateViewController(identifier: "DetailSpending"))! as DetailSpending
        self.navigationController?.pushViewController(mapView, animated: true)
    }
}

extension HomeView{
    
    @objc func LeftView(sender: UIButton){
        pieChart.isHidden = !pieChart.isHidden
        InComePieChart.isHidden = !InComePieChart.isHidden
    }
    
    func ConfigPieChart(data: [String], ValueData: [Double]){
        var dataEntries: [ChartDataEntry] = []
        let dataPoints = data
        let values = ValueData
          for i in 0..<dataPoints.count {
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
        self.ColorForEachSection = ["Children": color1,
                                    "Service": color2,
                                    "Study": color3,
                                    "Health": color4,
                                    "Food": color5,
                                    "Vehicles": color6,
                                    "House": color7,
                                    "Gift": color8,
                                    "Bank": color9,
                                    "Entertain": color10,
                                    "Loan": color11,
                                    "Income": color12]
        
        var colors:[UIColor] = []
        
        for color in 0..<data.count{
            let UIcolor = ColorForEachSection[data[color]]
            colors.append(UIcolor!)
        }
        //let colors:[UIColor] = [color1,color2,color3,color4,color5,color6,color7,color8,color9,color10,color11,color12]
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
            pieChart.data = pieChartData
          //  InComePieChart.data = pieChartData
    }
    
    func AddConstraints(){
        var constraints = [NSLayoutConstraint]()
        
       constraints.append(ListAssets.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(ListAssets.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       constraints.append(ListAssets.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        constraints.append(ListAssets.topAnchor.constraint(equalTo: searchController.safeAreaLayoutGuide.bottomAnchor,constant: 0))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func ConfigureDataDetail(){
      //  var DataBase = [Details]()
        let MonthSection = (buttonTime.titleLabel?.text)!
        let path = UserDefaults.standard.string(forKey: "Username")
        let ref = Database.database(url: "https://mywallet-c06cf-default-rtdb.asia-southeast1.firebasedatabase.app").reference(withPath: path!).child("\(MonthSection)").child("DataHomeView")
        ref.observe(.value, with: { [self] (snapshot) in
          // cập nhật data
            CategorySectionData = []
            ArrayCategory = []
            TotalExpense = 0.0
            for children in snapshot.children {
              //  DataBase = []
                if let postSnapshot = children as? DataSnapshot {
                   // let key = postSnapshot.key
             if let Value = postSnapshot.childSnapshot(forPath: "Value").value as? String,
                let Category = postSnapshot.childSnapshot(forPath: "Category").value as? String{
                TotalExpense += CalculateAmount(Value)
//                let Data = Details(Note: Note, Value: Value, Key: key, Date: Date, Account: Account, Detail: Detail)
                print("TotalValue: \(Value)")
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
            if CategorySectionData.isEmpty{
               // self.pieChart.isHidden = true
                self.NoDataLabel.isHidden = false
            }else{
              //  self.pieChart.isHidden = false
                self.NoDataLabel.isHidden = true
            }
            var ArrayValue:[Double] = []
            for value in 0..<CategorySectionData.count{
                let perCentValue = ((CategorySectionData[value].TotalValue/TotalExpense)*100).rounded(toPlaces: 2)
                ArrayValue.append(perCentValue)
            }
            ConfigPieChart(data: ArrayCategory, ValueData: ArrayValue)
            print("TotalExpense: \(TotalExpense)")
            self.ListAssets.reloadData()
        })
    }

    @objc func HidingPickerView(sender: UIButton){
        picker.isHidden = !picker.isHidden
        pieChart.isHidden = !pieChart.isHidden
    }
    


    @objc func dateChanged(sender: MonthYearPickerView){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-YYYY"
        let DateFormatter = formatter.string(from: picker.date)
        buttonTime.setTitle("\(DateFormatter)", for: .normal)
        ConfigureDataDetail()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.picker.isHidden = !self.picker.isHidden
            self.pieChart.isHidden = !self.pieChart.isHidden
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
