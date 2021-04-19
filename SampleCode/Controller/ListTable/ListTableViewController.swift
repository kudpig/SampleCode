//
//  ItemListViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ListTableViewController: UIViewController {
    
    private lazy var itemList = Item.createDefaultItems()
    
    weak var delegate: ToPassDataProtocol?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ItemListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemListTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

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
    }
    
    // ③セルをタップした時の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemList[indexPath.row]
        delegate?.cellDidSelect(cellData: item)
        self.navigationController?.popViewController(animated: true)
    }
    
}
