//
//  FeedDetailViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/30.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    lazy var dataManager = FeedDataManager()
    
    var hashTags = [HashTags]()
    var feedImages = [FeedImage]()
    
    var feedComments = [FeedCommentResult]()
            
    var feedIndex = 0
    var saveComment = ""
    
    @IBOutlet var feedDetailView: UIView!
    @IBOutlet var feedDetailScrollView: UIScrollView!
    
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userNicknameLabel: UILabel!
    
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var imageCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var likeNumberLabel: UILabel!
    @IBOutlet var faceIconImageView: UIImageView!
    @IBOutlet var reliabilityLabel: UILabel!

    @IBOutlet var correctionDegreeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var chargeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var prosLabel: UILabel!
    @IBOutlet var consLabel: UILabel!
    
    @IBOutlet var commentNumberLabel: UILabel!
    @IBOutlet var favoriteNumberLabel: UILabel!
    
    @IBOutlet var reviewLabel: UILabel!
    
    @IBOutlet var tagCollectionView: UICollectionView!
    
    @IBOutlet var bookmarkButton: UIButton!
    
    @IBOutlet var correctionToolLabel: UILabel!
  
    @IBOutlet var linkStackView: UIStackView!
    @IBOutlet var seeLinkButton: UIButton!
    
    @IBOutlet var commentTableView: UITableView!
    @IBOutlet var commentTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var commentUserImageView: UIImageView!
    @IBOutlet var commentWriteButton: UIButton!
    
    @IBOutlet weak var commentWriteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.feedView(delegate: self, url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)")
        dataManager.feedComment(delegate: self)
        
        self.navigationController?.navigationBar.isTransparent = true
        self.navigationController?.navigationBar.tintColor = .clear
        
        imageCollectionView.tag = 1
        tagCollectionView.tag = 2
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        imageCollectionViewHeight.constant = view.frame.size.width
        
        imageCollectionView.isPagingEnabled = true
        let imageFlowLayout = UICollectionViewFlowLayout()
        imageFlowLayout.scrollDirection = .horizontal
        self.imageCollectionView.collectionViewLayout = imageFlowLayout
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height/2
        
        linkStackView.isHidden = true
        
        commentUserImageView.layer.cornerRadius = commentUserImageView.frame.size.height/2
        commentWriteButton.layer.cornerRadius = 15
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.commentTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        //navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.commentTableView.removeObserver(self, forKeyPath: "contentSize")
        //navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newvalue = change?[.newKey]{
                let newsize = newvalue as! CGSize
                self.commentTableViewHeight.constant = newsize.height
            }
        }
    }
    
    //MARK: - Function
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        print("게시글 신고")
    }
    @IBAction func heartButtonAction(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
        
        let input = FeedLikeRequest(feedIndex: feedIndex)
        if heartButton.isSelected {
            if heartButton.currentImage == UIImage(named: "heart_fill") {
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                dataManager.dislikeCheck(input, delegate: self, url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)/dislike")
            } else {
                heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
                dataManager.likeCheck(input, delegate: self, url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)/like")
            }
            
        } else {
            if heartButton.currentImage == UIImage(named: "heart") {
                heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
                dataManager.dislikeCheck(input, delegate: self, url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)/like")
            } else {
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                dataManager.likeCheck(input, delegate: self, url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)/dislike")
            }
            
        }
    
    
    }
    
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
        bookmarkButton.isSelected = !bookmarkButton.isSelected
        
        let input = FavoriteCheckRequest(savedListIndex: 35, feedIndex: feedIndex)
        if bookmarkButton.isSelected {
            bookmarkButton.setImage(UIImage(named: "bookmark_Fill"), for: .selected)
            dataManager.favoriteCheck(input, delegate: self)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
            dataManager.favoriteCheck(input, delegate: self)
        }
    
    }
    
    @IBAction func seeLinkButtonAction(_ sender: UIButton) {
        seeLinkButton.isSelected = !seeLinkButton.isSelected
        if seeLinkButton.isSelected {
            linkStackView.isHidden = false
            seeLinkButton.setTitle("링크접기", for: .selected)
            seeLinkButton.setImage(UIImage(systemName: "control"), for: .selected)
        } else {
            linkStackView.isHidden = true
        }
        
    }
    
    @IBAction func commentWriteButtonAction(_ sender: UIButton) {
        print("게시")
        saveComment = commentWriteTextField.text ?? "좋아보여요!"
        dataManager.writeFeedComment(text: saveComment, delegate: self)
    }
    
}


