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
    private lazy var selectItems = [Item](repeating: Item.createEmpty(), count: titles.count)
    
    // 押されたボタンの状態管理
    enum WhichBtn: Int, CaseIterable {
        case first = 0, second, third, fourth, fifth, sixth, seventh, eighth, none
    }
    var buttonStatus: WhichBtn = .none
    
    

    private var titles = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th"]
    
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
    
        for (index, title) in titles.enumerated() {
    
            guard let contentView: ButtonView = UINib.init(nibName: ButtonView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil).first as? ButtonView else {
                fatalError()
            }
            
            contentView.nowSection = ButtonView.Section(rawValue: index) ?? .none
            contentView.delegate = self
    
            contentView.layer.cornerRadius = 40
            self.stackView.addArrangedSubview(contentView)
            contentView.update(titleData: title)
            
            contents.append(contentView)
        }
    
    }



    @IBAction func tapResetButton(_ sender: UIButton) {
        
        for (index, _) in selectItems.enumerated() {
            // 配列の中身を空のItemにする
            let clearItem = Item.createEmpty()
            selectItems[index] = clearItem
            
            // 表示を初期値に変更する
            contents[index].update(titleData: titles[index])
            
            // リセット後のtotalPriceLabelを再表示する
            totalPriceLabel.text = "合計 \(sumItemPrice) 円"
        }
    }
    
}


extension HomeViewController: ToPassDataProtocol {
    
    // TableViewCellがタップされた時の処理
    func cellDidSelect(cellData: Item) {
        
        switch buttonStatus {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth:
            // Viewの情報更新処理
            contents[buttonStatus.rawValue].configure(cellData: cellData)
            // Itemを配列に格納する
            selectItems[buttonStatus.rawValue] = cellData
        default:
            break
        }
        
        // totalPriceLabelを更新
        totalPriceLabel.text = "合計 \(sumItemPrice) 円"
        
    }
    
}

extension HomeViewController: ButtonViewProtocol {
    
    // ButtonViewがタップされた時の処理
    func tapButton(section: Int) {
        // buttonStatusの更新(どのボタンが押されたかの情報を取得し、画面遷移を行う)
        buttonStatus = WhichBtn(rawValue: section) ?? .none
        Router.showList(fromVC: self)
    }
    
}
