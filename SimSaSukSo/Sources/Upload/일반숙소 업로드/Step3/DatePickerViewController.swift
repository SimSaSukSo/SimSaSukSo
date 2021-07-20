//
//  DatePickerViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/20.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    
    
    @IBOutlet weak var chooseButton: UIButton!
    

    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateformatter = DateFormatter()
    var date : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dateformatter.dateStyle = .long
        dateformatter.dateFormat = "yyyy년 MM월 dd일"
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)

        
    
    }
    @objc func changed(){
        
        date = dateformatter.string(from: datePicker.date)
               print(date)
        
        

    }
    
    
    
    @IBAction func chooseButtonAction(_ sender: Any) {
        
        let upload3VC =
            self.storyboard?.instantiateViewController(identifier: "UploadGeneralThirdStepViewController")as!UploadGeneralThirdStepViewController
        
        upload3VC.startDateButton?.setTitle(date, for: .normal)
        
        self.dismiss(animated: false, completion: nil)

    }
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
}
