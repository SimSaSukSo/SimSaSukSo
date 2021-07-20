//
//  UploadGeneralFourthStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit




class UploadGeneralFifthStepViewController : UIViewController{
    
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var advantageCollectionView: UICollectionView!
    @IBOutlet weak var disadvantageCollectionView: UICollectionView!
    
    
    @IBOutlet weak var tagEnterButton: UIButton!
    @IBOutlet weak var advantageEnterButton: UIButton!
    @IBOutlet weak var disadvantageEnterButton: UIButton!
    
    
    @IBOutlet weak var tagTextFieldView: UIView!
    @IBOutlet weak var advantageTextFieldView: UIView!
    
    @IBOutlet weak var disadvantageTextFieldView: UIView!
    
    
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var advantageTextField: UITextField!
    @IBOutlet weak var disadvantageTextField: UITextField!
    
    
    @IBOutlet weak var stackView: UIStackView!
    var tagArray = ["태그","태그124","ㅇㄹㄴㅇㄹㄴㅇㄹㄴㅇㄹ","태그추가하기"]
    
   var advantageArray = ["위치","가성비","깨끗함","인테리어","룸서비스","서비스 좋음","건물신축","어매니티","부대시설","교통편리","직접 입력하기"]
    
    var disadvantageArray = ["위치","가성비","더러움","인테리어","룸서비스","서비스 나쁨","건물노후","어매니티","부대시설","교통복잡","직접 입력하기"]
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
   
    @IBOutlet weak var advantageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var disadvantageCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTextFieldView.isHidden = true
        tagCollectionViewConfigure()
        
        advantageTextFieldView.isHidden = true
        advantageCollectionViewConfigure()
        
        disadvantageTextFieldView.isHidden = true
        DisadvantageCollectionViewConfigure()
        
        
        //MARK: - 텍스트 필드가 EnterButtonActivate 처리할 수 있게 해줌
        NotificationCenter.default.addObserver(self, selector: #selector(TagEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AdvantageEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DisadvantageEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
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
    
    func DisadvantageCollectionViewConfigure(){
        
        
        disadvantageCollectionView.dataSource = self
        disadvantageCollectionView.delegate = self
        
        disadvantageEnterButton.layer.cornerRadius = 15
        
        disadvantageCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
                if let flowLayout = disadvantageCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                    
                    
                    //MARK: - DisadvantageCOLLECTIONVIEW HEIGHT
                    disadvantageCollectionViewHeight.constant = disadvantageCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
                    print("disadvantageCollectionView height : ")
                    print(disadvantageCollectionViewHeight.constant)
                    
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
    
    @objc func DisadvantageEnterButtonActivate(){
        let textArray = [advantageTextField].filter { $0?.text == "" }
        if !textArray.isEmpty {
            advantageEnterButton.isEnabled = false
            advantageEnterButton.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
        } else {
            advantageEnterButton.isEnabled = true
            advantageEnterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitleColor(.simsasuksoGreen, for: .selected)
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            sender.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
            
        } else {
            sender.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
            sender.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
            sender.backgroundColor = .clear
            
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
    
    
    @IBAction func addDisadvantageButtonAction(_ sender: Any) {
        disadvantageTextFieldView.isHidden = false
    }
    
    
    @IBAction func disadvantageEnterButtonAction(_ sender: Any) {
        
        disadvantageTextFieldView.isHidden = true
        disadvantageTextField.text = ""
    }
    
    @IBAction func priorButtonAction(_ sender: Any) {
//        let fourthVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralFourthStepViewController")
//        fourthVc?.modalPresentationStyle = .fullScreen
//        self.present(fourthVc!, animated: false, completion: nil)
        self.dismiss(animated: false, completion: nil)
        
    }
        @IBAction func nextButtonAction(_ sender : UIButton){
        let uploadVc = self.storyboard?.instantiateViewController(identifier: "UploadCompleteViewController")
            uploadVc?.modalPresentationStyle = .fullScreen
        self.present(uploadVc!, animated: false, completion: nil)
        
    }
    
    
    
}



extension UploadGeneralFifthStepViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
  
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            var count : Int!
            if collectionView == tagCollectionView{
                
                count = tagArray.count
            }else if collectionView == advantageCollectionView{
                count = advantageArray.count
            }else if collectionView == disadvantageCollectionView{
                count = disadvantageArray.count
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
                    
                    advantagecell.advantageButton.setTitle(advantageArray[indexPath.row], for: .normal)
                    advantagecell.advantageButton.layer.borderWidth = 1
                    advantagecell.advantageButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                    advantagecell.advantageButton.layer.cornerRadius = 4
                    
                    advantagecell.advantageButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                    
                    cell = advantagecell
                }
                
            }else if collectionView == disadvantageCollectionView{
                if indexPath.item == disadvantageArray.count - 1{
                    let addDisadvantagecell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralAddDisadvantageCollectionViewCell", for: indexPath) as! UploadGeneralAddDisadvantageCollectionViewCell
                    addDisadvantagecell.addDisadvnatageButton.layer.borderWidth = 1
                    addDisadvantagecell.addDisadvnatageButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                    addDisadvantagecell.addDisadvnatageButton.layer.cornerRadius = 4
                    
                    cell = addDisadvantagecell
                }else{
                    let disadvantagecell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralDisadvantageCollectionViewCell", for: indexPath) as! UploadGeneralDisadvantageCollectionViewCell
                    
                    disadvantagecell.disadvantageButton.setTitle(disadvantageArray[indexPath.row], for: .normal)
                    disadvantagecell.disadvantageButton.layer.borderWidth = 1
                    disadvantagecell.disadvantageButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                    disadvantagecell.disadvantageButton.layer.cornerRadius = 4
                    
                    disadvantagecell.disadvantageButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                    
                   
                    
                    cell = disadvantagecell
                    
                    
                
            }
           
            }
            return cell
}
    
    
    
}


//MARK: - CollectionView FlowLayout
extension UploadGeneralFifthStepViewController: UICollectionViewDelegateFlowLayout {
    
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
        }else if collectionView == disadvantageCollectionView{
            if indexPath.item == disadvantageArray.count - 1{
                size = CGSize(width: 119, height: 32)
                
            }else{
                let label = UILabel(frame: CGRect.zero)
                label.text = disadvantageArray[indexPath.item]
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

