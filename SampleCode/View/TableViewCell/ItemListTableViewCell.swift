//
//  ItemListTableViewCell.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // cell呼び出し用のIDを設定 ハードコーディングを回避する
    static var identifier: String { String(describing: ItemListTableViewCell.self) }

    // cellが再利用される直前に呼ばれる。中身をデフォルトのものにする
    override func prepareForReuse() {
        super.prepareForReuse()
    
        iconImage.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
    }
    
    // 値を更新する処理。外部から呼ばせて代入する
    func configure(item: Item) {
        
        iconImage.image = UIImage(named: item.image)
        nameLabel.text = item.name
        priceLabel.text = "\(item.price)円"
    }
    
}
