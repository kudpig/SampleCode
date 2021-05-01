//
//  ResultViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/05/01.
//

import UIKit

class ResultViewController: UIViewController {
    
    var receiveItems: [Item] = []
    
    @IBOutlet private weak var resultStackView: UIStackView! {
        didSet {
            setupResultStackView()
            resultStackView.axis = .vertical
            resultStackView.distribution = .fillEqually
            resultStackView.backgroundColor = .darkGray
            resultStackView.spacing = 2
            resultStackView.layer.borderColor = UIColor.darkGray.cgColor
            resultStackView.layer.borderWidth = 2
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
        get {
            receiveItems.filter { (item) -> Bool in
                !item.name.isEmpty
            }.map { (item) -> Int in
                item.price
            }.reduce(0) { (result, price) -> Int in
                result + price
            }
        }
    }

}
