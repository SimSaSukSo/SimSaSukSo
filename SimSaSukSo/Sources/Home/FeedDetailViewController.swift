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
            
    var feedIndex = 1
    var saveComment = ""
    
    var favoriteLists: [FavoriteResult] = []
    
    var indexList : [Int] = []
    
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
        
        dataManager.feedView(delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)")
        dataManager.feedComment(url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)/comments", delegate: self)
        FavoriteDataManager().favoriteList(delegate: self)
        
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
        
        commentWriteTextField.delegate = self
        
        setKeyboardObserver()

        print(feedIndex)
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
    
    @IBAction func tabGesture(_ sender: Any) {
        view.endEditing(true)

    }
    //MARK: - Function
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        print("게시글 신고")
        FeedDataManager().report(idx: feedIndex, delegate: self)
    }
    @IBAction func heartButtonAction(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
        print(feedIndex)
        let input = FeedLikeRequest(feedIndex: feedIndex)
        if heartButton.isSelected {
            if heartButton.currentImage == UIImage(named: "heart_fill") {
                //heartButton.setImage(UIImage(named: "heart"), for: .normal)
                dataManager.dislikeCheck(input, delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)/dislike")
            } else {
               // heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
                dataManager.likeCheck(input, delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)/like")
            }
            
        } else {
            if heartButton.currentImage == UIImage(named: "heart") {
              //  heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
                dataManager.dislikeCheck(input, delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)/like")
            } else {
              //  heartButton.setImage(UIImage(named: "heart"), for: .normal)
                dataManager.likeCheck(input, delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)/dislike")
            }
            
        }
    
    
    }
    
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
        bookmarkButton.isSelected = !bookmarkButton.isSelected
        print(indexList)
        var indexlist = indexList
        
      
        if bookmarkButton.isSelected {
            
            if indexlist == []{
                presentAlert(title: "찜 목록을 먼저 생성하세요")
                bookmarkButton.isSelected = false
            }else{
                let input = FavoriteCheckRequest(savedListIndex: indexList.first!, feedIndex: feedIndex)
                bookmarkButton.setImage(UIImage(named: "bookmark_Fill"), for: .selected)
                dataManager.favoriteCheck(input, delegate: self)
            }
            
        } else {
            bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
            let input = FavoriteCheckRequest(savedListIndex: indexList.first!, feedIndex: feedIndex)
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
        print(saveComment)
        dataManager.writeFeedComment(text: saveComment, url:  "\(Constant.BASE_URL)api/feeds/\(feedIndex)/comments", delegate: self)
       

    }
    
    @IBAction func commentReportAction(_ sender: Any) {
        presentAlert(title: "부적절한 댓글은 hs7198@naver.com으로 신고해주세요. 24시간 내에 처리가 완료 됩니다.")
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
        print(result)
        likeNumberLabel.text! = String(result.feedLike!.likeNum ?? 0)
        reliabilityLabel.text! = String(result.feedInfo!.reliability ?? 0)
        correctionDegreeLabel.text! = String(result.correction!.correctionDegree ?? 0)
        reviewLabel.text! = String(result.feedInfo!.review ?? "좋아요")
        chargeLabel.text! = String(result.feedInfo!.charge ?? 20000) + "원"
        favoriteNumberLabel.text! = String(result.save!.saveNum ?? 0)
        nameLabel.text! = result.lodgingInfo!.info ?? "숙소"
        locationLabel.text! = result.lodgingInfo!.address ?? "주소"
        let start = result.feedInfo?.startDate ?? ""
        let end = result.feedInfo?.endDate ?? ""
        dateLabel.text! = start  + "~" + end
        prosLabel.text! = result.prosAndCons?.pros?.description ?? "꺠끗함"
        consLabel.text! = result.prosAndCons?.cons?.description ?? "더러움"
        
        hashTags = result.hashTags!
        tagCollectionView.reloadData()
        
        let correctionToolContents = result.correction!.correctionTool?.joined()
        correctionToolLabel.text = correctionToolContents ?? ""
        
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
        print(result)

        commentTableView.reloadData()
    }
    
    func writeFeedComment(result : WriteFeedCommentResponse){
        dataManager.feedComment(url: "https://dev.enudgu.shop/api/feeds/\(feedIndex)/comments", delegate: self)
        commentWriteTextField.text = ""
           print("저장됨")
        }
    
    func favoriteCheck(_ result: FavoriteCheckResponse) { // 찜
        self.presentAlert(title: result.message)
    }
    
    func likeCheck(_ result: FeedLikeResponse) { // 좋아요
//        let stringLikenum = likeNumberLabel.text!
//        print(likeNumberLabel.text!)
//        print("string:\(stringLikenum)")
//        if let favoriteNumber = Int(stringLikenum){
//            likeNumberLabel.text =  String(favoriteNumber + 1)
//            print(likeNumberLabel.text!)
//            }
        
        //self.presentAlert(title: "좋아요")
        dataManager.feedView(delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)")
    }
    
    func dislikeCheck(_ result: FeedDislikeResponse) { // 좋아요 취소
//        let stringLikenum = likeNumberLabel.text!
//        print("string:\(stringLikenum)")
//        print(stringLikenum)
//        if let favoriteNumber = Int(stringLikenum){
//            likeNumberLabel.text =  String(favoriteNumber - 1)
//            print(likeNumberLabel.text)
//        }
       // self.presentAlert(title: "좋아요 취소")
        dataManager.feedView(delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(feedIndex)")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
    func commentDefaultValue(){
        let defaultComment : FeedCommentResponse = FeedCommentResponse(isSuccess: true, code: 1000, message: "성공", result: Optional([SimSaSukSo.FeedCommentResult(commentIndex: 1, userIndex: 2, nickname: "희동", avatarUrl: "https://avatars.githubusercontent.com/u/59307414?v=4", content: "여기 저도 가봤는데 좋았어요", createdAt: "2021-07-16T19:32:26.000Z", updatedAt: "2021-07-16T19:32:26.000Z", likeNum: 0), SimSaSukSo.FeedCommentResult(commentIndex: 9, userIndex: 16, nickname: "hello12", avatarUrl: "http://k.kakaocdn.net/dn/bcBBrM/btq5OT2aZzC/NI1C3kETk7YFJ4KS0cfaQ0/img_640x640.jpg", content: "우와 숙소 너무 좋아보여요", createdAt: "2021-07-16T19:36:12.000Z", updatedAt: "2021-07-16T19:36:42.000Z", likeNum: 0), SimSaSukSo.FeedCommentResult(commentIndex: 10, userIndex: 17, nickname: "hello33", avatarUrl: "http://k.kakaocdn.net/dn/bcBBrM/btq5OT2aZzC/NI1C3kETk7YFJ4KS0cfaQ0/img_640x640.jpg", content: "좋은 곳 갔다오셨네요!", createdAt: "2021-07-16T19:36:12.000Z", updatedAt: "2021-07-16T19:36:42.000Z", likeNum: 0)]))
        
        feedComments = defaultComment.result!
        commentNumberLabel.text = String(feedComments.count)
    
        commentTableView.reloadData()
        
        
        
    }
    func feedDefaultValue(){
       let defaultValue : FeedResult = FeedResult(feedImage: Optional([SimSaSukSo.FeedImage(feedImageIndex: Optional(1), source: Optional("https://a0.muscache.com/im/pictures/30a9a161-aa55-430d-b1fd-108581d8358c.jpg?im_w=960"), uploadOrder: Optional(1)), SimSaSukSo.FeedImage(feedImageIndex: Optional(2), source: Optional("https://a0.muscache.com/im/pictures/ca51cacc-b787-4bb3-ab46-7b6e836fd648.jpg?im_w=720"), uploadOrder: Optional(2)), SimSaSukSo.FeedImage(feedImageIndex: Optional(3), source: Optional("https://a0.muscache.com/im/pictures/ef7d6fc8-36a1-477d-b1ae-9b31d4df096a.jpg?im_w=720"), uploadOrder: Optional(3))]), feedLike: Optional(SimSaSukSo.FeedLike(likeNum: Optional(6), isLiked: Optional(0))), correction: Optional(SimSaSukSo.Correction(correctionToolIndex: Optional([1, 3]), correctionTool: Optional(["기본 카메라", "보정필터"]), correctionDegree: Optional(5))), save: Optional(SimSaSukSo.Save(saveNum: Optional(0), isSaved: Optional(0))), prosAndCons: Optional(SimSaSukSo.ProsAndCons(cons: Optional("더러움,서비스나쁨"), pros: Optional("가성비,깨끗함,룸서비스"))), feedInfo: Optional(SimSaSukSo.FeedInfo(review: Optional("너무 좋았습니다"), charge: Optional(54000), startDate: Optional("2021-06-01"), endDate: Optional("2021-06-03"), createdAt: Optional("2021-06-29"), reliability: Optional(3), hashTags: nil)), hashTags: Optional([SimSaSukSo.HashTags(hashTags: Optional("가성비")), SimSaSukSo.HashTags(hashTags: Optional("뷰맛집")), SimSaSukSo.HashTags(hashTags: Optional("힐링")), SimSaSukSo.HashTags(hashTags: Optional("우정여행"))]), lodgingInfo: Optional(SimSaSukSo.LodgingInfo(lodgingIndex: Optional(1), info: Optional("가나다 호텔"), address: Optional("서울특별시 종로구 명륜3가동 성균관로 25-2"))))
        
        likeNumberLabel.text! = String(defaultValue.feedLike!.likeNum!)
        reliabilityLabel.text! = String(defaultValue.feedInfo!.reliability!)
        correctionDegreeLabel.text! = String(defaultValue.correction!.correctionDegree!)
        reviewLabel.text! = String(defaultValue.feedInfo!.review!)
        chargeLabel.text! = String(defaultValue.feedInfo!.charge!) + "원"
        favoriteNumberLabel.text! = String(defaultValue.save!.saveNum!)
        nameLabel.text! = defaultValue.lodgingInfo!.info!
        locationLabel.text! = defaultValue.lodgingInfo!.address!
        dateLabel.text! = defaultValue.feedInfo!.startDate! + "~" + defaultValue.feedInfo!.endDate!
        prosLabel.text! = defaultValue.prosAndCons!.pros!.description
        consLabel.text! = defaultValue.prosAndCons!.cons!.description
        
        hashTags = defaultValue.hashTags!
        tagCollectionView.reloadData()
        
        let correctionToolContents = defaultValue.correction!.correctionTool!.joined()
        correctionToolLabel.text! = correctionToolContents
        
        feedImages = defaultValue.feedImage!
        imageCollectionView.reloadData()
       
        // 좋아요
        if defaultValue.feedLike?.isLiked == 1 { // Yes
            heartButton.setImage(UIImage(named: "heart_fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(named: "heart"), for: .normal)
        }
        
        // 찜
        if defaultValue.save?.isSaved == 1 { // Yes
            bookmarkButton.setImage(UIImage(named: "bookmark_Fill"), for: .normal)
        } else {
            bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        }
        

    }
    

    //찜 조회
        
    func favoriteLists(result: FavoriteResponse) {
        favoriteLists = result.result!
        print(favoriteLists)
        print(favoriteLists.count)
        if favoriteLists.count > 0 {
            for i in 0...favoriteLists.count - 1{
                indexList.append(favoriteLists[i].savedListIndex)
                
            }
        }
        
          print(self.indexList)
        }
    
    //신고하기 성공
    func report(result : String){
        
        presentAlert(title: result)
    }
      
}
