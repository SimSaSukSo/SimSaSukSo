//
//  UploadGeneralThirdStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralThirdStepViewController : UIViewController{
    
    @IBOutlet weak var thirdPictureCollectionView: UICollectionView!
    @IBOutlet weak var usedToolCameraButton: AdaptableSizeButton!
    
    @IBOutlet weak var usedToolAppButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolFilterButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolSelfButton: AdaptableSizeButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var twoLeadSp: NSLayoutConstraint!
        @IBOutlet weak var threeLeadSp: NSLayoutConstraint!
        @IBOutlet weak var fiveLeadSp: NSLayoutConstraint!
        @IBOutlet weak var sixLeadSp: NSLayoutConstraint!
       

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        thirdPictureCollectionView.dataSource = self
        thirdPictureCollectionView.delegate = self
        setButton()
    }
    
    
    
    func setButton(){
        
        usedToolCameraButton.layer.borderWidth = 1
        usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolCameraButton.layer.cornerRadius = 4
        
        usedToolAppButton.layer.borderWidth = 1
        usedToolAppButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolAppButton.layer.cornerRadius = 4
        
        usedToolFilterButton.layer.borderWidth = 1
        usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolFilterButton.layer.cornerRadius = 4
        
        usedToolSelfButton.layer.borderWidth = 1
        usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolSelfButton.layer.cornerRadius = 4
        
        
    }
    
    
    @IBAction func editDegreeSliderAction(_ sender: UISlider) {
        slider.value = roundf(slider.value)
        print(slider.value)
        
        
        
    }
    
    

}

extension UploadGeneralThirdStepViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureThirdCollectionViewCell", for: indexPath) as! UploadedPictureThirdCollectionViewCell
        
        return uploadGeneralcell
    }
    
}
