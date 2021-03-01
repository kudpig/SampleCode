//
//  ItemListViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ItemListViewController: UIViewController {

    /// 選択したcellの配列番号が代入される
    var indexNum: Int?
    
    
    @IBOutlet weak var tableView: UITableView!

    
    var items = [Food]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cellに表示させたいitemsに、Foodモデルで定義したfoodsを代入(Jsonから変換済)
        items = foods
        // 使用するcellファイルの登録
        tableView.register(ItemListTableViewCell.nib(), forCellReuseIdentifier: ItemListTableViewCell.identifier)
        // delegateメソッドをこのファイルに記載
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}


// TableView Funcs
    // 行の数
extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // cellの中身に関する設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cellを以下の仕様で再利用する(for関数のようにrowひとつひとつに代入されるイメージ)
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier, for: indexPath) as! ItemListTableViewCell
        
        // itemsの内の取得されたrowが持つ各プロパティをxibのUIに代入する
        cell.nameLabel.text = items[indexPath.row].name
        cell.priceLabel.text = "\(items[indexPath.row].price)円"
        // image文字列を定数に代入し取得、UIImageの引数として使用
        let iconStr = items[indexPath.row].image
        cell.iconImage.image = UIImage(named: iconStr)
        
        return cell
    }
    
    // セルをタップした時の設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("選択したcellのitem:\(items[indexPath.row])") // ex) Food(name: "Orange", price: 120, image: "Orange") と出力される
        
        // 配列のindexを取得。
        indexNum = indexPath.row // apple=0, orange=1...配列のindex
        
        // 前画面のClassが持つenumや変数を呼び出すためにViewControllerを定数として定義する
        // 現在のNavigationController(必ずあるので強制アンラップで良い？)
        let presentNC = self.navigationController!
        // VCのカウントは現在のVCが-1,ひとつ前のVCが-2
        let beforeVC = presentNC.viewControllers[presentNC.viewControllers.count - 2] as! ViewController
        // viewControllersはUIViewControllerクラスを配列で所持しており、その内の一つを指定している。
        // なのでViewControllerクラスへのダウンキャストは必ず成功するという考えの元の as!
        
        
        
        print(beforeVC.nowButton) // 選んだボタンの確認デバック用
        // 値渡しのための条件分岐。前画面で押した遷移元のボタンによって代入先の変数を変える
        switch beforeVC.nowButton {
        case .first:
            beforeVC.firstItemRowNumber = self.indexNum! // 配列のindexは必ず存在するので!で良いという判断
        case .second:
            beforeVC.secondItemRowNumber = self.indexNum!
        default:
            print("Error!どのボタンか判別出来ませんでした")
        }
        
        
        // 値を受取った後、再度描画し、一つ前のViewに戻る
        beforeVC.loadView()
        beforeVC.viewDidLoad()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
