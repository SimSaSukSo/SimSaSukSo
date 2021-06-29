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
    
    
    @IBOutlet var newHashTagCollectionView: UICollectionView!
    
    @IBOutlet var newOneFeedButton: UIButton!
    @IBOutlet var newFeedsButton: UIButton!
    @IBOutlet var newViewHeight: NSLayoutConstraint!
    
    
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
        self.newHashTagCollectionView.collectionViewLayout = bestHashtagFlowLayout
        
        newHashTagCollectionView.delegate = self
        newHashTagCollectionView.dataSource = self
        
        newViewHeight.constant = CGFloat(Double(count) * 440)
        
        setButtonList()
    
    }
    
    //MARK: - Function
    
    func setButtonList() {
        buttonLists.append(newFeedsButton)
        buttonLists.append(newOneFeedButton)
        
        newOneFeedButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        newFeedsButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
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
//MARK: - CollectionView
extension NewTabViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestHashtagCollectionViewCell", for: indexPath) as! BestHashtagCollectionViewCell
        
        return cell
    }

}
//MARK: - CollectionView FlowLayout
extension NewTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 96, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    
}
