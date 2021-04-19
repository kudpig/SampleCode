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
    // imageView
    @IBOutlet weak var firstImage: UIImageView! {
        didSet {
            firstImage.isHidden = true
        }
    }
    @IBOutlet weak var secondImage: UIImageView! {
        didSet {
            secondImage.isHidden = true
        }
    }
    @IBOutlet weak var thirdImage: UIImageView! {
        didSet {
            thirdImage.isHidden = true
        }
    }
    @IBOutlet weak var fourthImage: UIImageView! {
        didSet {
            fourthImage.isHidden = true
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
    
    // Label 初期値
    var nameLabelPlaceholder: String = "選択されていません"
    var priceLabelPlaceholder: String = ""
    
    
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
    
    
    private lazy var nameLabels = [firstNameLabel, secondNameLabel, thirdNameLabel, fourthNameLabel]
    private lazy var priceLabels = [firstPriceLabel, secondPriceLabel, thirdPriceLabel, fourthPriceLabel]
    private lazy var imageViews = [firstImage, secondImage, thirdImage, fourthImage]
    // 選択されたものを配列に加える。初期値は全てEmptyとする
    private lazy var selectItems = [Item](repeating: Item.createEmpty(), count: nameLabels.count)
    
    // 押されたボタンの状態管理
    enum WhichBtn: Int {
        case first = 0, second = 1, third = 2, fourth = 3, none = 4
    }
    var buttonStatus: WhichBtn = .none
    
    
    
    // ButtonAciton Funcs
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
    
    


    // ボタン下４つ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    private var numbers = ["5th", "6th", "7th", "8th"]
    
    @IBOutlet private weak var stackView: UIStackView! {
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
    
            // sectionの情報を与える
            contentView.nowSection = ButtonView.Section(rawValue: index) ?? .none
            
            contentView.delegate = self
    
            contentView.layer.cornerRadius = 40
            self.stackView.addArrangedSubview(contentView)
            
            contentView.update(number: number)
        }
    
    }


    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

}


extension HomeViewController: ToPassDataProtocol {
    
    // cellがタップされた時の処理
    func cellDidSelect(cellData: Item) {
        
        switch buttonStatus {
        case .first, .second, .third, .fourth:
            // labelsに格納されている配列の順番と、buttonStatusのenumのIntを一致させている
            nameLabels[buttonStatus.rawValue]?.text = cellData.name
            priceLabels[buttonStatus.rawValue]?.text = String(cellData.price)
            imageViews[buttonStatus.rawValue]?.image = UIImage(named: cellData.image)
            imageViews[buttonStatus.rawValue]?.isHidden = false
            // 選択されたFoodオブジェクトを配列に格納する(一覧画面に渡せるように)
            selectItems[buttonStatus.rawValue] = cellData
        default:
            break
        }
       
        totalPriceLabel.text = "合計 \(sumItemPrice) 円"
        
    }
    
}

extension HomeViewController: ButtonViewProtocol {
    func tapButton() {
        Router.showList(fromVC: self)
    }
    
}
