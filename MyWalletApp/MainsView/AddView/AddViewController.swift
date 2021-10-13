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
                   "Gift","Bank","Entertain"]
    
    let background : UIImageView = {
        let view = UIImageView(image: UIImage(named: "Background"))
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return view
    }()
    
    let Mainview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15.0
        view.frame = CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120)
        return view
    }()
    

    
    var CollectionStuff : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(background)
        view.addSubview(Mainview)
//        view.addSubview(CollectionStuff)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 40
        CollectionStuff = UICollectionView(frame: CGRect(x: 40, y: 80, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 150), collectionViewLayout: layout)
        CollectionStuff.register(AddCell.self, forCellWithReuseIdentifier: AddCell.identifier)
        CollectionStuff.delegate = self
        CollectionStuff.dataSource = self
        CollectionStuff.backgroundColor = .white
        Mainview.addSubview(CollectionStuff)
        
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

}

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Expense.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionStuff.dequeueReusableCell(withReuseIdentifier: AddCell.identifier, for: indexPath) as! AddCell
        cell.configure(Section: Expense[indexPath.item])
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

