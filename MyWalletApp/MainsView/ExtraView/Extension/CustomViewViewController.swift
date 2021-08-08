//
//  CustomViewViewController.swift
//  MyWalletApp
//
//  Created by Tuan on 01/08/2021.
//

import UIKit

class CustomViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}



extension UITextField {

enum Direction {
    case Left
    case Right
}
    

// add image to textfield
    func withImage(direction: Direction, image: UIImage){
    
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: 45))
    let imageView = UIImageView(image: image)

    if(Direction.Left == direction){ // image left
        self.leftViewMode = .always
        self.leftView = view
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 20.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
    } else { // image right
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = view
    }

}
    
   

}


extension UIButton{
    
    enum Direction{
        case left
        case right
    }
    
    func setImages(right: UIImage? = nil, left: UIImage? = nil) {
        if let leftImage = left, right == nil {
            setImage(leftImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: -20)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: (imageView?.frame.width)!)
            contentHorizontalAlignment = .left
        }
        if let rightImage = right, left == nil {
            setImage(rightImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: -20, bottom: 5, right: 20)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 10)
            contentHorizontalAlignment = .right
        }

        if let rightImage = right, let leftImage = left {
            setImage(rightImage, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: -20)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 10)
            contentHorizontalAlignment = .left

            let leftImageView = UIImageView(frame: CGRect(x: bounds.maxX - 55,
                                                          y: frame.height/2 - 15,
                                                          width: 50,
                                                          height: 30))
           // leftImageView.backgroundColor = .purple
            leftImageView.image?.withRenderingMode(.alwaysOriginal)
            leftImageView.image = leftImage
            leftImageView.contentMode = .scaleAspectFit
            leftImageView.layer.masksToBounds = true
           addSubview(leftImageView)
        }

    }

}
