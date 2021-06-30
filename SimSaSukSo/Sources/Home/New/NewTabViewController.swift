//
//  NewTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit

class NewTabViewController: UIViewController {
    
    var newPageViewController : NewPageViewController!
    
    let count = 10
    
    @IBOutlet var newOneFeedButton: UIButton!
    @IBOutlet var newFeedsButton: UIButton!
    @IBOutlet var newViewHeight: NSLayoutConstraint!
    @IBOutlet var newScrollView: UIScrollView!
    
    @IBOutlet var contentView: UIView!
    
    
    var buttonLists: [UIButton] = []
    
    var currentIndex : Int = 1 {
        didSet {
            changeButtonColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newScrollView.delegate = self
        
        self.newViewHeight.constant = 10/3 * 130 + 200
        
        setButtonList()
    
    }

    //MARK: - Function
    
    func setButtonList() {
        buttonLists.append(newFeedsButton)
        buttonLists.append(newOneFeedButton)
        
        newFeedsButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        newOneFeedButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewPageViewController" {
            guard let vc = segue.destination as? NewPageViewController else {return}
            newPageViewController = vc
            
            newPageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func newOneFeedButtonAction(_ sender: UIButton) {
        newPageViewController.setViewcontrollersFromIndex(index: 1)
        
    }
    @IBAction func newFeedsButtonAction(_ sender: UIButton) {
        newPageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    
}

//MARK: - ScrollView
extension NewTabViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == newScrollView {
            if newPageViewController.currentIndex == 1 { // OneFeed
                adjustOneFeedPageHeight()
            } else {
                adjustFeedsPageHeight()
            }
        }

    }
    
    func adjustOneFeedPageHeight(){
        self.newViewHeight.constant = CGFloat(NewOneFeedViewController.testOneFeedArray.count * 476)
    }
    
    func adjustFeedsPageHeight() {
        self.newViewHeight.constant = CGFloat(NewFeedsViewController.testFeedsArray.count/3 * 130 + 170)
    }
}
