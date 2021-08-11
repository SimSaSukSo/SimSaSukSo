//
//  EvaluCollectionViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/02.
//

import UIKit

class EvaluCollectionViewCell: UICollectionViewCell {
    
    lazy var dataManager = EvaluDataManager()
    
    var evaluImages: [EvaluSources] = []
    var evaluResults: [EvaluResult] = []
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userIdLabel: UILabel!
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
    @IBOutlet var evaluSlider: StarSlider!
    
    
    func setupViews() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        let imageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        imageCollectionView.collectionViewLayout = imageCollectionViewFlowLayout
        imageCollectionViewFlowLayout.scrollDirection = .horizontal
        
        let evaluStoryboard = UIStoryboard.init(name: "UploadStoryboard", bundle: nil)
        let evaluVC = evaluStoryboard.instantiateViewController(identifier: "EvaluViewController") as! EvaluViewController
        
        dataManager.evaluView(type: evaluVC.type, lodgingIndex: evaluVC.lodgingIndex, delegate: self)
        
    }
    
    @IBAction func evaluSliderAction(_ sender: UISlider) {
        let roundValue = round(sender.value)
        
        for index in 0 ... 5 { // 이미지 Tag
            
            if let starImage = contentView.viewWithTag(index) as? UIImageView {
                if index <= Int(roundValue) {
                    starImage.image = UIImage(named: "evalu_Star_Fill")
                } else {
                    starImage.image = UIImage(named: "evalu_Star")
                }
            }
        }
        
        let evaluStoryboard = UIStoryboard.init(name: "UploadStoryboard", bundle: nil)
        let evaluVC = evaluStoryboard.instantiateViewController(identifier: "EvaluViewController") as! EvaluViewController
        
        if sender.isContinuous {
            evaluVC.degree = Int(roundValue)
        }
        
        print(roundValue)
        print(evaluVC.degree)
    }
    
   
    
    
    
    
}

//MARK: - CollectionView
extension EvaluCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return evaluImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "evaluImageCollectionViewCell", for: indexPath) as! EvaluImageCollectionViewCell
        
        let evaluImage = evaluImages[indexPath.row]
        
        
        if let url = URL(string: evaluImage.source) {
            cell.imageView.kf.setImage(with: url)
        } else {
            cell.imageView.image = UIImage(named: "defaultImage")
        }
        
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

//MARK: - API
extension EvaluCollectionViewCell {
    func evaluView(result: EvaluResponse) {
        evaluResults = result.result!
        
        for i in 0...evaluResults.count-1 {
            let evaluResult = evaluResults[i]
            evaluImages = evaluResult.sources!
        }
        
        imageCollectionView.reloadData()
        
    }
    func evaluImageView(result: EvaluResult) {
        evaluImages = result.sources!
        
    }
    
    func failedToRequest(message: String) {
        print(message)
    }
}
