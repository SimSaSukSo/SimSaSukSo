//
//  UploadGeneralPageOne.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/03.
//

import UIKit
class UploadGeneralFirstStepViewController : UIViewController{
    
    
    @IBOutlet weak var HotelNameTextField: UITextField!
    
    @IBOutlet weak var UplodGeneralPictureCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UplodGeneralPictureCollectionView.dataSource = self
        UplodGeneralPictureCollectionView.delegate = self
    }
    
}

extension UploadGeneralFirstStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralPictureCollectionViewCell", for: indexPath) as! UploadGeneralPictureCollectionViewCell
        
        return uploadGeneralcell
    }
    
    
    
    
    
    
}
