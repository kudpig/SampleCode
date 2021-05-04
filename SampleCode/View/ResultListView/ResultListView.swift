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
