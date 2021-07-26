//
//  UploadAirbnbFirstStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/14.
//

import UIKit
class UploadAirbnbFirstStepViewController : UIViewController{
    
var airbnbInput : UploadAirbnbInput = UploadAirbnbInput(locationId: 0, images: [], description: "", url: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
@IBOutlet weak var AirbnbLinkTextField: UITextField!
@IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var FirstPictureCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        
        self.airbnbInput.images = UploadViewController.urlArray

        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        FirstPictureCollectionView.dataSource = self
        FirstPictureCollectionView.delegate = self
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [AirbnbLinkTextField].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        } else {
          
            airbnbInput.url = AirbnbLinkTextField.text ?? ""
    
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            
            
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let secondNV = self.storyboard?.instantiateViewController(identifier: "AirbnbNavigator")
        secondNV?.modalPresentationStyle = .fullScreen
        
       
        UploadAirbnbSecondStepViewController.airbnbInput = self.airbnbInput
        
        self.present(secondNV!, animated: false, completion: nil)
        
        
    }
    
    @IBAction func priorButtonAction(_sender:Any){
        self.dismiss(animated: false,completion: nil)
        
        
    }
}

extension UploadAirbnbFirstStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadAircell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureFirstCollectionViewCell", for: indexPath) as! UploadedPictureFirstCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        uploadAircell.firstPictureImageView.image = photos
        
        return uploadAircell
    }
    
    
    
    
    
    
}
