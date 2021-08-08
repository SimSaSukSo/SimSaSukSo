//
//  EvaluViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/02.
//

import UIKit

class EvaluViewController: UIViewController {
    
    lazy var dataManager = EvaluDataManager()
    var evaluResults: [EvaluResult] = []
    
    var type = 1 // 1: 일반숙소 2: 에어비앤비
    var lodgingIndex = 3 // 숙소 인덱스
    
    var feedbacks = EvaluFeedback(feedIndex: 0, degree: 0)
    var input: EvaluFeedbackRequest = EvaluFeedbackRequest(feedbacks: [])
    
    
    @IBOutlet var evaluCollectionView: UICollectionView!
    @IBOutlet var evaluCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        evaluCollectionView.delegate = self
        evaluCollectionView.dataSource = self
        
        evaluCollectionViewHeight.constant = 192 * 10
        
        dataManager.evaluView(type: type, lodgingIndex: lodgingIndex, delegate: self)
        
        
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        feedbacks.degree = 5
        feedbacks.feedIndex = 3

        dataManager.evaluFeedback(input, delegate: self)
        
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: "EvaluAlertViewController")

        self.present(alertVC!, animated: false, completion: nil)
    }

    
}

//MARK: - CollectionView
extension EvaluViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return evaluResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EvaluCollectionViewCell", for: indexPath) as! EvaluCollectionViewCell
        
        cell.setupViews()
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.height/2
        
        let evalueResult = evaluResults[indexPath.row]
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
    func evaluView(result: EvaluResponse) {
        evaluResults = result.result!
        evaluCollectionView.reloadData()
    }
    
    func evaluFeedback(_ result: EvaluFeedbackResponse) {
        self.presentAlert(title: "평가 성공")
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
