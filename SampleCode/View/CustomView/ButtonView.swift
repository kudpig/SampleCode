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
    
    enum Section: Int, CaseIterable {
        case first = 0, second, third, fourth, fifth, sixth, seventh, eighth, none
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
        
    }
    
    // ボタンの生成時及びリセットボタン実行時
    func update(titleData: String) {
        numberLabel.text = titleData
        nameLabel.text = "選択されていません"
        priceLabel.text = ""
        itemImage.image = nil
        itemImage.isHidden = itemImage.image == nil
    }
    
    // VCからItemを受け取り、情報を更新
    func configure(cellData: Item) {
        nameLabel.text = cellData.name
        priceLabel.text = String(cellData.price)
        itemImage.image = UIImage(named: cellData.image)
        itemImage.isHidden = itemImage.image == nil
    }
    
}
