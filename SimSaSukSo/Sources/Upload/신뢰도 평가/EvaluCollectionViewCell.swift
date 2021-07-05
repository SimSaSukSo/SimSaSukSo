//
//  EvaluCollectionViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/02.
//

import UIKit

class EvaluCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userIdLabel: UILabel!
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
    @IBOutlet var oneStarButton: UIButton!
    @IBOutlet var twoStarButton: UIButton!
    @IBOutlet var threeStarButton: UIButton!
    @IBOutlet var fourStarButton: UIButton!
    @IBOutlet var fiveStarButton: UIButton!
    
    
    func setupViews() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        let imageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        imageCollectionView.collectionViewLayout = imageCollectionViewFlowLayout
        imageCollectionViewFlowLayout.scrollDirection = .horizontal
        
    }
    
    
    @IBAction func oneStarButtonAction(_ sender: UIButton) {
        oneStarButton.isSelected = !oneStarButton.isSelected
        if oneStarButton.isSelected {
            oneStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
        } else {
            oneStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
        }
    }
    @IBAction func twoStarButtonAction(_ sender: UIButton) {
        twoStarButton.isSelected = !twoStarButton.isSelected
        if twoStarButton.isSelected {
            oneStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
        } else {
            oneStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
        }
    }
    @IBAction func threeStarButtonAction(_ sender: UIButton) {
        threeStarButton.isSelected = !threeStarButton.isSelected
        if threeStarButton.isSelected {
            oneStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            threeStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            print("th선")
        } else {
            oneStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            threeStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
        }
    }
    @IBAction func fourStarButtonAction(_ sender: UIButton) {
        fourStarButton.isSelected = !fourStarButton.isSelected
        if fourStarButton.isSelected {
            oneStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            threeStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            fourStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
        } else {
            oneStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            threeStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            fourStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
        }
    }
    @IBAction func fiveStarButtonAction(_ sender: UIButton) {
        fiveStarButton.isSelected = !fiveStarButton.isSelected
        if fiveStarButton.isSelected {
            oneStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            threeStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            fourStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
            fiveStarButton.setImage(UIImage(named: "evalu_Star_Fill"), for: .normal)
        } else {
            oneStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            twoStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            threeStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            fourStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
            fiveStarButton.setImage(UIImage(named: "evalu_Star"), for: .normal)
        }
    }
    
}

//MARK: - CollectionView
extension EvaluCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "evaluImageCollectionViewCell", for: indexPath) as! EvaluImageCollectionViewCell
        
        return cell
    }

}

extension EvaluCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 104, height: 104)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
