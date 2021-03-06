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
        tableView.reloadData()
    }
    
    
    private lazy var itemList = Item.createDefaultItems()
    
    private var displayItemList: [Item] {
        guard segmentControl.selectedSegmentIndex != .zero else {
            return itemList
        }
        return itemList.filter { $0.type == Item.genre.allCases[segmentControl.selectedSegmentIndex] }
    }
    
    weak var delegate: ToPassDataProtocol?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ItemListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemListTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

}


extension ListTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier) as? ItemListTableViewCell else {
            fatalError()
        }
        
        let item = displayItemList[indexPath.row]
        cell.configure(item: item)
        
        return cell
    }
    
}

extension ListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = displayItemList[indexPath.row]
        delegate?.cellDidSelect(cellData: item)
        self.navigationController?.popViewController(animated: true)
    }
    
}
