//
//  FeedDetailViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/30.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    lazy var dataManager = FeedDataManager()
    
    var prosAndCons = [ProsAndCons]()
    var feedImages = [FeedImage]()
    var feedTags = [feedInfo]()
    
    var feedComments = [FeedCommentResult]()
    
    var textArray = ["태그", "태그ㅇㅇㅇ", "태그태그태그태"]
    
    var images: [UIImage] = [#imageLiteral(resourceName: "Rectangle"), #imageLiteral(resourceName: "comment_heart_fill"), #imageLiteral(resourceName: "heart_fill")]
    var imageViews = [UIImageView]()
    var hashTags = [String]()
    
    var feedIndex = 1
    
    @IBOutlet var feedDetailView: UIView!
    @IBOutlet var feedDetailScrollView: UIScrollView!
    
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userNicknameLabel: UILabel!
    
    @IBOutlet var imageScrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.feedView(delegate: self, url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)")
        dataManager.feedComment(delegate: self)
        
        self.navigationController?.navigationBar.isTransparent = true
        self.navigationController?.navigationBar.tintColor = .clear
        
        imageScrollView.delegate = self
        addContentScrollView()
        setPageControl()
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
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
        print("게시글 삭제")
    }
    @IBAction func heartButtonAction(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
        
        if heartButton.isSelected {
            heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
            print("좋아요")
        } else {
            heartButton.setImage(UIImage(named: "heart"), for: .normal)
            print("좋아요취소")
        }
        
    }
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
        bookmarkButton.isSelected = !bookmarkButton.isSelected
        
        let input = FavoriteCheckRequest(savedListIndex: 35, feedIndex: 35)
        if bookmarkButton.isSelected {
            bookmarkButton.setImage(UIImage(named: "bookmark_Fill"), for: .selected)
            dataManager.favoriteCheck(input, delegate: self)
            print("찜")
        } else {
            bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
            dataManager.favoriteCheck(input, delegate: self)
            print("찜취소")
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
    }
    
}

//MARK: - Image ScrollView
extension FeedDetailViewController: UIScrollViewDelegate {
    
    // imageScrollView
    func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: imageScrollView.bounds.width, height: imageScrollView.bounds.height)
            imageView.image = images[i]
            imageScrollView.addSubview(imageView)
            imageScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
}
//MARK: - CollectionView
extension FeedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedTagCollectionViewCell", for: indexPath) as! FeedTagCollectionViewCell
        
        cell.tagLabel.text = hashTags[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        cell.layer.cornerRadius = 4
        
        return cell
    }
    
    
}

//MARK: - CollectionView FlowLayout
extension FeedDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = textArray[indexPath.item]
        label.sizeToFit()

        return CGSize(width: label.frame.width, height: 23)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
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
        //correctionDegreeLabel.text! = String(result.correction!.correctionDegree!)
        reviewLabel.text! = String(result.feedInfo!.review!)
        chargeLabel.text! = String(result.feedInfo!.charge!) + "원"
        favoriteNumberLabel.text! = String(result.save!.saveNum!)
        
//        let correctionToolContents = result.correction!.correctionTool!.joined()
//        correctionToolLabel.text! = correctionToolContents
        
        feedImages = result.feedImage!
        
        nameLabel.text! = result.lodgingInfo!.info!
        locationLabel.text! = result.lodgingInfo!.address!
        dateLabel.text! = result.feedInfo!.startDate! + "~" + result.feedInfo!.endDate!
        
        prosAndCons = result.prosAndCons!
        prosLabel.text! = prosAndCons.description
       
        // 좋아요
        if result.feedLike?.isLiked == 1 { // Yes
            heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
        } else {
            heartButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        // 찜
        if result.save?.isSaved == 1 { // Yes
            bookmarkButton.setImage(UIImage(named: "bookmark_Fill"), for: .selected)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        }
        
    }
    
    func feedComment(result: FeedCommentResponse) {
        feedComments = result.result!
        commentNumberLabel.text = String(feedComments.count)
        commentTableView.reloadData()
    }
    
    func favoriteCheck(_ result: FavoriteCheckResponse) {
        self.presentAlert(title: "성공")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


