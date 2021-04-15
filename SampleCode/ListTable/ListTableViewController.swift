//
//  ItemListViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ListTableViewController: UIViewController {
    
    private lazy var itemList = Item.createDefaultItems()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // 使用するcellファイルの登録
            tableView.register(UINib(nibName: ItemListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemListTableViewCell.identifier)
            // delegateメソッドをこのファイルに記載
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    weak var delegate: ToPassDataProtocol? // メモ これを持っているのがViewController(準拠させて、=selfとしている)

}


// TableView Funcs ①〜③
    // ①行の数
extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    // ②cellの中身に関する設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier) as? ItemListTableViewCell else {
            fatalError()
        }
        
        let item = itemList[indexPath.row]
        cell.configure(item: item)
        
        return cell
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier, for: indexPath) //as! ItemListTableViewCell
        //cell.nameLabel.text = foodList[indexPath.row].name
        //cell.priceLabel.text = "\(foodList[indexPath.row].price)円"
        //let iconStr = foodList[indexPath.row].image
        //cell.iconImage.image = UIImage(named: iconStr)
        //return cell
    }
    
    // ③セルをタップした時の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemList[indexPath.row]
        delegate?.cellDidSelect(cellData: item) // プロトコルのメソッド delegateには渡す先のViewControllerが入っている
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}
