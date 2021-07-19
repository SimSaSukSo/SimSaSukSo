//
//  FavoriteAddLeftPadding.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/20.
//
import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){ //왼쪽에 여백 주기
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
