//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit

protocol StartateDelegate: class {
    func sendStartDate(forSave: String,forShow : String) -> String
}

protocol EndDateDelegate: class {
    func sendEndDate(forSave: String,forShow : String) -> String
}


class UploadGeneralThirdStepViewController : UIViewController{
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [0], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
   
    
    var startDate : String = "숙박 시작일"
    var endDate : String = "숙박 마지막일"
    
    @IBOutlet weak var startDateButton: UIButton?
    @IBOutlet weak var endDateButton: UIButton!
    
    @IBOutlet weak var ThirdPictureCollectionView: UICollectionView!
    
   
    @IBOutlet weak var priceTextfiled: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        startDateButton?.setTitle(self.startDate, for: .normal)
        endDateButton.setTitle(self.endDate, for: .normal)
        nameTextField.text = self.generalInput.name
        addressTextField.text = self.generalInput.address
        priceTextfiled.text = "\(self.generalInput.charge)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(generalInput)
       
        nextButton.isEnabled = false
        
        ThirdPictureCollectionView.delegate = self
        ThirdPictureCollectionView.dataSource = self
    }
    
   func validation(){
        if startDateButton?.titleLabel!.text != "숙박 시작일" && endDateButton.titleLabel!.text != "숙박 마지막일" && startDateButton?.titleLabel!.text != "" && endDateButton?.titleLabel!.text != ""{
             print("HAHA")
        
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)}
        else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            
        }
        
   }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func startDateButtonAction(_ sender: Any) {
        let startVC = self.storyboard?.instantiateViewController(identifier: "StartDatePickerViewController")as!StartDatePickerViewController
        startVC.delegate = self
        self.present(startVC, animated: false, completion: nil)
        
    }
    
    @IBAction func endDateButtonAction(_ sender: Any) {
        let endVC = self.storyboard?.instantiateViewController(identifier: "EndDatePickerViewController")as!EndDatePickerViewController
        endVC.delegate = self
        self.present(endVC, animated: false, completion: nil)
    }
    
    
    @IBAction func priorButtonAction(_ sender: Any) {

        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        let fourthVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralFourthStepViewController") as! UploadGeneralFourthStepViewController
        fourthVc.modalPresentationStyle = .fullScreen
        
        fourthVc.generalInput = self.generalInput
        fourthVc.startDate = startDate
        fourthVc.endDate = endDate
        
        self.present(fourthVc, animated: false, completion: nil)
        
    }
    
}



extension UploadGeneralThirdStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadAircell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureThirdCollectionViewCell", for: indexPath) as! UploadedPictureThirdCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        uploadAircell.thirdPictureImageView.image = photos
        
        return uploadAircell
    }
    
    
    
    
    
}

extension UploadGeneralThirdStepViewController : StartateDelegate,EndDateDelegate{
    
    
    func sendStartDate(forSave: String, forShow : String) -> String {
        // DatePickerViewController에서 입력한 data를 현재 화면에서 사용 가능
        
        startDateButton?.titleLabel?.text = forShow
        
        startDateButton?.setTitle(forShow, for: .normal)
        startDateButton?.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1), for: .normal)
        
        self.generalInput.startDate = forSave
        self.startDate = forShow
        
       
        print(startDateButton!.titleLabel!.text!)
        validation()
        return forSave
    }
    
    func sendEndDate(forSave: String, forShow: String) -> String {
        
        endDateButton?.titleLabel?.text = forShow
        
        endDateButton?.setTitle(forShow, for: .normal)
        endDateButton?.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1), for: .normal)
        
        self.generalInput.endDate = forSave
        self.endDate = forShow
        
        validation()
        
        return forSave
    }
    
}


