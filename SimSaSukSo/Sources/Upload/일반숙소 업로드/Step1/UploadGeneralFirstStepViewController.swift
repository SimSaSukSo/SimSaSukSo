//
//  UploadGeneralPageOne.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/03.
//

import UIKit



class UploadGeneralFirstStepViewController : UIViewController{
    
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
    var regionList : [documentsDetail] = []
    var keyword : String = ""
    @IBOutlet weak var HotelNameTextField: UITextField!
    @IBOutlet weak var searchHotelTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var regionTableView: UITableView!
    @IBOutlet weak var FirstPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var regionTableviewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableviewLayout()
        
        nextButton.isEnabled = false
        HotelNameTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
       
       
        
        self.generalInput.images = UploadViewController.urlArray
        
        print("url :")
        print(self.generalInput.images)
        
        FirstPictureCollectionView.dataSource = self
        FirstPictureCollectionView.delegate = self
        
        searchHotelTableView.dataSource = self
        searchHotelTableView.delegate = self
    }
    
    
    func setTableviewLayout(){
    
        searchHotelTableView.isHidden = true
        
        searchHotelTableView.layer.masksToBounds = false
        searchHotelTableView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchHotelTableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchHotelTableView.layer.shadowOpacity = 0.1
        
    }
    
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [HotelNameTextField].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
           
            searchHotelTableView.isHidden = true
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        } else {
            //버튼 활성화
          
            
           
            keyword = HotelNameTextField.text!
            regionNameDataManager().regionName(keyword: "\(keyword)", viewcontroller: self)
            
            
            
            
            
        }
    }
    
   
    
    
    @IBAction func priorButtonAction(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        let secondVc = self.storyboard?.instantiateViewController(identifier: "UploadGeneralSecondStepViewController")as!UploadGeneralSecondStepViewController
        secondVc.modalPresentationStyle = .fullScreen
        
        secondVc.generalInput = self.generalInput
      
        self.present(secondVc, animated: false, completion: nil)
        
    }
    
    
}

extension UploadGeneralFirstStepViewController : UITextFieldDelegate{
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    //리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        HotelNameTextField.resignFirstResponder() //텍스트필드 비활성화
        return true
    }
    
}
extension UploadGeneralFirstStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureFirstCollectionViewCell", for: indexPath) as! UploadedPictureFirstCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        
        uploadGeneralcell.firstPictureImageView.image = photos
        
        return uploadGeneralcell
    }
    
}

extension UploadGeneralFirstStepViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchHotelTableViewCell", for: indexPath) as! searchHotelTableViewCell
        
        searchCell.hotelNameLabel.text = regionList[indexPath.row].place_name
        searchCell.hotelAddressLabel.text = regionList[indexPath.row].address_name
        
       // keyword포함하는 hotelnamelabel.text 색상 변경
        let text = searchCell.hotelNameLabel.text
        let attributeString = NSMutableAttributedString(string: text!)
        attributeString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1), range: (text! as NSString).range(of: keyword, options: .caseInsensitive))
      
        searchCell.hotelNameLabel.attributedText = attributeString

       
        return searchCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        HotelNameTextField.text = regionList[indexPath.row].place_name
        self.generalInput.name = regionList[indexPath.row].place_name
        self.generalInput.address = regionList[indexPath.row].address_name
        
        nextButton.isEnabled = true
        nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        
        searchHotelTableView.isHidden = true
    }
    
    
    
    
    
    
}




//MARK:- API
extension UploadGeneralFirstStepViewController{
    func success(result : [documentsDetail]){
        regionList = result
        
        print(regionList.count)
        searchHotelTableView.reloadData()
        
        if regionList.count > 7{
            regionTableviewHeight.constant = 60 * 7
        }else{
            regionTableviewHeight.constant = regionTableView.contentSize.height
        }
        
        searchHotelTableView.isHidden = false
        
        
        
    }
    
    
    
    
}



