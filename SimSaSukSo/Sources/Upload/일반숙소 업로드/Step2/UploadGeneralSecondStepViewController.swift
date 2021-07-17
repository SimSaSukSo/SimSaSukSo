//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/17.
//

import UIKit
class UploadGeneralSecondStepViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
    }
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBAction func nameTextField(_ sender: Any) {
    }
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    @IBAction func priorButtonAction(_ sender: Any) {
        let firstVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralFirstStepViewController")
//        firstVc?.modalPresentationStyle = .fullScreen
//        self.present(firstVc!, animated: false, completion: nil)
        changeRootViewController(firstVc!)
        
    }
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        let thirdVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralThirdStepViewController")
        thirdVc?.modalPresentationStyle = .fullScreen
        self.present(thirdVc!, animated: false, completion: nil)
        
    }
    
    
    
    
}

extension UploadGeneralSecondStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secondCell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureSecondCollectionViewCell", for: indexPath) as! UploadedPictureSecondCollectionViewCell
        
        return secondCell
    }
    
    
    
    
}
