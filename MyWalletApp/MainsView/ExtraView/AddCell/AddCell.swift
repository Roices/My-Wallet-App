//
//  AddCell.swift
//  MyWalletApp
//
//  Created by Tuan on 27/07/2021.
//

import UIKit

class AddCell: UICollectionViewCell {

    static let identifier = "AddCell"
    
     var ImageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "Food"))
        view.contentMode = .scaleAspectFit
//        view.layer.borderWidth = 0.25
//        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 0.25
        return view
    }()
    
     var Label : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
        //    label.layer.cornerRadius = 10.0
      //  label.backgroundColor = .cyan
        
        return label
    }()
    
     var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.25
       // view.layer.cornerRadius = 10.0
        view.layer.shadowOffset = CGSize(width: 10, height: -10)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
            view.layer.shadowRadius = 10.0
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(view)
        contentView.addSubview(ImageView)
        contentView.addSubview(Label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        view.frame  = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
        Label.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 30)
        //Label.layer.cornerRadius = 5.0
       // Label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        ImageView.frame = CGRect(x: 0, y: 30, width: contentView.frame.size.width, height: contentView.frame.size.height - 30)
        
    }
    
    func configure(Section: String){
        
        ImageView.image = UIImage(named: Section)
        Label.text = Section
        
        
    }

}
