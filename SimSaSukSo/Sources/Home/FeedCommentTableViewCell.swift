//
//  FeedCommentTableViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/30.
//

import UIKit

class FeedCommentTableViewCell: UITableViewCell {
    
    lazy var dataManager = FeedDataManager()
    
    var commentIndex = 0
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeNumberLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func heartButtonAction(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
        if heartButton.isSelected {
            heartButton.setImage(UIImage(named: "comment_heart_fill"), for: .selected)
            dataManager.commentLikeCheck(delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(commentIndex)/like")
        } else {
            heartButton.setImage(UIImage(named: "comment_heart"), for: .normal)
            dataManager.commentdislikeCheck(delegate: self, url: "\(Constant.BASE_URL)api/feeds/\(commentIndex)/dislike")
        }
        
        
    }
}

//MARK: - API
extension FeedCommentTableViewCell {
    func commentLikeCheck(result: CommentLikeResponse) {
        print("좋아요 성공")
        print(commentIndex)
    }
    
    func commentDislikeCheck(result: CommentDislikeResponse) {
        print("좋아요 취소 성공")
    }
    
    func failedToRequest(message: String) {
        print(message)
    }
}
