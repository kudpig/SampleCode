//
//  ItemListViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ListTableViewController: UIViewController {
    
    @IBOutlet private weak var segmentControl: UISegmentedControl! {
        didSet {
            let segmentArray = Item.createSegmentArray()
            segmentWithArray(array: segmentArray)
            segmentControl.selectedSegmentIndex = .zero
            segmentControl.selectedSegmentTintColor = .systemBlue
            
            segmentControl.addTarget(self, action: #selector(handleSegmentChage), for: .valueChanged)
        }
    }
    
    private func segmentWithArray(array: [String]) {
        segmentControl.removeAllSegments()
        for (index, string) in array.enumerated() {
            segmentControl.insertSegment(withTitle: string, at: index, animated: false)
        }
    }
    
    @objc private func handleSegmentChage() {
        
        guard segmentControl.selectedSegmentIndex != .zero else {
            displayItemList = itemList
            tableView.reloadData()
            return
        }
        
        let filterList = itemList.filter { v in v.type == Item.genre.allCases[segmentControl.selectedSegmentIndex] }
        displayItemList = filterList
        tableView.reloadData()
    }
    
    
    private lazy var itemList = Item.createDefaultItems()
    
    private lazy var displayItemList = itemList
    
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
        return displayItemList.count
    }
    
    // ②cellの中身に関する設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier) as? ItemListTableViewCell else {
            fatalError()
        }
        
        let item = displayItemList[indexPath.row]
        cell.configure(item: item)
        
        return cell
    }
    
    // ③セルをタップした時の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = displayItemList[indexPath.row]
        delegate?.cellDidSelect(cellData: item)
        self.navigationController?.popViewController(animated: true)
    }
    
}
