//
//  UploadGeneralThirdStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralThirdStepViewController : UIViewController{
    
    @IBOutlet weak var thirdPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var usedToolCameraButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolAppButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolFilterButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolSelfButton: AdaptableSizeButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var twoLeadSp: NSLayoutConstraint!
        @IBOutlet weak var threeLeadSp: NSLayoutConstraint!
        @IBOutlet weak var fiveLeadSp: NSLayoutConstraint!
        @IBOutlet weak var sixLeadSp: NSLayoutConstraint!
       

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        thirdPictureCollectionView.dataSource = self
        thirdPictureCollectionView.delegate = self
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
    
    
    @IBAction func editDegreeSliderAction(_ sender: UISlider) {
        slider.value = roundf(slider.value)
        print(slider.value)
        
        
        
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
            } else {
                usedToolCameraButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolCameraButton.backgroundColor = .clear
                
            }
            
            
            break
        case 1:
            usedToolAppButton.isSelected = !usedToolAppButton.isSelected
            if usedToolAppButton.isSelected {
                usedToolAppButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolAppButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolAppButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
            } else {
                usedToolAppButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolAppButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolAppButton.backgroundColor = .clear
                
            }
            
            break
            
        case 2:
            usedToolFilterButton.isSelected = !usedToolFilterButton.isSelected
            if usedToolFilterButton.isSelected {
                usedToolFilterButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolFilterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
            } else {
                usedToolFilterButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolFilterButton.backgroundColor = .clear
                
            }
            
            break
           
        case 3:
            usedToolSelfButton.isSelected = !usedToolSelfButton.isSelected
            if usedToolSelfButton.isSelected {
                usedToolSelfButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolSelfButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
            } else {
                usedToolSelfButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolSelfButton.backgroundColor = .clear
                
            }
            
            break
        default:
            print("버튼 선택 안함")
            return
        }
    }
    
    

}

extension UploadGeneralThirdStepViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureThirdCollectionViewCell", for: indexPath) as! UploadedPictureThirdCollectionViewCell
        
        return uploadGeneralcell
    }
    
}
