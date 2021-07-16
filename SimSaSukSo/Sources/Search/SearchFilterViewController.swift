//
//  SearchFilterViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/15.
//

import UIKit

class SearchFilterViewController: UIViewController {
    
    let goodLists = ["위치", "가성비", "깨끗함", "인테리어", "룸서비스", "서비스좋음", "건물신축", "어매니티", "부대시설", "교통편리", "기타"]
    let badLists = ["위치", "가성비", "더러움", "인테리어", "룸서비스", "서비스나쁨", "건물노후", "어매니티", "부대시설", "교통복잡", "기타"]

    @IBOutlet var resetButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var minTextField: UITextField!
    @IBOutlet var maxTextField: UITextField!
    @IBOutlet var dayButton: UIButton!
    @IBOutlet var dayView: UIView!
    @IBOutlet var goodCollectionView: UICollectionView!
    @IBOutlet var badCollectionView: UICollectionView!
    @IBOutlet var setButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        
        locationButton.layer.borderWidth = 1
        locationButton.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        locationButton.layer.cornerRadius = 4
        
        dayView.isHidden = true
        dayView.layer.masksToBounds = false
        dayView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dayView.layer.shadowOffset = CGSize(width: 0, height: 2)
        dayView.layer.shadowOpacity = 0.1
        
        goodCollectionView.delegate = self
        goodCollectionView.dataSource = self
        badCollectionView.delegate = self
        badCollectionView.dataSource = self
        
        goodCollectionView.tag = 1
        badCollectionView.tag = 2
        
        configure()
    }
    // CollectionView Left Align
    func configure() {
        goodCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = goodCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        badCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = badCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetButtonAciton(_ sender: UIButton) {

    }
    
    @IBAction func dayButtonAction(_ sender: UIButton) {
        dayButton.isSelected = !dayButton.isSelected
        
        if dayButton.isSelected { //선택
            dayView.isHidden = false
        } else {
            dayView.isHidden = true
        }
       
    }
    
    @IBAction func dayTitleButtonAction(_ sender: UIButton) {
        dayButton.setTitle("\(sender.currentTitle!)", for: .normal)
        resetButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
    }
    
}

extension SearchFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCollectionViewCell", for: indexPath) as! GoodCollectionViewCell
            
            cell.goodLabel.text = goodLists[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
            cell.layer.cornerRadius = 4
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadCollectionViewCell", for: indexPath) as! BadCollectionViewCell
            
            cell.badLabel.text = badLists[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
            cell.layer.cornerRadius = 4
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView.tag == 1 {
            let cell = goodCollectionView.cellForItem(at: indexPath) as! GoodCollectionViewCell
            
            if cell.layer.borderColor == #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1) {
                cell.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                cell.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                cell.goodLabel.textColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            } else {
                cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                cell.backgroundColor = .clear
                cell.goodLabel.textColor = #colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1)
            }
            
        } else {
            let cell = badCollectionView.cellForItem(at: indexPath) as! BadCollectionViewCell

            if cell.layer.borderColor == #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1) {
                cell.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                cell.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                cell.badLabel.textColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            } else {
                cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                cell.backgroundColor = .clear
                cell.badLabel.textColor = #colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1)
            }
       
        }
    }

}

extension SearchFilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
}
