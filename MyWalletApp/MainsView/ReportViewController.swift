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
    let goals = [400000, 800000]
    
    //InCome and Expense
    
    
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
        scrollView.layer.cornerRadius = 15.0
        
       return scrollView
    }()
    
    
    
    let IncomeLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.width/4 + 50 + 15, y: UIScreen.main.bounds.height/4 - 20 + 5, width: 150, height: 40)
        label.text = "Income"
       // label.backgroundColor = .blue
        return label
    }()
    
    let IncomeMoneyTitle: UILabel = {
        let label = UILabel()
        let green = UIColor(hexString: "5CDD5B")
        label.frame = CGRect(x: UIScreen.main.bounds.width - 150 - 25, y: UIScreen.main.bounds.height/4 - 20 + 5, width: 150, height: 40)
        label.text = "100.000.000đ"
        label.textColor = green
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17.0)

        return label
    }()
 
    let IncomeView : UIView = {
        let view = UIView()
        let green = UIColor(hexString: "5CDD5B")
        view.frame = CGRect(x: UIScreen.main.bounds.width/4 + 50, y: UIScreen.main.bounds.height/4   , width: 10, height: 10)
        view.backgroundColor = green
      //  view.layer.cornerRadius = 7
        return view
    }()
    
    
    let ExpenseLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.width/4 + 50 + 15, y: UIScreen.main.bounds.height/4 - 50 - 20 + 5, width: 150, height: 40)
        label.text = "Expened"
     //   label.backgroundColor = .red
        return label
    }()
    
    let ExpenseView : UIView = {
        let view = UIView()
        let red = UIColor(hexString: "E64947")
        view.frame = CGRect(x: UIScreen.main.bounds.width/4 + 50, y: UIScreen.main.bounds.height/4 - 50, width: 10, height: 10)
        view.backgroundColor = red
   //     view.layer.cornerRadius = 7
        return view
    }()
    
    let ExpenseMoneyTitle: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.width - 150 - 25, y: UIScreen.main.bounds.height/4 - 50 - 20 + 5, width: 150, height: 40)
        label.text = "100.000.000đ"
        let red = UIColor(hexString: "E64947")
        label.textColor = red
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()
    
    
    
    
    lazy var BarChart : BarChartView = {
        let BarChart = BarChartView()
        BarChart.frame = CGRect(x: 25, y: 100, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/4)
      //  BarChart.frame = CGRect(x: 25, y: 300, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
        
        var dataEntries: [BarChartDataEntry] = []
        let dataPoints = players
        let values = goals.map{ Double($0) }
          for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
          }
        
        BarChart.leftAxis.axisMinimum = 0
        BarChart.rightAxis.axisMinimum = 0
        BarChart.leftAxis.drawAxisLineEnabled = false
        BarChart.rightAxis.drawAxisLineEnabled = false
        BarChart.dragXEnabled = false
     
        
        BarChart.xAxis.enabled = false
        BarChart.leftAxis.enabled = false
        BarChart.rightAxis.enabled = false
        BarChart.drawBordersEnabled = false
        BarChart.minOffset = 0
        BarChart.legend.enabled = false
