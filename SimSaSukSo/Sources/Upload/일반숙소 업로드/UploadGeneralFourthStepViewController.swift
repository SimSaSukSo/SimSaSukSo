//
//  UploadGeneralFourthStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralFourthStepViewController : UIViewController{
    
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var tagEnterButton: UIButton!
    
    @IBOutlet weak var tagTextFieldView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTextFieldView.isHidden = true
        
        tagEnterButton.layer.cornerRadius = 15
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
    }
}

extension UploadGeneralFourthStepViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
  
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let addTagcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralTagCollectionViewCell", for: indexPath) as! UploadGeneralTagCollectionViewCell
            addTagcell.addTagButton.layer.borderWidth = 1
           
            addTagcell.addTagButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
            addTagcell.addTagButton.layer.cornerRadius = 4
            
            return addTagcell
        }
    
    
    
    
    
}
