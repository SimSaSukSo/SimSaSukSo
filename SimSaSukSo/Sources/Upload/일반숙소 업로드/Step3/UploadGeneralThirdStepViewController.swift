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
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [""], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [0], correctionDegree: 0, review: "", tags: [""], pros: [""], cons: [""])
    
   
    
    var startDate : String = ""
    var endDate : String = ""
    
    @IBOutlet weak var startDateButton: UIButton?
    @IBOutlet weak var endDateButton: UIButton!
    
    @IBOutlet weak var ThirdPictureCollectionView: UICollectionView!
    
   
    @IBOutlet weak var priceTextfiled: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        
        nameTextField.text = self.generalInput.name
        addressTextField.text = self.generalInput.address
        priceTextfiled.text = "\(self.generalInput.charge)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(generalInput)
       
        
        
        ThirdPictureCollectionView.delegate = self
        ThirdPictureCollectionView.dataSource = self
    }
    
    
   func buttonActivation(){
        
    if startDateButton?.titleLabel!.text != "숙박 시작일" && endDateButton.titleLabel!.text != "숙박 마지막일"{
            print("HAHA")
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        } else {
            print("흙흙")
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            
            
            
        }
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadAircell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureThirdCollectionViewCell", for: indexPath) as! UploadedPictureThirdCollectionViewCell
        
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
        
        buttonActivation()
        print(startDateButton!.titleLabel!.text!)
        
                return forSave
    }
    
    func sendEndDate(forSave: String, forShow: String) -> String {
        
        endDateButton?.titleLabel?.text = forShow
        
        endDateButton?.setTitle(forShow, for: .normal)
        endDateButton?.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1), for: .normal)
        
        self.generalInput.endDate = forSave
        self.endDate = forShow
        
        buttonActivation()
        
        return forSave
    }
    
}


