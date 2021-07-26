//
//  EvaluViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/02.
//

import UIKit

class EvaluViewController: UIViewController {
    
    lazy var dataManager = EvaluDataManager()
    var evalueResults: [EvalueResult] = []
    
    var type = 1 // 1: 일반숙소 2: 에어비앤비
    var lodgingIndex = 3 // 숙소 인덱스
    
    @IBOutlet var evaluCollectionView: UICollectionView!
    @IBOutlet var evaluCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        evaluCollectionView.delegate = self
        evaluCollectionView.dataSource = self
        
        evaluCollectionViewHeight.constant = 192 * 10
        
        dataManager.evaluView(delegate: self, url: "https://dev.enudgu.shop/api/feedbacks?type=1&lodging=3")
        
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: "EvaluAlertViewController")

        self.present(alertVC!, animated: false, completion: nil)
    }
    
}

//MARK: - CollectionView
extension EvaluViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return evalueResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EvaluCollectionViewCell", for: indexPath) as! EvaluCollectionViewCell
        
        cell.setupViews()
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.height/2
        
        let evalueResult = evalueResults[indexPath.row]
        cell.userIdLabel.text = evalueResult.nickname
        
        // 이미지 URL 가져오기
        let urlString = evalueResult.avatarUrl
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            cell.userImageView.image = UIImage(data: data)
        }
      
        
        return cell
    }
    
}

extension EvaluViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 391, height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - API
extension EvaluViewController {
    func evalueView(result: EvaluResponse) {
        evalueResults = result.result!
        evaluCollectionView.reloadData()
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
