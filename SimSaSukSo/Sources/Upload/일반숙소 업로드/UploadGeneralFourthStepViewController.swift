//
//  UploadGeneralFourthStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit




class UploadGeneralFourthStepViewController : UIViewController{
    
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var advantageCollectionView: UICollectionView!
    
    @IBOutlet weak var tagEnterButton: UIButton!
    @IBOutlet weak var advantageEnterButton: UIButton!
    
    @IBOutlet weak var tagTextFieldView: UIView!
    @IBOutlet weak var advantageTextFieldView: UIView!
    
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var advantageTextField: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    var tagArray = ["태그","태그124","ㅇㄹㄴㅇㄹㄴㅇㄹㄴㅇㄹ","태그추가하기"]
    
   var advantageArray = ["장점","장점123123","장점3423423423423","장점ㅎㅎ","자장ㄹ안ㄹ점","다리자덜자아러니알","ㅇㅇㅇ","ㅎ"]
    
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
   
    @IBOutlet weak var advantageCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTextFieldView.isHidden = true
        
        tagCollectionViewConfigure()
        
        advantageTextFieldView.isHidden = true
        advantageCollectionViewConfigure()
        
        
        //MARK: - 텍스트 필드가 EnterButtonActivate 처리할 수 있게 해줌
        NotificationCenter.default.addObserver(self, selector: #selector(TagEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AdvantageEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    func tagCollectionViewConfigure(){
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        tagEnterButton.layer.cornerRadius = 15
        
        tagCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
                if let flowLayout = tagCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                    
                    
                    //MARK: - TagCOLLECTIONVIEW HEIGHT
                    collectionViewHeight.constant = tagCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
                    print("따란")
                    print(collectionViewHeight.constant)
                    
                  }
    }
    
    func advantageCollectionViewConfigure(){
        
        
        advantageCollectionView.dataSource = self
        advantageCollectionView.delegate = self
        
        advantageEnterButton.layer.cornerRadius = 15
        
        advantageCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
                if let flowLayout = advantageCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                    
                    
                    //MARK: - AdvantageCOLLECTIONVIEW HEIGHT
                    advantageCollectionViewHeight.constant = advantageCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
                    print("advantageCollectionView height : ")
                    print(advantageCollectionViewHeight.constant)
                    
                  }
        
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func TagEnterButtonActivate(){
        let textArray = [tagTextField].filter { $0?.text == "" }
        if !textArray.isEmpty {
            tagEnterButton.isEnabled = false
            tagEnterButton.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
        } else {
            tagEnterButton.isEnabled = true
            tagEnterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }
    }
    
    @objc func AdvantageEnterButtonActivate(){
        let textArray = [advantageTextField].filter { $0?.text == "" }
        if !textArray.isEmpty {
            advantageEnterButton.isEnabled = false
            advantageEnterButton.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
        } else {
            advantageEnterButton.isEnabled = true
            advantageEnterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }
    }

    @IBAction func addTagButtonAction(_ sender: Any) {
        tagTextFieldView.isHidden = false
    }
    
    @IBAction func tagEnterButtonAction(_ sender: Any) {
        tagTextFieldView.isHidden = true
        tagTextField.text = ""
    }
    
    
    @IBAction func addAdvantageAction(_ sender: Any) {
        advantageTextFieldView.isHidden = false
        
    }
    
    @IBAction func advantageEnterButtonAction(_ sender: Any) {
        advantageTextFieldView.isHidden = true
        advantageTextField.text = ""
    }
    
    
}
extension ViewController:UICollectionViewDelegate {
    
}

extension UploadGeneralFourthStepViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
  
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            var count : Int!
            if collectionView == tagCollectionView{
                
                count = tagArray.count
            }else if collectionView == advantageCollectionView{
                count = advantageArray.count
            }
            
            return count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            var cell : UICollectionViewCell!
            
            if collectionView == tagCollectionView{
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
            }else if collectionView == advantageCollectionView{
                if indexPath.item == advantageArray.count - 1{
                    let addAdvantagecell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralAddAdvantageCollectionViewCell", for: indexPath) as! UploadGeneralAddAdvantageCollectionViewCell
                    addAdvantagecell.addAdvantageButton.layer.borderWidth = 1
                    //addTagcell.addTagButton.titleLabel?.text = "태그 추가하기"
                    addAdvantagecell.addAdvantageButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                    addAdvantagecell.addAdvantageButton.layer.cornerRadius = 4
                    
                    cell = addAdvantagecell
                }else{
                    let advantagecell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralAdvantageCollectionViewCell", for: indexPath) as! UploadGeneralAdvantageCollectionViewCell
                    
                    advantagecell.advantageLabel.text = advantageArray[indexPath.row]
                    advantagecell.layer.borderWidth = 1
                    advantagecell.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                    advantagecell.layer.cornerRadius = 4
                    
                    cell = advantagecell
                }
                
            }
           
            
            return cell
        }
    
    
    
    
    
}

//MARK: - CollectionView FlowLayout
extension UploadGeneralFourthStepViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size : CGSize!
        
        if collectionView == tagCollectionView{
            if indexPath.item == tagArray.count - 1{
                size = CGSize(width: 119, height: 32)
                
            }else{
                let label = UILabel(frame: CGRect.zero)
                label.text = tagArray[indexPath.item]
                label.sizeToFit()
                //x버튼 크기 28
                size = CGSize(width: label.frame.width + 28, height: 32)
                
            }
        }else if collectionView == advantageCollectionView{
            if indexPath.item == advantageArray.count - 1{
                size = CGSize(width: 119, height: 32)
                
            }else{
                let label = UILabel(frame: CGRect.zero)
                label.text = advantageArray[indexPath.item]
                label.sizeToFit()
                size = CGSize(width: label.frame.width + 1, height: 32)
                
            }
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

