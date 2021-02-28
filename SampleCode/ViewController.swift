//
//  ViewController.swift
//  SampleCode
//
//  Created by Shinichiro Kudo on 2021/02/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstItemLabel: UILabel!
    
    @IBOutlet weak var secondItemLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var firstSelectButton: UIButton! {
        didSet {
            firstSelectButton.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var secondSelectButton: UIButton! {
        didSet {
            secondSelectButton.layer.cornerRadius = 40
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func tapFirstSelectButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    

    @IBAction func tapSecondSelectButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goItemList", sender: nil)
    }
    
}

