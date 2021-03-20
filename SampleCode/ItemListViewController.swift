//
//  ItemListViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

protocol ToPassItemProtocol: class {
    func selectedItem(cellItem: Food)
}

class ItemListViewController: UIViewController {

    /// 選択したcellの配列番号が代入される
    //var indexNum: Int?
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // 使用するcellファイルの登録
            tableView.register(ItemListTableViewCell.nib(), forCellReuseIdentifier: ItemListTableViewCell.identifier)
            // delegateメソッドをこのファイルに記載
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    
    // FIX [Food]をインスタンス化
    private lazy var items = Food.createDefaultFoods() // privateをつけないと他のクラスでitems変数が使えなくなる。itemsにアクセスされてからメソッドを実行する
    
    weak var delegate: ToPassItemProtocol? // メモ これを持っているのがViewController(準拠させて、=selfとしている)


}


// TableView Funcs ①〜③
    // ①行の数
extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // ②cellの中身に関する設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier, for: indexPath) as! ItemListTableViewCell
        cell.nameLabel.text = items[indexPath.row].name
        cell.priceLabel.text = "\(items[indexPath.row].price)円"
        let iconStr = items[indexPath.row].image
        cell.iconImage.image = UIImage(named: iconStr)
        return cell
    }
    
    // ③セルをタップした時の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(delegate)
        
        // FIX
        let item = items[indexPath.row]
        print(item)
        delegate?.selectedItem(cellItem: item) // プロトコルのメソッド delegateには渡す先のViewControllerが入っている
        print("デリゲートセレクトアイテムは\(String(describing: delegate?.selectedItem(cellItem: item)))")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}
