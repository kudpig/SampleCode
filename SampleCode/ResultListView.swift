//
//  ResultListView.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/05/01.
//

import UIKit

class ResultListView: UIView {
    
    static var identifier: String { String(describing: ResultListView.self) }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var noticeView: UIView!
    @IBOutlet private weak var noticeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        nameLabel.text = "選択されていません"
        priceLabel.text = ""
        noticeView.isHidden = true
        // 文字の潰れにくさの設定。priceは必ず表示し、nameは溢れたら...とする
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        // 文字のwidthの優先度設定。
        nameLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        priceLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
    }
        
    func configure(receiveItem: Item) {
            
        guard !receiveItem.name.isEmpty else {
            nameLabel.textColor = .systemPink
            return
        }
            
        nameLabel.text = receiveItem.name
        priceLabel.text = "\(String(receiveItem.price))円"
    }

}
