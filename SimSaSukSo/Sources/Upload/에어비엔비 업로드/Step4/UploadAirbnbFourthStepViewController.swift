//
//  UploadAirbnbFourthStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/17.
//

import UIKit
class UploadAirbnbFourthStepViewController : UIViewController{
    
    var airbnbInput : UploadAirbnbInput = UploadAirbnbInput(locationId: 0, images: [], description: "", url: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
    var usedTool : [Int] = []
    
    var ismoved : Bool = false
    @IBOutlet weak var fourthPictureCollectionView: UICollectionView!
 @IBOutlet weak var usedToolCameraButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolAppButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolFilterButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolSelfButton: AdaptableSizeButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var startDateTextFIeld:
        UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
   
    @IBOutlet weak var regionButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var twoLeadSp: NSLayoutConstraint!
        @IBOutlet weak var threeLeadSp: NSLayoutConstraint!
        @IBOutlet weak var fiveLeadSp: NSLayoutConstraint!
        @IBOutlet weak var sixLeadSp: NSLayoutConstraint!
       

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startDateTextFIeld.text = self.airbnbInput.startDate
        endDateTextField.text = self.airbnbInput.endDate
        priceTextField.text = String(self.airbnbInput.charge)
        regionButton.setTitle(UploadAirbnbThirdStepViewController.regionText, for: .normal)
        locationTextField.text = self.airbnbInput.description
        urlTextField.text = self.airbnbInput.url
        
        
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        
        ismoved = false
       
        fourthPictureCollectionView.dataSource = self
        fourthPictureCollectionView.delegate = self
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    @IBAction func editDegreeSliderAction(_ sender: UISlider) {
        ismoved = true
        slider.value = Float(Int(slider.value))
        print(Int(slider.value))
        
        if self.usedTool != []{
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        }
        
        
    }
    
    func validation(){
        if ismoved == true && usedTool != []{
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        }
        
    }
        @IBAction func selectButton(sender: AnyObject) {
            guard let button = sender as? UIButton else {
                return
            }

            switch button.tag {
            case 0:
                usedToolCameraButton.isSelected = !usedToolCameraButton.isSelected
                if usedToolCameraButton.isSelected {
                    usedToolCameraButton.setTitleColor(.simsasuksoGreen, for: .selected)
                    usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                    usedToolCameraButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                    
                    self.usedTool.append(button.tag + 1)
                    validation()
                    print(usedTool)
                } else {
                    usedToolCameraButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                    usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                    usedToolCameraButton.backgroundColor = .clear
                    self.usedTool.removeAll(where: { $0 == button.tag + 1 })
                    validation()
                    print(usedTool)
                    
                }
                
                
                break
            case 1:
                usedToolAppButton.isSelected = !usedToolAppButton.isSelected
                if usedToolAppButton.isSelected {
                    usedToolAppButton.setTitleColor(.simsasuksoGreen, for: .selected)
                    usedToolAppButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                    usedToolAppButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                    
                    self.usedTool.append(button.tag + 1)
                    print(usedTool)
                    validation()
                } else {
                    usedToolAppButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                    usedToolAppButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                    usedToolAppButton.backgroundColor = .clear
                    usedTool.removeAll(where: { $0 == button.tag + 1 })
                    print(usedTool)
                    validation()
                }
                
                break
                
            case 2:
                usedToolFilterButton.isSelected = !usedToolFilterButton.isSelected
                if usedToolFilterButton.isSelected {
                    usedToolFilterButton.setTitleColor(.simsasuksoGreen, for: .selected)
                    usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                    usedToolFilterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                    
                    usedTool.append(button.tag + 1)
                    print(usedTool)
                    validation()
                    
                } else {
                    usedToolFilterButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                    usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                    usedToolFilterButton.backgroundColor = .clear
                    usedTool.removeAll(where: { $0 == button.tag + 1 })
                    print(usedTool)
                    validation()
                }
                
                break
               
            case 3:
                usedToolSelfButton.isSelected = !usedToolSelfButton.isSelected
                if usedToolSelfButton.isSelected {
                    usedToolSelfButton.setTitleColor(.simsasuksoGreen, for: .selected)
                    usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                    usedToolSelfButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                    
                    usedTool.append(button.tag + 1)
                    print(usedTool)
                    validation()
                    
                } else {
                    usedToolSelfButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                    usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                    usedToolSelfButton.backgroundColor = .clear
                    usedTool.removeAll(where: { $0 == button.tag + 1 })
                    print(usedTool)
                    validation()
                }
                
                break
            default:
                print("버튼 선택 안함")
                return
            }
        }
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func preButtonAction(_sender: UIButton){
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let fifthVC = self.storyboard?.instantiateViewController(identifier: "UploadAirbnbFifthStepViewController")as!UploadAirbnbFifthStepViewController
        fifthVC.modalPresentationStyle = .fullScreen
        
        self.airbnbInput.correctionTool = usedTool
        self.airbnbInput.correctionDegree = Int(slider.value)
        fifthVC.airbnbInput = self.airbnbInput
        self.present(fifthVC, animated: false, completion: nil)
        
    }
    
}



extension UploadAirbnbFourthStepViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureFourthCollectionViewCell", for: indexPath) as! UploadedPictureFourthCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        uploadGeneralcell.fourthPictureImageView.image = photos
        
        return uploadGeneralcell
    }
    
}

