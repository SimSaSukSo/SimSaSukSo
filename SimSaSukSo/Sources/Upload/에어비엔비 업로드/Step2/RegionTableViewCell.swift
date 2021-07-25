//
//  RegionTableViewCell.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/14.
//

import UIKit

protocol RegionCellDelegate {
    func didPressButton(for index: Int,clicked: Bool)
}


class RegionTableViewCell: UITableViewCell {
    
    var delegate: RegionCellDelegate?
    var index: Int?
    
    @IBOutlet weak var regionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    
    
    }

    @IBAction func didPressButton(_ sender: UIButton) {
            guard let idx = index else {return}
            if sender.isSelected {
                isTouched = true
                delegate?.didPressButton(for: idx, clicked: true)
            }else {
                isTouched = false
                delegate?.didPressButton(for: idx, clicked: false)
            }
            sender.isSelected = !sender.isSelected
        }
    
    var isTouched: Bool? {
            didSet {
                if isTouched == true {
                    
                    regionButton.setTitleColor(.simsasuksoGreen, for: .normal)
                   print("클릭")
                
                }else{
                    
                    regionButton.setTitleColor(.black, for: .normal)
                    regionButton.setTitleColor(.black, for: .selected)
                    print("안클릭")
                   
                }
            }
        }
    
    
    
}
