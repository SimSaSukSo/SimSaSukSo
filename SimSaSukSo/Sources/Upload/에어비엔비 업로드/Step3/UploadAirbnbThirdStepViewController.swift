//
//  UploadAirbnbThirdStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/17.
//


import UIKit
class UploadAirbnbThirdStepViewController : UIViewController{
    
    var airbnbInput : UploadAirbnbInput = UploadAirbnbInput(locationId: 0, images: [], description: "", url: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
   
    @IBOutlet weak var ThirdPictureCollectionView: UICollectionView!
        @IBOutlet weak var startDateTextfiled: UITextField!
    @IBOutlet weak var endDateTextfiled: UITextField!
    @IBOutlet weak var priceTextfiled: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.airbnbInput)
        
        startDateTextfiled.addTarget(self, action: #selector(showStartDatePicker), for: .touchDown)
        endDateTextfiled.addTarget(self, action: #selector(showEndDatePicker), for: .touchDown)
        
        locationTextField.text = self.airbnbInput.description
        urlTextField.text = self.airbnbInput.url
        
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        
        
        ThirdPictureCollectionView.delegate = self
        ThirdPictureCollectionView.dataSource = self
    }
    
    @objc func showStartDatePicker(textField: UITextField) {
        let startVC = self.storyboard?.instantiateViewController(identifier: "AirStartDatePicker")as!StartDatePickerViewController
        startVC.delegate = self
        self.present(startVC, animated: false, completion: nil)
    }
    
    @objc func showEndDatePicker(textField: UITextField) {
        let endVC = self.storyboard?.instantiateViewController(identifier: "AirEndDatePicker")as!AirEndDatePicker
        endVC.delegate = self
        self.present(endVC, animated: false, completion: nil)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let fourthVC = self.storyboard?.instantiateViewController(identifier: "UploadAirbnbFourthStepViewController")
        fourthVC?.modalPresentationStyle = .fullScreen
        self.present(fourthVC!, animated: false, completion: nil)
        
    }
    
    @IBAction func preButtonAction(_sender: UIButton){
        self.dismiss(animated: false, completion: nil)
        
        
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

extension UploadAirbnbThirdStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadAircell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureThirdCollectionViewCell", for: indexPath) as! UploadedPictureThirdCollectionViewCell
        
        return uploadAircell
    }
    
    
    
    
    
}

extension UploadAirbnbThirdStepViewController : StartateDelegate,EndDateDelegate{
    
    
    func sendStartDate(forSave: String, forShow : String) -> String {
        // DatePickerViewController에서 입력한 data를 현재 화면에서 사용 가능
        
        startDateTextfiled.text = forShow
    
        self.airbnbInput.startDate = forSave
    
        print(startDateTextfiled.text ?? "")
        
        return forSave
    }
    
    func sendEndDate(forSave: String, forShow: String) -> String {
        
        endDateTextfiled.text = forShow
    
        
        self.airbnbInput.endDate = forSave
      
        return forSave
    }
    
}

