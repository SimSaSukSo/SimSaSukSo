//
//  UploadGeneralFourthStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit




class UploadGeneralFourthStepViewController : UIViewController{
    
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var tagEnterButton: UIButton!
    
    @IBOutlet weak var tagTextFieldView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    var tagArray = ["태그", "태그1234","태그추가하기"]
    
   
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tagTextFieldView.isHidden = true
        
        tagEnterButton.layer.cornerRadius = 15
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        tagCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
                if let flowLayout = tagCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                    
                    
                  }

//        collectionViewHeight.constant = CGFloat(32 * (rowCounts) + 8 * (rowCounts + 1))
//        print("-----")
       
         //print(collectionViewHeight.constant)
    }
    
    
    @IBAction func addTagButtonAction(_ sender: Any) {
        tagTextFieldView.isHidden = false
    }
    
    @IBAction func tagEnterButtonAction(_ sender: Any) {
        tagTextFieldView.isHidden = true
    }
    
}
extension ViewController:UICollectionViewDelegate {
    
}

extension UploadGeneralFourthStepViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
  
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tagArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var cell : UICollectionViewCell!
            if indexPath.item == tagArray.count - 1{
                let addTagcell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralAddTagCollectionViewCell", for: indexPath) as! UploadGeneralAddTagCollectionViewCell
                addTagcell.addTagButton.layer.borderWidth = 1
                //addTagcell.addTagButton.titleLabel?.text = "태그 추가하기"
                addTagcell.addTagButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                addTagcell.addTagButton.layer.cornerRadius = 4
                
                cell = addTagcell
            }else{
                let tagcell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralTagCollectionViewCell", for: indexPath) as! UploadGeneralTagCollectionViewCell
                
                tagcell.tagLabel.text = tagArray[indexPath.row]
                tagcell.layer.borderWidth = 1
                tagcell.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                tagcell.layer.cornerRadius = 4
                
                cell = tagcell
                
                
                
            }
            
            return cell
        }
    
    
    
    
    
}

//MARK: - CollectionView FlowLayout
extension UploadGeneralFourthStepViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size : CGSize!
        
        let collectionViewWidth = stackView.frame.width

        if indexPath.item == tagArray.count - 1{
            size = CGSize(width: 119, height: 32)
            
            
            
        }else{
            let label = UILabel(frame: CGRect.zero)
            label.text = tagArray[indexPath.item]
            label.sizeToFit()
            size = CGSize(width: label.frame.width + 28, height: 32)
            
            
            
        }
     
       
      
       
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

