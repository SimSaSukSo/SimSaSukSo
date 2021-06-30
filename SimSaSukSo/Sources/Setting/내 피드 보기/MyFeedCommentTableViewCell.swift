//
//  CommentTableViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/29.
//

import UIKit

class MyFeedCommentTableViewCell: UITableViewCell {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    

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
        } else {
            heartButton.setImage(UIImage(named: "comment_heart"), for: .normal)
        }
        
        
    }
    
}