//
        
        let red = UIColor(hexString: "E64947")
        let green = UIColor(hexString: "5CDD5B")
        let BarChartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        BarChartDataSet.drawValuesEnabled = false
        BarChartDataSet.valueFont = UIFont.systemFont(ofSize: 11)
        BarChartDataSet.colors = [red,green]
        
        
        
        let BarChartData = BarChartData(dataSet: BarChartDataSet)
        BarChart.data = BarChartData
        
        
        return BarChart
    }()
    
    
    let Month: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 20)
        label.text = "September"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let line1: UIView = {
        let line = UIView()
        line.frame = CGRect(x: 80, y: 65, width: UIScreen.main.bounds.width - 160, height: 1)
        line.backgroundColor = .lightGray
        return line
    }()
    
    
    let line2 : UIView = {
        let line = UIView()
        line.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/4 + 150, width: UIScreen.main.bounds.width, height: 4)
        line.backgroundColor = .lightGray
        return line
    }()
    
    
    // Spending Limit
    
    let SpendingLimitLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: UIScreen.main.bounds.height/4 + 150 + 30, width: 200, height: 30)
        label.text = "Spending limit"
      //  label.textAlignment = .lef
        
        return label
    }()
    
    let StuffView: UIImageView  = {
        let view = UIImageView(image: UIImage(named: "Wallet"))
        view.frame = CGRect(x: 25, y: UIScreen.main.bounds.height/4 + 220, width: 60, height: 60)
        return view
    }()
    
    let UserAcountLabel : UILabel = {
       let label = UILabel()
        label.text = "User Acount"
        label.frame = CGRect(x: 105, y: UIScreen.main.bounds.height/4 + 220, width: 200, height: 20)
        return label
    }()
    
    let MonthForSpending: UILabel = {
        let label = UILabel()
        label.text = "September"
        label.frame = CGRect(x: 105, y: UIScreen.main.bounds.height/4 + 220 + 25, width: 85, height: 20)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    let MoneyLimited : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: UIScreen.main.bounds.width - 25 - 150, y: UIScreen.main.bounds.height/4 + 220 + 25, width: 150, height: 20)
        label.text = "1.000.000.000đ"
        label.textAlignment  = .right
        return label
    }()
    
    
    let Progress: UIProgressView = {
        let progress = UIProgressView()
        progress.frame = CGRect(x: 20, y:  UIScreen.main.bounds.height/4 + 300, width: UIScreen.main.bounds.width - 40, height: 100)
       // progress.backgroundColor = .purple
      //  progress.tintColor = .green
        progress.progress = 0.5
        return progress
    }()
    
    let RemainLabel : UILabel = {
        let label = UILabel()
        label.text = "Remain:"
        label.frame = CGRect(x: 25, y: UIScreen.main.bounds.height/4 + 320, width: 75, height: 20)
        return label
    }()
    
    let MoneyRemain : UILabel = {
        let label = UILabel()
        label.text = "500.000.000đ"
        label.frame = CGRect(x: UIScreen.main.bounds.width - 25 - 150, y: UIScreen.main.bounds.height/4 + 320, width: 150, height: 20)
        label.textAlignment = .right
        return label
    }()
    
    
    let line3 : UIView = {
        let line = UIView()
        line.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/4 + 380, width: UIScreen.main.bounds.width, height: 4)
        line.backgroundColor = .lightGray
        return line
    }()
    //savings-book
    
    let Accumulate : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 25, y: UIScreen.main.bounds.height/4 + 400, width: 150, height: 20)
        label.text = "Accumulate"
        return label
    }()
    
    let frameAccountAccumulate : UIView = {
        let view = UIView()
        let green = UIColor(hexString: "5CDD5B")
        view.frame = CGRect(x: 25, y: UIScreen.main.bounds.height/4 + 440, width: UIScreen.main.bounds.width - 50, height: 160)
        view.backgroundColor = green
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 0.25
        return view
    }()
    
    let frameAccumulate : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 25, y: UIScreen.main.bounds.height/4 + 480, width: UIScreen.main.bounds.width - 50, height: 120)
        view.backgroundColor = .white
        view.layer.borderWidth = 0.25
        return view
    }()

    
    let UserAccumulateAccount : UILabel = {
        let label = UILabel()
        label.text = "User Account"
        label.frame = CGRect(x: 45, y: UIScreen.main.bounds.height/4 + 440 + 10, width: 150, height: 20)
        return label
    }()
    
    let AccumulateMoney : UILabel = {
        let label = UILabel()
        label.text  = "10.000.000đ"
        label.frame = CGRect(x: 45, y: UIScreen.main.bounds.height/4 + 510, width: 150, height: 20)
        return label
    }()
    
    let AccProgress : UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.5
        progress.frame = CGRect(x: 45, y: UIScreen.main.bounds.height/4 + 540, width: UIScreen.main.bounds.width - 90, height: 50)
        return progress
    }()
    
    let Target : UILabel = {
        let label = UILabel()
        label.text = "Target: Buy a Car"
        label.frame = CGRect(x: 45, y: UIScreen.main.bounds.height/4 + 560, width: 150, height: 20)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
      //  label.backgroundColor = .purple
        return label
    }()
    
    
    let line4 : UIView = {
        let line = UIView()
        line.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/4 + 660, width: UIScreen.main.bounds.width, height: 4)
        line.backgroundColor = .lightGray
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(Background)
        view.addSubview(scrollView)
 
        scrollView.addSubview(BarChart)
        scrollView.addSubview(IncomeView)
        scrollView.addSubview(ExpenseView)
        scrollView.addSubview(IncomeLabel)
        scrollView.addSubview(ExpenseLabel)
        scrollView.addSubview(IncomeMoneyTitle)
        scrollView.addSubview(ExpenseMoneyTitle)
        scrollView.addSubview(Month)
        scrollView.addSubview(line1)
        scrollView.addSubview(line2)
        
        
        //Spending Limit
        scrollView.addSubview(SpendingLimitLabel)
        scrollView.addSubview(StuffView)
        scrollView.addSubview(UserAcountLabel)
        scrollView.addSubview(MonthForSpending)
        scrollView.addSubview(Progress)
        scrollView.addSubview(MoneyLimited)
        scrollView.addSubview(RemainLabel)
        scrollView.addSubview(MoneyRemain)
        scrollView.addSubview(line3)
        
        //Accumulate
        scrollView.addSubview(Accumulate)
        scrollView.addSubview(frameAccountAccumulate)
        scrollView.addSubview(frameAccumulate)
        scrollView.addSubview(UserAccumulateAccount)
        scrollView.addSubview(AccumulateMoney)
        scrollView.addSubview(AccProgress)
        scrollView.addSubview(Target)
        scrollView.addSubview(line4)
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



