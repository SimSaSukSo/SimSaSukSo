//
//  FeedFavoriteAlertViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/06.
//

import UIKit


class FeedFavoriteAlertViewController: UIViewController {
    
    var delegate: bookmarkDelegate?
    
    var feedIndex : Int = 0
    var favoriteLists: [FavoriteResult] = []
    var favoriteIndex = 0
    
    var text: String = ""
    var selectedFavoriteIndex : Int = 0
    @IBOutlet var alertView: UIView!
    @IBOutlet var editTableView: UITableView!
    @IBOutlet var editTableViewHeight: NSLayoutConstraint!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        editTableView.delegate = self
        editTableView.dataSource = self
        
        editTableViewHeight.constant = CGFloat(51 * 3)
        
        FavoriteDataManager().favoriteList(delegate: self)
        
    }
    
    override func viewWillLayoutSubviews() {
        FavoriteDataManager().favoriteList(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FavoriteDataManager().favoriteList(delegate: self)
    }
    

    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
 
            let input = FavoriteCheckRequest(savedListIndex: selectedFavoriteIndex, feedIndex: feedIndex)
        print("보낼값 : \(input)")
        
        FeedDataManager().favoriteCheck(input, delegate: self)
        
    }
    
    
}

extension FeedFavoriteAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteEditTableViewCell", for: indexPath) as! FavoriteEditTableViewCell
        
        let favoriteList = favoriteLists[indexPath.row]
        
        cell.editTextField.layer.cornerRadius = 4
        cell.editTextField.setLeftPaddingPoints(10)
        //cell.delegate = self
        
        
        cell.editTextField.text = favoriteList.title
        
        let background = UIView()

            background.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
        

        cell.selectedBackgroundView = background
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("테이블뷰 인덱스 : \(indexPath.row)")
        print("찜 목록 고유값 : \(favoriteLists[indexPath.row].savedListIndex)")
        selectedFavoriteIndex = favoriteLists[indexPath.row].savedListIndex
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
}

//MARK: - API
extension FeedFavoriteAlertViewController {
    func favoriteLists(result: FavoriteResponse) {
        print(result)
      
        favoriteLists = result.result!
        editTableView.reloadData()
    }
    
    func favoriteCheck(_ result: FavoriteCheckResponse) { // 찜
        self.presentAlert(title: result.message)
        
        if result.message == "성공"{
            delegate?.toFilledButton()
        }else if result.message == "찜 해제 성공"{
            delegate?.toVacantButton()
        }
        
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

