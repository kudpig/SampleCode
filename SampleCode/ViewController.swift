//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var foods = Food.createDefaultFoods()
    
    // Label 初期値
    var itemLabelPlaceholder: String = "選択されていません"
    //FIX nameを表示するラベルを配列にする(上記の２つ)
    private lazy var labels = [firstItemLabel, secondItemLabel]
    //FIX 選択したものを配列にしている。初期値は全てEmptyとなっている
    private lazy var selectFoods = [Food](repeating: Food.createEmpty(), count: labels.count)
    
    // 押されたボタンの状態管理
    enum WhichBtn: Int {
        case first = 0, second = 1, none = 2
    }
    var nowButton: WhichBtn = .none
    
    
    // １つ目のラベル
    @IBOutlet weak var firstItemLabel: UILabel! {
        didSet {
            firstItemLabel.text = itemLabelPlaceholder
        }
    }
    // ２つ目のラベル
    @IBOutlet weak var secondItemLabel: UILabel! {
        didSet {
            secondItemLabel.text = itemLabelPlaceholder
        }
    }
    // ３つ目のラベル(TotalPrice)
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            // 合計金額の算出のためsumPriceメソッドを実行、引数として選択されたcellRowを渡す。関数内でアンラップするのでnilでも問題ない
            totalPriceLabel.text = "○○○円"
        }
    }
    
    
    
    
    // １つ目のボタン
    @IBOutlet weak var firstSelectButton: UIButton! {
        didSet {
            firstSelectButton.layer.cornerRadius = 40
        }
    }
    // ２つ目のボタン
    @IBOutlet weak var secondSelectButton: UIButton! {
        didSet {
            secondSelectButton.layer.cornerRadius = 40
        }
    }
        
    // ButtonAciton Funcs
    // 画面遷移の前に押したボタン変数を更新する
    @IBAction func tapFirstSelectButton(_ sender: UIButton) {
        nowButton = .first
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ItemListViewController") as! ItemListViewController
        vc.delegate = self
        print(vc.delegate)
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    @IBAction func tapSecondSelectButton(_ sender: UIButton) {
        nowButton = .second
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ItemListViewController") as! ItemListViewController
        vc.delegate = self
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    
}


extension ViewController: ToPassItemProtocol {
    func selectedItem(cellItem: Food) {
        print("実行されました")
    }
    
    
    // cellがタップされるとselectedItemのfoodが上書きされ、ViewControllerの持つ値が更新される
    //func selectedItem(cellItem: Food) {
    //    print("selectedItemを実行しています")
    //
    //    switch nowButton {
    //    // ボタンの状態がfirstもしくはsecondだった場合
    //    case .first, .second:
    //        // labelsに格納されている配列の順番と、nowButtonのenumのIntを一致させている
    //        labels[nowButton.rawValue]?.text = cellItem.name
    //        print("labelsにfoodnameを代入します")
    //        // 選択されたFoodオブジェクトを配列に格納する(結果画面に渡せるように)
    //        selectFoods[nowButton.rawValue] = cellItem
    //    default:
    //        break
    //    }
    //}
    
    
    
}
