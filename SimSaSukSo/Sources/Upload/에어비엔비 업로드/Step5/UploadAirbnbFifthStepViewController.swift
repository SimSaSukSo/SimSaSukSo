
//
//  UploadAirbnbFifthStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit




class UploadAirbnbFifthStepViewController : UIViewController{
    
    var airbnbInput : UploadAirbnbInput = UploadAirbnbInput(locationId: 0, images: [], description: "", url: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
    var tagArray : [String] = ["태그 추가하기"]
    
   var advantageArray = ["위치","가성비","깨끗함","인테리어","룸서비스","서비스 좋음","건물신축","어매니티","부대시설","교통편리","직접 입력하기"]
    
    var disadvantageArray = ["위치","가성비","더러움","인테리어","룸서비스","서비스 나쁨","건물노후","어매니티","부대시설","교통복잡","직접 입력하기"]
    
    var clickedAdvantageArray : [String] = []
    var clickedDisadvantageArray : [String] = []
    
    var advantageClickedBook : [Int] = [0,0,0,0,0,0,0,0,0,0,0]
    var disadvantageClickedBook : [Int] = [0,0,0,0,0,0,0,0,0,0,0]
    
    @IBOutlet weak var reviewTextView: UITextView!
    
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
    
    
        @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
   
    @IBOutlet weak var advantageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var disadvantageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isEnabled = false
        
        reviewTextViewConfigure()
        
        tagTextFieldView.isHidden = true
        tagCollectionViewConfigure()
        
        advantageTextFieldView.isHidden = true
        advantageCollectionViewConfigure()
        
        disadvantageTextFieldView.isHidden = true
        DisadvantageCollectionViewConfigure()
        
        
        //MARK: - 텍스트 필드가 EnterButtonActivate 처리할 수 있게 해줌
        NotificationCenter.default.addObserver(self, selector: #selector(reviewTextFieldAction), name: UITextView.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TagEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AdvantageEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DisadvantageEnterButtonActivate), name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    func reviewTextViewConfigure(){
        
        //placeholder
        reviewTextView.delegate = self
        reviewTextView.text =  "숙소의 실제 후기를 들려주세요 :) (공백 포함 300byte 이내)"
        reviewTextView.textColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        
        //테두리
        reviewTextView.layer.borderWidth = 1
        reviewTextView.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        reviewTextView.layer.cornerRadius = 4
        
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
    @objc func reviewTextFieldAction(){
        let textArray = [reviewTextView].filter { $0?.text == "" }
        if !textArray.isEmpty {
            validation()
        
        } else {
            validation()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
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
    
    @objc func TagDeleteAction(_ sender : UIButton){
        let i = sender.tag
        tagArray.remove(at: i)
        tagCollectionView.reloadData()
        collectionViewHeight.constant = tagCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
        print("따란")
        print(collectionViewHeight.constant)
        print(tagArray)
        
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
        let textArray = [disadvantageTextField].filter { $0?.text == "" }
        if !textArray.isEmpty {
            disadvantageEnterButton.isEnabled = false
            disadvantageEnterButton.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
        } else {
            disadvantageEnterButton.isEnabled = true
            disadvantageEnterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }
    }
    
    @objc func advantageButtonClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitleColor(.simsasuksoGreen, for: .selected)
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            sender.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
            
            clickedAdvantageArray.append((sender.titleLabel?.text!)!)
            advantageClickedBook[sender.tag] = 1
            validation()
            print(clickedAdvantageArray)

            
        } else {
            sender.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
            sender.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
            sender.backgroundColor = .clear
            
            clickedAdvantageArray.removeAll{$0 == sender.titleLabel?.text!}
            advantageClickedBook[sender.tag] = 0
            print(clickedAdvantageArray)
            validation()
            
        }
        }
    
    @objc func disaAdvanbuttonClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitleColor(.simsasuksoGreen, for: .selected)
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            sender.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
            
            clickedDisadvantageArray.append((sender.titleLabel?.text!)!)
            disadvantageClickedBook[sender.tag] = 1
            validation()
            print(clickedDisadvantageArray)

            
        } else {
            sender.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
            sender.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
            sender.backgroundColor = .clear
            clickedDisadvantageArray.removeAll{$0 == sender.titleLabel?.text!}
            disadvantageClickedBook[sender.tag] = 0
            print(clickedDisadvantageArray)
            validation()
            
        }
        }



