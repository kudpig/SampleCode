//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            totalPriceLabel.text = "合計 \(sumItemPrice) 円"
        }
    }
    // メモ String型はisEmptyメソッドを持つ
    private var sumItemPrice: Int {
        get {
            selectItems.filter { (item) -> Bool in
                !item.name.isEmpty
            }.map { (item) -> Int in
                item.price
            }.reduce(0) { (result, price) -> Int in
                result + price
            }
        }
    }
    
    
    private lazy var items = Item.createDefaultItems()
    // 選択されたものを配列に加える。初期値は全てEmptyとする
    private lazy var selectItems = [Item](repeating: Item.createEmpty(), count: 8)
    
    // 押されたボタンの状態管理
    enum WhichBtn: Int {
        case first = 0, second = 1, third = 2, fourth = 3, fifth = 4, sixth = 5, seventh = 6, eighth = 7, none = 8
    }
    var buttonStatus: WhichBtn = .none




    private var numbers = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th"]
    
    var contents: [ButtonView] = []
    
    
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            setupStackView()
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 25
        }
    }
    
    func setupStackView() {
    
        for (index, number) in numbers.enumerated() {
    
            guard let contentView: ButtonView = UINib.init(nibName: ButtonView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as? ButtonView else {
                fatalError()
            }
            
            contentView.nowSection = ButtonView.Section(rawValue: index) ?? .none
            contentView.delegate = self
    
            contentView.layer.cornerRadius = 40
            self.stackView.addArrangedSubview(contentView)
            contentView.update(number: number)
            
            contents.append(contentView)
        }
    
    }



    @IBAction func tapResetButton(_ sender: UIButton) {
        
        for (index, _) in selectItems.enumerated() {
            
            if index >= 4 {
                // 配列の中身を空のItemにする
                let clearItem = Item.createEmpty()
                selectItems[index] = clearItem
                // 表示を初期値に変更する
                let numberIndex = numbers[index - 4]
                contents[index - 4].update(number: numberIndex)
                // リセット後のtotalPriceLabelを再表示する
                totalPriceLabel.text = "合計 \(sumItemPrice) 円"
            }
            
        }
        
    }
    
}


extension HomeViewController: ToPassDataProtocol {
    
    // cellがタップされた時の処理
    func cellDidSelect(cellData: Item) {
        
        switch buttonStatus {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth:
            // Viewの情報更新処理
            contents[buttonStatus.rawValue - 4].configure(cellData: cellData)
            // Itemを配列に格納する
            selectItems[buttonStatus.rawValue] = cellData
        default:
            break
        }
        
        totalPriceLabel.text = "合計 \(sumItemPrice) 円"
        
    }
    
}

extension HomeViewController: ButtonViewProtocol {
    func tapButton(section: Int) {
        let newSection = (section + 4)
        buttonStatus = WhichBtn(rawValue: newSection) ?? .none
        Router.showList(fromVC: self)
    }
    
}
