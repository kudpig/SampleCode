//
//  ConfirmSelectedItemsViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/05/01.
//

import UIKit

final class ConfirmSelectedItemsViewController: UIViewController {
    
    var receiveItems: [Item] = []
    
    @IBOutlet private weak var resultStackView: UIStackView! {
        didSet {
            setupResultStackView()
            // borderColorだけstoryboardで設定してもうまく起動しなかった
            resultStackView.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    
    @IBOutlet private weak var calculatePriceLabel: UILabel! {
        didSet {
            calculatePriceLabel.text = "合計 \(calculateItemPrice) 円"
        }
    }
    
    private func setupResultStackView() {
        
        for item in receiveItems {
    
            guard let contentView: ResultListView = UINib.init(nibName: ResultListView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as? ResultListView else {
                fatalError()
            }
            
            self.resultStackView.addArrangedSubview(contentView)
            contentView.configure(receiveItem: item)
        }
        
    }
    
    private var calculateItemPrice: Int {
        receiveItems.filter { !$0.name.isEmpty }.map { $0.price }.reduce(0) { $0 + $1 }
    }

}
