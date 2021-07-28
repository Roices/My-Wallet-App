//
//  AddViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 27/07/2021.
//

import UIKit

class AddViewController: UIViewController {

    
    let background : UIImageView = {
        let view = UIImageView(image: UIImage(named: "Background"))
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return view
    }()
    
    let Mainview : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15.0
        view.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
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
        // Do any additional setup after loading the view.
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

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionStuff.dequeueReusableCell(withReuseIdentifier: AddCell.identifier, for: indexPath) as! AddCell

      //  cell.configure(with: UIImage(named: "Food")!)
        return cell

    }


}


//extension AddViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 125, height: 125)
//    }
//}
