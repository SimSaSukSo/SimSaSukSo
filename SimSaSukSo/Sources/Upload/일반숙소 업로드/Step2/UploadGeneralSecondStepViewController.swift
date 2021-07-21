//
//  UploadGeneralSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/17.
//

import UIKit
class UploadGeneralSecondStepViewController : UIViewController{
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [""], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [0], correctionDegree: 0, review: "", tags: [""], pros: [""], cons: [""])
    
    var nameText : String = ""
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet  var nameTextField : UITextField!
    
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = nameText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(generalInput)
        
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [locationTextField].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        } else {
          
            generalInput.address = locationTextField.text ?? ""
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            
            
            
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let secondCell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureSecondCollectionViewCell", for: indexPath) as! UploadedPictureSecondCollectionViewCell
        
        return secondCell
    }
    
    
    
    
}

