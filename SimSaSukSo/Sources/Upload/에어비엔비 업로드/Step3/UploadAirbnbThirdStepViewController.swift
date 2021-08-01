//
//  UploadAirbnbThirdStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/17.
//


import UIKit
class UploadAirbnbThirdStepViewController : UIViewController{
    
    static var regionText : String = ""
    var startDate : String = "숙박 시작일"
    var endDate : String = "숙박 마지막일"
    
    var airbnbInput : UploadAirbnbInput = UploadAirbnbInput(locationId: 0, images: [], description: "", url: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
   

    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    
    @IBOutlet weak var priceErrorLabel: UILabel!
    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var ThirdPictureCollectionView: UICollectionView!
      
    @IBOutlet weak var priceTextfiled: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        startDateButton?.setTitle(self.startDate, for: .normal)
        endDateButton.setTitle(self.endDate, for: .normal)
        regionButton.setTitle(UploadAirbnbThirdStepViewController.regionText, for: .normal)
        locationTextField.text = self.airbnbInput.description
        urlTextField.text = self.airbnbInput.url
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        priceTextfiled.delegate = self
        
        print(self.airbnbInput)
    
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        ThirdPictureCollectionView.delegate = self
        ThirdPictureCollectionView.dataSource = self
    }
    
    
    @objc func validation(){
        let filteredArray = [priceTextfiled].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            priceErrorLabel.text =  ""
            
        } else {
            saveChargeFromPriceTextView()
            
        }
    }
    
    func saveChargeFromPriceTextView(){
        let stringCharge = priceTextfiled.text!
                if let charge = Int(stringCharge) {
                    if startDateButton?.titleLabel!.text != "숙박 시작일" && endDateButton.titleLabel!.text != "숙박 마지막일" && startDateButton?.titleLabel!.text != "" && endDateButton?.titleLabel!.text != ""{
                         print("HAHA")
                        self.airbnbInput.charge = charge
                        
                        priceErrorLabel.text = ""
                        nextButton.isEnabled = true
                        nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)}
                } else {
                    print("error")
                
                    priceErrorLabel.text =  "숫자만 입력해 주세요"
                    nextButton.isEnabled = false
                    nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
                }
            
            
    
    
    }
    
  
    
    @IBAction func startDateAction(_ sender: Any) {
        let startVC = self.storyboard?.instantiateViewController(identifier: "StartDatePickerViewController")as!StartDatePickerViewController
        startVC.delegate = self
        self.present(startVC, animated: false, completion: nil)
    }
    
    @IBAction func endDateAction(_ sender: Any) {
        let endVC = self.storyboard?.instantiateViewController(identifier: "AirEndDatePicker")as!AirEndDatePicker
        endVC.delegate = self
        self.present(endVC, animated: false, completion: nil)
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
   
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let fourthVC = self.storyboard?.instantiateViewController(identifier: "UploadAirbnbFourthStepViewController") as! UploadAirbnbFourthStepViewController
        fourthVC.modalPresentationStyle = .fullScreen
        
        fourthVC.airbnbInput = self.airbnbInput
        self.present(fourthVC, animated: false, completion: nil)
        
    }
    
    @IBAction func preButtonAction(_sender: UIButton){
        self.dismiss(animated: false, completion: nil)
        
        
    }
    
}

extension UploadAirbnbThirdStepViewController : UITextFieldDelegate{
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    //리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        priceTextfiled.resignFirstResponder() //텍스트필드 비활성화
        return true
    }
    
}

extension UploadAirbnbThirdStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadAircell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadAirStep3CollectionviewCell", for: indexPath) as! UploadAirStep3CollectionviewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        uploadAircell.image.image = photos
        
        return uploadAircell
    }

}

extension UploadAirbnbThirdStepViewController : StartateDelegate,EndDateDelegate{
    
    
    func sendStartDate(forSave: String, forShow : String) -> String {
        // DatePickerViewController에서 입력한 data를 현재 화면에서 사용 가능
        
        startDateButton?.titleLabel?.text = forShow
        
        startDateButton?.setTitle(forShow, for: .normal)
        startDateButton?.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1), for: .normal)
        
        self.airbnbInput.startDate = forSave
        self.startDate = forShow
        
        validation()
        print(startDateButton!.titleLabel!.text!)
        
                return forSave
    }
    
    func sendEndDate(forSave: String, forShow: String) -> String {
        
        endDateButton?.titleLabel?.text = forShow
        
        endDateButton?.setTitle(forShow, for: .normal)
        endDateButton?.setTitleColor(#colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1), for: .normal)
        
        self.airbnbInput.endDate = forSave
        self.endDate = forShow
       
        validation()
        
        return forSave
    }
    
}


