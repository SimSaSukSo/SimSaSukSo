//
//  BestTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit

class BestTabViewController: UIViewController {
    
    var bestPageViewController : BestPageViewController!
    
    let count = 10
    
    @IBOutlet var bestTabScrollView: UIScrollView!
    
    @IBOutlet var bestHashtagCollectionView: UICollectionView!
    @IBOutlet var bestOneFeedButton: UIButton!
    @IBOutlet var bestFeedsButton: UIButton!
    @IBOutlet var bestViewHeight: NSLayoutConstraint!
    
    var buttonLists: [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bestHashtagFlowLayout = UICollectionViewFlowLayout()
        bestHashtagFlowLayout.scrollDirection = .horizontal
        self.bestHashtagCollectionView.collectionViewLayout = bestHashtagFlowLayout
        
        bestHashtagCollectionView.delegate = self
        bestHashtagCollectionView.dataSource = self
        
        bestTabScrollView.delegate = self

        bestViewHeight.constant = 435 * 10 // cell 수
    
        setButtonList()
    
    }
    
    //MARK: - Function
    
    func setButtonList() {
        buttonLists.append(bestFeedsButton)
        buttonLists.append(bestOneFeedButton)
        
        bestOneFeedButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        bestFeedsButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)

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
        
        if segue.identifier == "BestPageViewController" {
            guard let vc = segue.destination as? BestPageViewController else {return}
            bestPageViewController = vc
            
            bestPageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func bestOneFeedButtonAction(_ sender: UIButton) {
        bestPageViewController.setViewcontrollersFromIndex(index: 1)
    }
    @IBAction func bestFeedsButtonAction(_ sender: UIButton) {
        bestPageViewController.setViewcontrollersFromIndex(index: 0)
    }
}

//MARK: - CollectionView
extension BestTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestHashtagCollectionViewCell", for: indexPath) as! BestHashtagCollectionViewCell
        
        return cell
    }

}
//MARK: - CollectionView FlowLayout
extension BestTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 96, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    
}
