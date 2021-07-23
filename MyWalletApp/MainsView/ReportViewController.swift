//
//  ReportViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 22/07/2021.
//

import UIKit
import Charts

class ReportViewController: UIViewController {


    
    let players = ["All Assets", "Loan"]
    let goals = [12000000, 8000000]
    
    
    let Background : UIImageView = {
        let Background = UIImageView(image: UIImage(named: "Background"))
        Background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return Background
    }()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2*UIScreen.main.bounds.height)
       scrollView.backgroundColor = .white
        
       return scrollView
    }()
    
    
    
    
    let ViewBarChart : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        view.layer.borderWidth = 2.0
        return view
    }()
    
    
    let IncomeLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/4 - 50 - 20 + 7, width: 150, height: 40)
        label.text = "Income"
       // label.backgroundColor = .blue
        return label
    }()
    
    
 
    let IncomeView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/4 - 50  , width: 14, height: 14)
        view.backgroundColor = .green
        view.layer.cornerRadius = 7
        return view
    }()
    
    
    let ExpenseLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/4 - 150 - 20 + 7, width: 150, height: 40)
        label.text = "Expense"
     //   label.backgroundColor = .red
        return label
    }()
    
    let ExpenseView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/4 - 150, width: 14, height: 14)
        view.backgroundColor = .red
        view.layer.cornerRadius = 7
        return view
    }()
    
    
    
    
    lazy var BarChart : BarChartView = {
        let BarChart = BarChartView()
        BarChart.frame = CGRect(x: 25, y: 50, width: UIScreen.main.bounds.width/4 + 50, height: UIScreen.main.bounds.height/4)
        
        var dataEntries: [BarChartDataEntry] = []
        let dataPoints = players
        let values = goals.map{ Double($0) }
          for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i])
            dataEntries.append(dataEntry)
          }
//        BarChart.leftAxis.drawAxisLineEnabled = false
//        BarChart.rightAxis.drawAxisLineEnabled = false
//        BarChart.dragXEnabled = false
//        BarChart.drawline
        
        BarChart.xAxis.enabled = false
        BarChart.leftAxis.enabled = false
        BarChart.rightAxis.enabled = false
        BarChart.drawBordersEnabled = false
        BarChart.minOffset = 0
        BarChart.legend.enabled = false
      
        
        let BarChartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
      //  BarChartDataSet.drawValuesEnabled = false
        BarChartDataSet.valueFont = UIFont.systemFont(ofSize: 11)
        let BarChartData = BarChartData(dataSet: BarChartDataSet)
        BarChart.data = BarChartData
        
        
        return BarChart
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(Background)
        view.addSubview(scrollView)
     //   BarChart.center = view.center'
     //   ViewBarChart.addSubview(BarChart)
        scrollView.addSubview(ViewBarChart)
        scrollView.addSubview(BarChart)
        scrollView.addSubview(IncomeView)
        scrollView.addSubview(ExpenseView)
        scrollView.addSubview(IncomeLabel)
        scrollView.addSubview(ExpenseLabel)
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
