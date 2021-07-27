//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/17.
//

import UIKit
class UploadGeneralSecondStepViewController : UIViewController{
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [0], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var priceErrorLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet  var nameTextField : UITextField!
    
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        nameTextField.text = self.generalInput.name
        addressTextField.text = self.generalInput.address
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(generalInput)
        
        nextButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [priceTextField].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            priceErrorLabel.text =  ""
            
        } else {
            saveChargeFromPriceTextView()
            
        }
    }
    
    func saveChargeFromPriceTextView(){
        let stringCharge = priceTextField.text!
                if let charge = Int(stringCharge) {
                        self.generalInput.charge = charge
                        
                        priceErrorLabel.text = ""
                        nextButton.isEnabled = true
                        nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)}
                else {
                    print("error")
                
                    priceErrorLabel.text =  "숫자만 입력해 주세요"
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
                }
            
            
    
    
    }
    
   

    
   
    
    @IBAction func priorButtonAction(_ sender: Any) {

        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        let thirdVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralThirdStepViewController") as! UploadGeneralThirdStepViewController
        thirdVc.modalPresentationStyle = .fullScreen
        thirdVc.generalInput  = self.generalInput
       
        self.present(thirdVc, animated: false, completion: nil)
        
    }
    
    
    
    
}

extension UploadGeneralSecondStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secondCell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureSecondCollectionViewCell", for: indexPath) as! UploadedPictureSecondCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        
        secondCell.secondPictureImageView.image = photos
        
        return secondCell
    }
    
    
    
    
}

