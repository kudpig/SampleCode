//
//  ButtonView.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/04/18.
//

import UIKit

protocol ButtonViewProtocol: AnyObject {
    func tapButton(section: Int)
}

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
    
    var delegate: ButtonViewProtocol?
    
    @objc func tapTest() {
        delegate?.tapButton(section: nowSection.rawValue)
    }
    
    // nibが生成された時に１度だけ呼ばれる
    // デフォルト(初期値など)の情報を持たせるときに使用する
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapTest))
        self.addGestureRecognizer(tap)
        
        nameLabel.text = "選択されていません"
        priceLabel.text = ""
        itemImage.image = nil
        itemImage.isHidden = itemImage.image == nil
    }
    
    // ボタンの生成時
    func update(number: String) {
        numberLabel.text = number
    }
    
    // VCからItemを受け取り、情報を更新
    func configure(cellData: Item) {
        nameLabel.text = cellData.name
        priceLabel.text = String(cellData.price)
        itemImage.image = UIImage(named: cellData.image)
        itemImage.isHidden = itemImage.image == nil
    }
    
}
