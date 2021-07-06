//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralSecondStepViewController : UIViewController{
            
    @IBOutlet weak var SecondPictureCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SecondPictureCollectionView.delegate = self
        SecondPictureCollectionView.dataSource = self
    }
    
}

extension UploadGeneralSecondStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureSecondCollectionViewCell", for: indexPath) as! UploadedPictureSecondCollectionViewCell
        
        return uploadGeneralcell
    }
    
    
    
    
    
}
