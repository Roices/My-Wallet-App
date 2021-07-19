//
//  HomeView.swift
//  MyWalletApp
//
//  Created by Tuan on 09/07/2021.
//

import UIKit
import Charts

class HomeView: UIViewController,ChartViewDelegate{
 
    let players = ["All Assets", "Loan", "Cash"]
    let goals = [66, 12 , 27]
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
    
    
    
  lazy var pieChart:PieChartView = {
    let pieChart = Charts.PieChartView()
    
    var dataEntries: [ChartDataEntry] = []
    let dataPoints = players
    let values = goals.map{ Double($0) }
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
    let color1 = UIColor(hexString: "FF6E2E")
    let color2 = UIColor(hexString: "00B358")
    let color3 = UIColor(hexString: "137FEC")
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
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        pieChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 12)!)
        pieChartData.setValueTextColor(.white)
        pieChartDataSet.sliceSpace = 3
        pieChart.data = pieChartData
      // 4. Assign it to the chart’s data
    let legend = pieChart.legend
        legend.horizontalAlignment = .center
        legend.font = UIFont.systemFont(ofSize: 14)
        legend.xEntrySpace = 170
    pieChart.frame.size.width = 320 // 0.75 * UIScreen.main.bounds.width
    pieChart.frame.size.height =  320 //0.4 * UIScreen.main.bounds.height
    pieChart.center = ViewForChart.center
    pieChart.holeRadiusPercent = 0.65
    pieChart.drawEntryLabelsEnabled = false
    pieChart.chartDescription?.text = ""
    return pieChart
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
        ViewForChart.backgroundColor = .systemPink
        ViewForChart.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - 225)/2)
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
        let y = (UIScreen.main.bounds.height - 200)/2 + 85
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 50), buttonTitle: ["All Assets","Cash","Loan"])
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeSegmented.delegate = self
        ListAssets.delegate = self
        ListAssets.dataSource = self
        searchController.delegate = self
        filterData = RowToDisplay

        
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBarController?.tabBar.layer.shadowRadius = 8
        tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController?.tabBar.layer.shadowOpacity = 0.3
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        view.addSubview(BackGroundImage)
        view.addSubview(MainView)
        view.addSubview(pieChart)
        view.addSubview(codeSegmented)
        view.addSubview(searchController)
        view.addSubview(ListAssets)
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
        return cell

//        let cell = UITableViewCell()
//               cell.textLabel?.text = filterData[indexPath.row]
//               return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
}