    @IBAction func addTagButtonAction(_ sender: Any) {
        tagTextFieldView.isHidden = false
    }
    
    @IBAction func tagEnterButtonAction(_ sender: Any) {
        tagTextFieldView.isHidden = true
        tagArray.insert(tagTextField.text!, at: tagArray.endIndex-1)
        print(tagArray)
        
        tagCollectionView.reloadData()
        tagTextField.text = ""
        
        collectionViewHeight.constant = tagCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
        print("따란")
        print(collectionViewHeight.constant)
        
        validation()
    }
    
    
    @IBAction func addAdvantageAction(_ sender: Any) {
        advantageTextFieldView.isHidden = false
        
    }
    
    @IBAction func advantageEnterButtonAction(_ sender: Any) {
        advantageTextFieldView.isHidden = true
        advantageArray.insert(advantageTextField.text!, at: advantageArray.endIndex)
        print(advantageArray)
        advantageClickedBook.insert(0, at: advantageClickedBook.endIndex)
        advantageCollectionView.reloadData()
        advantageTextField.text = ""
        
        advantageCollectionViewHeight.constant = advantageCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
        print(advantageCollectionViewHeight.constant)
        
        validation()
    }
    
    
    @IBAction func addDisadvantageButtonAction(_ sender: Any) {
        disadvantageTextFieldView.isHidden = false
    }
    
    
    @IBAction func disadvantageEnterButtonAction(_ sender: Any) {
        
        disadvantageTextFieldView.isHidden = true
        disadvantageArray.insert(disadvantageTextField.text!, at: disadvantageArray.endIndex)
        print(disadvantageArray)
        disadvantageClickedBook.insert(0, at: disadvantageClickedBook.endIndex)
        disadvantageCollectionView.reloadData()
        disadvantageTextField.text = ""
        
        disadvantageCollectionViewHeight.constant = disadvantageCollectionView.collectionViewLayout.collectionViewContentSize.height + 10
        print(disadvantageCollectionViewHeight.constant)
        
        validation()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func preButtonAction(_sender: UIButton){
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func uploadButtonAction(_ sender: Any) {
        self.airbnbInput.tags = tagArray
        self.airbnbInput.pros = clickedAdvantageArray
        self.airbnbInput.cons = clickedDisadvantageArray
        self.airbnbInput.review = reviewTextView.text ?? "후기가 없습니다."
        print(self.airbnbInput)
        UploadAirbnbDataManager().airbnb(parameters: self.airbnbInput, viewcontroller: self)
        
        
        
    }
    
    func validation(){
        if reviewTextView.text != "" && tagArray.count > 1 && clickedAdvantageArray.count > 0 && clickedDisadvantageArray.count > 0{
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        }
        
    }
    
    
}




extension UploadAirbnbFifthStepViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
  
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
                if indexPath.item == tagArray.endIndex-1{
                    let addTagcell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadAirTagCollectionViewCell", for: indexPath) as! UploadAirTagCollectionViewCell
                   
                    if tagArray.count > 5{
                        print("5개 넘음 ")
                        addTagcell.addTagButton.isEnabled = false
                        addTagcell.addTagLabel.text = tagArray[indexPath.row]
                        addTagcell.addTagLabel.textColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                        addTagcell.plusImageView.image = UIImage(named: "plus_gray")
                        addTagcell.layer.borderWidth = 1
                        addTagcell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                        addTagcell.layer.cornerRadius = 4
                        
                      
                    }else{
                        addTagcell.addTagButton.isEnabled = true
                        addTagcell.addTagLabel.text = tagArray[indexPath.row]
                        addTagcell.addTagLabel.textColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                        addTagcell.plusImageView.image = UIImage(named: "plus")
                        addTagcell.layer.borderWidth = 1
                        addTagcell.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                        addTagcell.layer.cornerRadius = 4
                        
                    }
                        
                 
                    cell = addTagcell
                }else{
                    let tagcell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralTagCollectionViewCell", for: indexPath) as! UploadGeneralTagCollectionViewCell
                    
                    tagcell.tagLabel.text = tagArray[indexPath.row]
                    tagcell.layer.borderWidth = 1
                    tagcell.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                    tagcell.layer.cornerRadius = 4
                    tagcell.xButton.tag = indexPath.row
                    tagcell.xButton.addTarget(self, action: #selector(self.TagDeleteAction(_:)), for: UIControl.Event.touchUpInside)
                    
                    cell = tagcell
                }
            }else if collectionView == advantageCollectionView{
                if indexPath.item == 10{
                    let addAdvantagecell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralAddAdvantageCollectionViewCell", for: indexPath) as! UploadGeneralAddAdvantageCollectionViewCell
                    addAdvantagecell.addAdvantageButton.layer.borderWidth = 1
                    addAdvantagecell.addAdvantageButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                    addAdvantagecell.addAdvantageButton.layer.cornerRadius = 4
                    
                    cell = addAdvantagecell
                }else{
                    let advantagecell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: "UploadGeneralAdvantageCollectionViewCell", for: indexPath) as! UploadGeneralAdvantageCollectionViewCell
                    
                    advantagecell.advantageButton.setTitle(advantageArray[indexPath.row], for: .normal)
                    
                    print("indexpath.row : '\(indexPath.row)'")
                    print(advantageClickedBook)
                    
                    if advantageClickedBook[indexPath.row] == 1{
                        advantagecell.advantageButton.isSelected = true
                        advantagecell.advantageButton.layer.borderWidth = 1
                        advantagecell.advantageButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                        advantagecell.advantageButton.layer.cornerRadius = 4
                        advantagecell.advantageButton.setTitleColor(.simsasuksoGreen, for: .selected)
                        advantagecell.advantageButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                    }else{
                        advantagecell.advantageButton.isSelected = false
                        advantagecell.advantageButton.layer.borderWidth = 1
                        advantagecell.advantageButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                        advantagecell.advantageButton.layer.cornerRadius = 4
                        advantagecell.advantageButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                        advantagecell.advantageButton.backgroundColor = .clear
                        
                    }
                    advantagecell.advantageButton.tag = indexPath.row
                    advantagecell.advantageButton.addTarget(self, action: #selector(self.advantageButtonClicked), for: .touchUpInside)
                    
                    cell = advantagecell
                }
                
            }else if collectionView == disadvantageCollectionView{
                if indexPath.item == 10{
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
                    
                    print("indexpath.row : '\(indexPath.row)'")
                    print(disadvantageClickedBook)
                    
                    if disadvantageClickedBook[indexPath.row] == 1{
                        disadvantagecell.disadvantageButton.isSelected = true
                        disadvantagecell.disadvantageButton.layer.borderWidth = 1
                        disadvantagecell.disadvantageButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
                        disadvantagecell.disadvantageButton.layer.cornerRadius = 4
                        disadvantagecell.disadvantageButton.setTitleColor(.simsasuksoGreen, for: .selected)
                        disadvantagecell.disadvantageButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                    }else{
                        disadvantagecell.disadvantageButton.isSelected = false
                        disadvantagecell.disadvantageButton.layer.borderWidth = 1
                        disadvantagecell.disadvantageButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
                        disadvantagecell.disadvantageButton.layer.cornerRadius = 4
                        disadvantagecell.disadvantageButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                        disadvantagecell.disadvantageButton.backgroundColor = .clear
                        
                    }
                    disadvantagecell.disadvantageButton.tag = indexPath.row
                    
                    disadvantagecell.disadvantageButton.addTarget(self, action: #selector(self.disaAdvanbuttonClicked), for: .touchUpInside)
                    
                    cell = disadvantagecell
            }
           
            }
            return cell
}
    
    
    
}


//MARK: - CollectionView FlowLayout
extension UploadAirbnbFifthStepViewController: UICollectionViewDelegateFlowLayout {
    
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

//MARK:- UITEXTVIEW delegate
extension UploadAirbnbFifthStepViewController :UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.textColor == #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1) {

          textView.text = nil

          textView.textColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)

        }

      }

      func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {

          textView.text = "숙소의 실제 후기를 들려주세요 :) (공백 포함 300byte 이내)"

          textView.textColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)

        }

      }
    
    //글자 수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           guard let str = textView.text else { return true }
           let newLength = str.count + text.count - range.length
           return newLength <= 300
       }
    
}
    


extension UploadAirbnbFifthStepViewController{
    
   func success(){
    let uploadVc = self.storyboard?.instantiateViewController(identifier: "UploadCompleteViewController")
            uploadVc?.modalPresentationStyle = .fullScreen
        self.present(uploadVc!, animated: false, completion: nil)
        
    }
    
    func fail(){
        
    }

}

