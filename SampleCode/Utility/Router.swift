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
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    static func showResult(fromVC: UIViewController, items: [Item]) {
        let vc = UIStoryboard(name: "Result", bundle: nil).instantiateViewController(identifier: "Result") as! ResultViewController
        vc.receiveItems = items
            
        show(fromVC: fromVC, nextVC: vc)
    }
    
    private static func show(fromVC: UIViewController, nextVC: UIViewController) {
        if let nav = fromVC.navigationController {
            nav.pushViewController(nextVC, animated: true)
        } else {
            fromVC.present(nextVC, animated: true, completion: nil)
        }
    }
    
}
