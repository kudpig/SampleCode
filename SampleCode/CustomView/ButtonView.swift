//
//  ButtonView.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/04/18.
//

import UIKit

class ButtonView: UIView {
    
    static var identifier: String { String(describing: ButtonView.self) }

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    
    enum Section: Int {
        case fifth = 0, sixth = 1, seventh = 2, eighth = 3, none = 4
    }
    
    var nowSection: Section = .none
    
    // ここがうまくいかない
    @objc func tapTest() {
        print("\(nowSection)のセルがタップされました")
        //let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "Home") as! HomeViewController
        //Router.showList(fromVC: vc)
    }
    
    
    func buttonConfigure(number: String) {
        
        numberLabel.text = number
        nameLabel.text = "選択されていません(\(nowSection))"
        priceLabel.text = ""
        
        if itemImage.image != nil {
            itemImage.isHidden = false
        } else {
            itemImage.isHidden = true
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapTest))
        self.addGestureRecognizer(tap)
        
    }
    
}


//var itemImageStr: String?

//itemImageStr = ""
//
//if let str = itemImageStr {
//    itemImage.image = UIImage(named: str)
//}