extension FeedDetailViewController : UITextFieldDelegate{
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    //리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentWriteTextField.resignFirstResponder() //텍스트필드 비활성화
        return true
    }
    
}

//MARK: - CollectionView
extension FeedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return feedImages.count
        } else {
            return hashTags.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedImageCollectionViewCell", for: indexPath) as! FeedImageCollectionViewCell
            
            let feedImage = feedImages[indexPath.row]
            
            // 이미지 URL 가져오기
            let urlString = feedImage.source
            if let urlstring = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                cell.imageView.image = UIImage(data: data)
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedTagCollectionViewCell", for: indexPath) as! FeedTagCollectionViewCell
            
            let hashTag = hashTags[indexPath.row]
            
            cell.tagLabel.text = hashTag.hashTags
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
            cell.layer.cornerRadius = 4
            
            return cell
        }
        
    }
    
    
}

//MARK: - CollectionView FlowLayout
extension FeedDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
            let width = view.frame.size.width
            return CGSize(width: width, height: width)
        } else {
            let label = UILabel(frame: CGRect.zero)
            let hashTag = hashTags[indexPath.row]
            label.text = hashTag.hashTags
            label.sizeToFit()

            return CGSize(width: label.frame.width, height: 23)
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 1 {
            return 0
        } else {
            return 8
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView.tag == 1 {
            return 0
        } else {
            return 0
        }
    }
    
}

//MARK: - TableView

extension FeedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCommentTableViewCell", for: indexPath) as! FeedCommentTableViewCell
        
        let feedComment = feedComments[indexPath.row]
        
        cell.userImageView.layer.cornerRadius = userProfileImageView.frame.height/2
        cell.commentLabel.text = feedComment.content
        cell.likeNumberLabel.text = "좋아요 " + String(feedComment.likeNum)
        cell.userNameLabel.text = feedComment.nickname
       
        // 이미지 URL 가져오기
        let urlString = feedComment.avatarUrl
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.userImageView.image = UIImage(data: data)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = 171
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - API
extension FeedDetailViewController {
    func feedView(result: FeedResult) {
        likeNumberLabel.text! = String(result.feedLike!.likeNum!)
        reliabilityLabel.text! = String(result.feedInfo!.reliability!)
        correctionDegreeLabel.text! = String(result.correction!.correctionDegree!)
        reviewLabel.text! = String(result.feedInfo!.review!)
        chargeLabel.text! = String(result.feedInfo!.charge!) + "원"
        favoriteNumberLabel.text! = String(result.save!.saveNum!)
        nameLabel.text! = result.lodgingInfo!.info!
        locationLabel.text! = result.lodgingInfo!.address!
        dateLabel.text! = result.feedInfo!.startDate! + "~" + result.feedInfo!.endDate!
        prosLabel.text! = result.prosAndCons!.pros!.description
        consLabel.text! = result.prosAndCons!.cons!.description
        
        hashTags = result.hashTags!
        tagCollectionView.reloadData()
        
        let correctionToolContents = result.correction!.correctionTool!.joined()
        correctionToolLabel.text! = correctionToolContents
        
        feedImages = result.feedImage!
        imageCollectionView.reloadData()
       
        // 좋아요
        if result.feedLike?.isLiked == 1 { // Yes
            heartButton.setImage(UIImage(named: "heart_fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        // 찜
        if result.save?.isSaved == 1 { // Yes
            bookmarkButton.setImage(UIImage(named: "bookmark_Fill"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        }
        
    }
    
    func feedComment(result: FeedCommentResponse) {
        feedComments = result.result!
        commentNumberLabel.text = String(feedComments.count)
        commentTableView.reloadData()
    }
    
    func writeFeedComment(result : WriteFeedCommentResponse){
            dataManager.feedComment(delegate: self)
           
            
        }
    
    func favoriteCheck(_ result: FavoriteCheckResponse) { // 찜
        self.presentAlert(title: result.message)
    }
    
    func likeCheck(_ result: FeedLikeResponse) { // 좋아요
        self.presentAlert(title: "좋아요")
    }
    
    func dislikeCheck(_ result: FeedDislikeResponse) { // 좋아요 취소
        self.presentAlert(title: "좋아요 취소")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


