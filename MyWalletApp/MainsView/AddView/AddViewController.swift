//
//  AddViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 27/07/2021.
//

import UIKit

class AddViewController: UIViewController {
    lazy var Selected : String = ""

    let Expense = ["Children","Service","Study",
                   "Health","Food",
                   "Vehicles","House",
                   "Gift","Bank","Entertain","Loan","Income"]
    lazy var ColorForEachCategorySection : [String:UIColor] = [:]
    
    let background : UIImageView = {
        let view = UIImageView(image: UIImage(named: "Background"))
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return view
    }()
    
    let Mainview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 0, y: 0.111*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.889)
        return view
    }()
    
    let Title : UILabel = {
        let title = UILabel()
        title.text = "Add"
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.textColor = .white
        title.textAlignment = .center
        return title
    }()
    
    
    var CollectionStuff : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(background)
        view.addSubview(Mainview)
        view.addSubview(Title)
//        view.addSubview(CollectionStuff)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 0.089*UIScreen.main.bounds.height, height: 0.089*UIScreen.main.bounds.height)
        layout.minimumLineSpacing = 0.044*UIScreen.main.bounds.height
        CollectionStuff = UICollectionView(frame: CGRect(x: 40, y: 0.09*UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 150), collectionViewLayout: layout)
        CollectionStuff.register(AddCell.self, forCellWithReuseIdentifier: AddCell.identifier)
        CollectionStuff.delegate = self
        CollectionStuff.dataSource = self
        CollectionStuff.backgroundColor = .white
        Mainview.addSubview(CollectionStuff)
        
        self.navigationController?.navigationBar.isHidden = true
        
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
        // Do any additional setup after loading the view.
        
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

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Expense.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionStuff.dequeueReusableCell(withReuseIdentifier: AddCell.identifier, for: indexPath) as! AddCell
        
        cell.configure(Section: Expense[indexPath.item])
        cell.ImageView.backgroundColor = ColorForEachCategorySection[Expense[indexPath.item]]
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mapview = (self.storyboard?.instantiateViewController(identifier: "AddDetailView"))! as AddDetailView
        mapview.SelectedArray = Expense[indexPath.item]
        mapview.SelectedLabel = Expense[indexPath.item]
        self.navigationController?.pushViewController(mapview, animated: true)
//        present(mapview, animated: true, completion: nil)
    }


}

