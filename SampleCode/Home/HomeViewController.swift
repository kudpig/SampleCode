//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    var buttonStatus: WhichBtn = .none
    
    
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
    
    private var sumFoodPrice: Int { selectFoods.filter{ !$0.name.isEmpty }.map { $0.price }.reduce(0) { $0 + $1 } }
    // メモ String型はisEmptyメソッドを持つ
    
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            // 合計金額の算出のためsumPriceメソッドを実行、引数として選択されたcellRowを渡す。関数内でアンラップするのでnilでも問題ない
            totalPriceLabel.text = "合計 \(sumFoodPrice) 円"
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
        buttonStatus = .first
        let listTableVC = UIStoryboard(name: "ListTable", bundle: nil).instantiateViewController(identifier: "ListTable") as! ListTableViewController
        listTableVC.delegate = self
        
        if let nav = self.navigationController {
            nav.pushViewController(listTableVC, animated: true)
        } else {
            self.present(listTableVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapSecondSelectButton(_ sender: UIButton) {
        buttonStatus = .second
        let listTableVC = UIStoryboard(name: "ListTable", bundle: nil).instantiateViewController(identifier: "ListTable") as! ListTableViewController
        listTableVC.delegate = self
        
        if let nav = self.navigationController {
            nav.pushViewController(listTableVC, animated: true)
        } else {
            self.present(listTableVC, animated: true, completion: nil)
        }
    }
    
}


extension HomeViewController: ToPassDataProtocol {
    
    // cellがタップされた時の処理
    func cellDidSelect(cellData: Food) {
        print("デリゲートが実行されました")
        switch buttonStatus {
        // ボタンの状態がfirstもしくはsecondだった場合
        case .first, .second:
            // labelsに格納されている配列の順番と、buttonStatusのenumのIntを一致させている
            labels[buttonStatus.rawValue]?.text = cellData.name
            // 選択されたFoodオブジェクトを配列に格納する(結果画面に渡せるように)
            selectFoods[buttonStatus.rawValue] = cellData
        default:
            break
        }
        // 確認用
        print("~~selectFoodsを出力~~")
        print(selectFoods)
    }
    
}
