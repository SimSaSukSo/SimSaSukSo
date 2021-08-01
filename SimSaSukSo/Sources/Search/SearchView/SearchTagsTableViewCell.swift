//
//  SearchTagsTableViewCell.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/01.
//

import UIKit

class SearchTagsTableViewCell: UITableViewCell {

  
    @IBOutlet var firstLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        firstLabel.text = ""
        self.accessoryType = .none
        
    }

}
