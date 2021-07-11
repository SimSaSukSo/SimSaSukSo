//
//  SearchViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class SearchViewController : UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var allButton: UIButton!
    @IBOutlet var houseButton: UIButton!
    @IBOutlet var tagButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var allLineView: UIView!
    @IBOutlet var houseLineView: UIView!
    @IBOutlet var tagLineView: UIView!
    @IBOutlet var locationLineView: UIView!
    @IBOutlet var airButton: UIButton!
    
    var buttonLists: [UIButton] = []
    var lineViewLists: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airButton.layer.borderWidth = 1
        airButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        airButton.layer.cornerRadius = 4
        
        setupSearchBar()
        setupLists()
    }
    
    //MARK: - Fuction
    
    func setupLists() {
        buttonLists.append(allButton)
        buttonLists.append(houseButton)
        buttonLists.append(tagButton)
        buttonLists.append(locationButton)
        
        allButton.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        houseButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        tagButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        locationButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        
        allButton.tag = 1
        houseButton.tag = 2
        tagButton.tag = 3
        locationButton.tag = 4
        
        lineViewLists.append(allLineView)
        lineViewLists.append(houseLineView)
        lineViewLists.append(tagLineView)
        lineViewLists.append(locationLineView)
        
        allLineView.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        houseLineView.backgroundColor = .clear
        tagLineView.backgroundColor = .clear
        locationLineView.backgroundColor = .clear
        
        allLineView.tag = 1
        houseLineView.tag = 2
        tagLineView.tag = 3
        locationLineView.tag = 4

    }
    
    func changeButtonColor() {
        for (button) in buttonLists {
            for (view) in lineViewLists {
                if button.isTouchInside {
                    button.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                    if button.tag == view.tag  {
                        view.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                    } else {
                        view.backgroundColor = .clear
                    }
                } else {
                    button.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
                }
            }
           
        }
    
    }
    
    @IBAction func allButtonAction(_ sender: UIButton) {
        changeButtonColor()
    }
    @IBAction func houseButtonAction(_ sender: UIButton) {
        changeButtonColor()
    }
    @IBAction func tagButtonAction(_ sender: UIButton) {
        changeButtonColor()
    }
    @IBAction func locationButtonAction(_ sender: UIButton) {
        changeButtonColor()
    }
    
    @IBAction func airButtonAction(_ sender: UIButton) {
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
