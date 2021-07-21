//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralThirdStepViewController : UIViewController{
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [""], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [0], correctionDegree: 0, review: "", tags: [""], pros: [""], cons: [""])
    
   
    
    var startDate : String = ""
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(generalInput)
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        
        ThirdPictureCollectionView.delegate = self
        ThirdPictureCollectionView.dataSource = self
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [priceTextfiled].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        } else {
          
            nextButton.isEnabled = true
            
            
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            
            
        }
    }
    
    @IBAction func startDateButtonAction(_ sender: Any) {
        let startVC = self.storyboard?.instantiateViewController(identifier: "DatePickerViewController")as!DatePickerViewController
        
        self.present(startVC, animated: false, completion: nil)
        
    }
    
    @IBAction func endDateButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func priorButtonAction(_ sender: Any) {

        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        let fourthVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralFourthStepViewController")
        fourthVc?.modalPresentationStyle = .fullScreen
        self.present(fourthVc!, animated: false, completion: nil)
        
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
