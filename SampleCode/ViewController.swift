//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    /// 選択されたセルのrowを取得
    var firstSelectedRow: Int? = nil
    /// firstItemLabel 初期値
    var firstItemLabelPlaceholder: String = "選択されていません"
    
    @IBOutlet weak var firstItemLabel: UILabel! {
        didSet {
            // tableViewCellから値を受け取っていた場合にtextの内容を変える処理
            // さすがにリファクタするべきだと思うからそのうちやる
            if firstSelectedRow != nil {
                firstItemLabel.text = String(firstSelectedRow!)
            } else {
                firstItemLabel.text = firstItemLabelPlaceholder
            }
        }
    }
    
    @IBOutlet weak var secondItemLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var firstSelectButton: UIButton! {
        didSet {
            firstSelectButton.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var secondSelectButton: UIButton! {
        didSet {
            secondSelectButton.layer.cornerRadius = 40
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    @IBAction func tapFirstSelectButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    

    @IBAction func tapSecondSelectButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    
}

