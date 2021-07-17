//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralSecondStepViewController : UIViewController{
            
    @IBOutlet weak var SecondPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var startDateTextfiled: UITextField!
    @IBOutlet weak var endDateTextfiled: UITextField!
    @IBOutlet weak var priceTextfiled: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        
        SecondPictureCollectionView.delegate = self
        SecondPictureCollectionView.dataSource = self
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [startDateTextfiled,endDateTextfiled,priceTextfiled].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        } else {
          
            nextButton.isEnabled = true
            
            
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            
            
        }
    }
}

extension UploadGeneralSecondStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadAircell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureSecondCollectionViewCell", for: indexPath) as! UploadedPictureSecondCollectionViewCell
        
        return uploadAircell
    }
    
    
    
    
    
}
