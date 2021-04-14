//
//  Router.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/04/14.
//

import UIKit

final class Router {
    
    static func showRoot(window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    static func showList(fromVC: UIViewController) {
        let vc = UIStoryboard(name: "ListTable", bundle: nil).instantiateViewController(identifier: "ListTable") as! ListTableViewController
        vc.delegate = fromVC as? ToPassDataProtocol
        if let nav = fromVC.navigationController {
            nav.pushViewController(vc, animated: true)
        } else {
            fromVC.present(vc, animated: true, completion: nil)
        }
    }
    
    // 今後確認するべき内容
    // Routerファイルにdelegateを書いてもよいのか
    // vc.delegate = fromVC as? ToPassDataProtocol について
    // ToPassDataProtocolへのダウンキャスト？これは準拠(継承)させているということなのか？
    // Cannot assign value of type 'HomeViewController' to type 'ToPassDataProtocol?'を解消している？
    
}
