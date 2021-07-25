//
//  AirEndDatePicker.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/25.
//


import Foundation
import UIKit

class AirEndDatePicker: UIViewController {
    
    weak var delegate: EndDateDelegate?
    
    @IBOutlet weak var chooseButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateformatterforShow = DateFormatter()
    let dateformatterforSave = DateFormatter()
    
    var dateforShow : String = ""
    var dateforSave : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dateformatterforShow.dateStyle = .long
        dateformatterforShow.dateFormat = "YYYY년 MM월 dd일"
        
        dateformatterforSave.dateStyle = .long
        dateformatterforSave.dateFormat = "YYYY-MM-dd"
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)

        
    
    }
    @objc func changed(){
        
        dateforShow = dateformatterforShow.string(from: datePicker.date)
        dateforSave = dateformatterforSave.string(from: datePicker.date)
        
        print(dateforShow)
        print(dateforSave)
        
        

    }
    
    
    
    @IBAction func chooseButtonAction(_ sender: Any) {
        
        self.delegate?.sendEndDate(forSave:dateforSave, forShow: dateforShow)
        
        self.dismiss(animated: false, completion: nil)

    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
}

