//
//  DesignableSlider.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
@IBDesignable
class DesignableSlider: UISlider {

    @IBInspectable var thumbImage : UIImage?{
        
        didSet{
            setThumbImage(thumbImage, for: .normal)
        }
    }

}
