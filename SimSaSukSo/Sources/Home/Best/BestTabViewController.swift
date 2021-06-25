//
//  BestTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit

class BestTabViewController: UIViewController {
    
    let count = 10
    
    @IBOutlet var bestViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bestViewHeight.constant = CGFloat(Double(count) * 440)
        

    }
    
}
