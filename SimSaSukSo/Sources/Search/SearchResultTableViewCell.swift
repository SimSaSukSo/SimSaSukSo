//
//  SearchResultTableViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/12.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
