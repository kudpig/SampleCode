//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    // 押されたボタンをcaseで分ける
    enum WhichBtn: String {
        case none = "noneBtn"
        case first = "firstBtn"
        case second = "secondBtn"
    }
    
    // 一番直近のタップされたボタンを判別する変数
    var nowButton: WhichBtn = .none // 初期値はボタンを押していないのでcase none
    // 選択されたセルのrowを取得
    var firstItemRowNumber: Int? = nil
    var secondItemRowNumber: Int? = nil
    // Label 初期値
    var itemLabelPlaceholder: String = "選択されていません"
    
    // １つ目のラベル
    @IBOutlet weak var firstItemLabel: UILabel! {
        didSet {
            // tableViewCellから値を受け取っていた場合にtextの内容を変える処理
            if let rowNum = firstItemRowNumber {
                firstItemLabel.text = foods[rowNum].name
            } else {
                firstItemLabel.text = itemLabelPlaceholder
            }
        }
    }
    // ２つ目のラベル
    @IBOutlet weak var secondItemLabel: UILabel! {
        didSet {
            if let rowNum = secondItemRowNumber {
                secondItemLabel.text = foods[rowNum].name
            } else {
                secondItemLabel.text = itemLabelPlaceholder
            }
        }
    }
    // ３つ目のラベル(TotalPrice)
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            // 合計金額の算出のためsumPriceメソッドを実行、引数として選択されたcellRowを渡す。関数内でアンラップするのでnilでも問題ない
            totalPriceLabel.text = "合計 \(sumPrice(firstRowNum: firstItemRowNumber, secondRowNum: secondItemRowNumber)) 円"
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    // totalPrice計算メソッド
    func sumPrice(firstRowNum: Int?, secondRowNum: Int?) -> Int {
        
        let firstPrice: Int
        let secondPrice: Int
        
        // if letを使用し、nilの場合は0を代入する
        if let rowNum = firstRowNum {
            firstPrice = foods[rowNum].price
        } else {
            firstPrice = 0
        }
        
        if let rowNum = secondRowNum {
            secondPrice = foods[rowNum].price
        } else {
            secondPrice = 0
        }
        
        return firstPrice + secondPrice
    }
    
    
    // ButtonAciton Funcs
    // 画面遷移の前に押したボタン変数を更新する
    @IBAction func tapFirstSelectButton(_ sender: UIButton) {
        nowButton = .first
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    @IBAction func tapSecondSelectButton(_ sender: UIButton) {
        nowButton = .second
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    
}

