//
//  FavoriteEditTableViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/16.
//

import UIKit

class FavoriteEditTableViewCell: UITableViewCell {
    
    //var delegate: editCellProtocol!
        
    @IBOutlet var editTextField: UITextField!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteButtonAction(_ sender: UIButton) {
        //self.delegate.presentDeleteVC()
    }
    
}
