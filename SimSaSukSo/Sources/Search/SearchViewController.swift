//
//  SearchViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class SearchViewController : UIViewController{
    
    var pageViewController: SearchPageViewController!
    
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
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            changeLineColor()
        }
    }
    
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
        
        lineViewLists.append(allLineView)
        lineViewLists.append(houseLineView)
        lineViewLists.append(tagLineView)
        lineViewLists.append(locationLineView)
        
        allLineView.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        houseLineView.backgroundColor = .clear
        tagLineView.backgroundColor = .clear
        locationLineView.backgroundColor = .clear

    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    func changeLineColor() {
        for (index, element) in lineViewLists.enumerated() {
            if index == currentIndex {
                element.backgroundColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
            }
            else {
                element.backgroundColor = .clear
            }
        }
    }
    
    func changeButtonAndLineColor() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PageViewController" {
            guard let vc = segue.destination as? SearchPageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        
        let filterNV = self.storyboard?.instantiateViewController(identifier: "filterNV")
        filterNV?.modalPresentationStyle = .fullScreen
     
        self.present(filterNV!, animated: false, completion: nil)
        
        
    }
    @IBAction func allButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
        changeButtonAndLineColor()
    }
    @IBAction func houseButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
        changeButtonAndLineColor()

    }
    @IBAction func tagButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 2)
        changeButtonAndLineColor()

    }
    @IBAction func locationButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 3)
        changeButtonAndLineColor()

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
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)

            let backgroundView = textField.subviews.first
            if #available(iOS 11.0, *) {
                backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                backgroundView?.subviews.forEach({ $0.removeFromSuperview() }) 
            }
            backgroundView?.layer.cornerRadius = 10.5
            backgroundView?.layer.masksToBounds = true
          
        }
        
    }
}
