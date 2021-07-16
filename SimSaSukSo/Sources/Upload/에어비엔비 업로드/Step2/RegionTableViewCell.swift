//
//  RegionTableViewCell.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/14.
//

import UIKit

class RegionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var regionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    var isTouched:Bool?{
//
//        didSet{
//            if isTouched == true{
//
//                regionButton.setTitleColor(.simsasuksoGreen, for: .normal)
//
//
//            }else{
//                regionButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
//
//
//                
//            }
//
//
//
//        }
//    }
//    @IBAction func cellClicked(_ sender: UIButton) {
//       
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected {
//            SelectRegionViewController.clickList[sender.tag] = 1
//            print(clickList)
//           // sender.setTitleColor(.simsasuksoGreen, for: .selected)
//            
//            
//        } else {
//            //sender.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
//            
//            
//        }
//        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
