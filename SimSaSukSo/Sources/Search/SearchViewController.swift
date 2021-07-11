//
//  SearchViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class SearchViewController : UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
    }
    
}

//MARK: - searchBar
extension SearchViewController {
   //UIColor.init(red: 166, green: 176, blue: 186, alpha: 1)
    func setupSearchBar() {
       
        searchBar.placeholder = "검색어를 입력하세요."
        searchBar.setImage(UIImage(named: "search_Icon"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "search_Clear"), for: .clear, state: .normal)
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        searchBar.layer.cornerRadius = 4
        
        
        
//        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
//            //textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
//
//            textField.textColor = UIColor.black
//            textField.backgroundColor = .clear
//
//            if let leftView = textField.leftView as? UIImageView {
//                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
//            }
//            if let rightView = textField.rightView as? UIImageView {
//                rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
//            }
//
//        }
        
    }
}
