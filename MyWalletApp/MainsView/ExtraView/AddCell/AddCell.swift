//
//  AddCell.swift
//  MyWalletApp
//
//  Created by Tuan on 27/07/2021.
//

import UIKit

class AddCell: UICollectionViewCell {

    static let identifier = "AddCell"
    
    private var ImageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "Food"))
        view.contentMode = .scaleAspectFit
//        view.layer.borderWidth = 0.25
//        view.layer.cornerRadius = 10.0
        return view
    }()
    
    private var Label : UILabel = {
        let label = UILabel()
        label.text = "123456789123456"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
            label.layer.cornerRadius = 10.0
      //  label.backgroundColor = .cyan
        
        return label
    }()
    
    private var view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 0.25
        view.layer.cornerRadius = 10.0
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
        
        ImageView.frame = CGRect(x: 0, y: 30, width: contentView.frame.size.width, height: contentView.frame.size.height - 30)
    }
    

}
