//
//  ProfileViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/20.
//

import UIKit
import MobileCoreServices

class ProfileViewController: UIViewController {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var userNicknameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height/2
        
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height/2
        cameraButton.layer.shadowColor = UIColor.lightGray.cgColor
        cameraButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        cameraButton.layer.shadowOpacity = 0.2
        cameraButton.layer.shadowRadius = 0.8
    }
    

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        if cameraButton.isSelected {
            saveButton.titleLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        cameraAlertAction()
        
        
    }
    
    
}


//MARK: - Function

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func cameraAlertAction() {
        let cameraAlert = UIAlertController(title: "프로필 사진 변경", message: .none, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "사진 촬영", style: .default, handler: {(action) in self.cameraCapture()})
        let photoAction = UIAlertAction(title: "사진 불러오기", style: .default, handler: {(action) in self.photoLibraryLoad()})
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: {(action) in print("cancle")})
        
        cameraAlert.addAction(cameraAction)
        cameraAlert.addAction(photoAction)
        cameraAlert.addAction(cancleAction)
        
        present(cameraAlert, animated: true, completion: nil)
    }
    
    func cameraCapture() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("사진 촬영 실패")
        }
    
    }
    
    func photoLibraryLoad() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("사진 불러오기 실패")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
        userProfileImageView.image = captureImage
    }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


