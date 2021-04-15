//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    // View
    @IBOutlet weak var firstItemView: UIView! {
        didSet {
            createItemView(firstItemView, 40, .white)
        }
    }
    
    @IBOutlet weak var secondItemView: UIView! {
        didSet {
            createItemView(secondItemView, 40, .white)
        }
    }
    
    @IBOutlet weak var thirdItemView: UIView! {
        didSet {
            createItemView(thirdItemView, 40, .white)
        }
    }
    
    @IBOutlet weak var fourthItemView: UIView! {
        didSet {
            createItemView(fourthItemView, 40, .white)
        }
    }
    
    
    // nameLabel
    @IBOutlet weak var firstNameLabel: UILabel! {
        didSet {
            firstNameLabel.text = nameLabelPlaceholder
        }
    }
    @IBOutlet weak var secondNameLabel: UILabel! {
        didSet {
            secondNameLabel.text = nameLabelPlaceholder
        }
    }
    @IBOutlet weak var thirdNameLabel: UILabel! {
        didSet {
            thirdNameLabel.text = nameLabelPlaceholder
        }
    }
    @IBOutlet weak var fourthNameLabel: UILabel! {
        didSet {
            fourthNameLabel.text = nameLabelPlaceholder
        }
    }
    
    
    
    // priceLabel
    @IBOutlet weak var firstPriceLabel: UILabel! {
        didSet{
            firstPriceLabel.text = priceLabelPlaceholder
        }
    }
    @IBOutlet weak var secondPriceLabel: UILabel! {
        didSet{
            secondPriceLabel.text = priceLabelPlaceholder
        }
    }
    @IBOutlet weak var thirdPriceLabel: UILabel! {
        didSet{
            thirdPriceLabel.text = priceLabelPlaceholder
        }
    }
    @IBOutlet weak var fourthPriceLabel: UILabel! {
        didSet{
            fourthPriceLabel.text = priceLabelPlaceholder
        }
    }
    
    
    
    
    func createItemView(_ view: UIView, _ int: CGFloat, _ color: UIColor) {
        view.layer.cornerRadius = int
        view.backgroundColor = color
    }
    
    
    
    @IBOutlet weak var totalPriceLabel: UILabel! {
        didSet {
            totalPriceLabel.text = "合計 \(sumFoodPrice) 円"
        }
    }
    
    // ３つ目のラベル(TotalPrice)
    // メモ String型はisEmptyメソッドを持つ
    // { selectFoods.filter{ !$0.name.isEmpty }.map { $0.price }.reduce(0) { $0 + $1 } }
    private var sumFoodPrice: Int {
        get {
            selectFoods.filter { (food) -> Bool in
                !food.name.isEmpty
            }.map { (food) -> Int in
                food.price
            }.reduce(0) { (result, price) -> Int in
                result + price
            }
        }
    }
    
    
    private lazy var foods = Food.createDefaultFoods()
    
    // Label 初期値
    var nameLabelPlaceholder: String = "選択されていません"
    var priceLabelPlaceholder: String = ""
    //FIX nameを表示するラベルを配列にする(上記の２つ)
    private lazy var labels = [firstNameLabel, secondNameLabel, thirdNameLabel, fourthNameLabel]
    //FIX 選択したものを配列にしている。初期値は全てEmptyとなっている
    private lazy var selectFoods = [Food](repeating: Food.createEmpty(), count: labels.count)
    
    // 押されたボタンの状態管理
    enum WhichBtn: Int {
        case first = 0, second = 1, third = 2, fourth = 3, none = 4
    }
    var buttonStatus: WhichBtn = .none
    
    
    @IBAction func tapFirstButton(_ sender: UIButton) {
        buttonStatus = .first
        Router.showList(fromVC: self)
    }
    
    @IBAction func tapSecondButton(_ sender: UIButton) {
        buttonStatus = .second
        Router.showList(fromVC: self)
    }
    
    @IBAction func tapThirdButton(_ sender: UIButton) {
        buttonStatus = .third
        Router.showList(fromVC: self)
    }
    
    @IBAction func tapFourthButton(_ sender: UIButton) {
        buttonStatus = .fourth
        Router.showList(fromVC: self)
    }
    
        
    // ButtonAciton Funcs
    
    // delegateをtapButtonメソッド内で処理しようとすると実行されなくなる
    //let listTableVC = UIStoryboard(name: "ListTable", bundle: nil).instantiateViewController(identifier: "ListTable") as! ListTableViewController
    //listTableVC.delegate = self
    //Router.showList(fromVC: self)
    
}


extension HomeViewController: ToPassDataProtocol {
    
    // cellがタップされた時の処理
    func cellDidSelect(cellData: Food) {
        print("デリゲートが実行されました")
        switch buttonStatus {
        // ボタンの状態がfirstもしくはsecondだった場合
        case .first, .second, .third, .fourth:
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
        totalPriceLabel.text = "合計 \(sumFoodPrice) 円"
    }
    
}
