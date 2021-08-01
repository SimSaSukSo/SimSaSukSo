//
//  ProfileViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/20.
//

import UIKit
import MobileCoreServices
import FirebaseStorage
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    lazy var dataManager = SettingDataManager()
    
    let storage = Storage.storage()
    
    let imagePicker = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var userNicknameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height/2
        
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height/2
        cameraButton.layer.shadowColor = UIColor.lightGray.cgColor
        cameraButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        cameraButton.layer.shadowOpacity = 0.2
        cameraButton.layer.shadowRadius = 0.8
        
        downloadImage(imageView: userProfileImageView)
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        uploadImage(image: userProfileImageView.image!)
        let input = ProfileImageRequest(profileUrl: "https://firebasestorage.googleapis.com/v0/b/simsasukso.appspot.com/o/프로필%20사진?alt=media&token=10360d60-d51d-45fc-b2ee-609b6c417bbe")
        dataManager.profileImage(input, delegate: self)
    
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        cameraAlertAction()
        
        
    }
    
    
}


//MARK: - Function

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func cameraAlertAction() {
        let cameraAlert = UIAlertController(title: "프로필 사진 변경", message: .none, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "사진 촬영", style: .default, handler: {(action) in self.openCamera()})
        let photoAction = UIAlertAction(title: "사진 불러오기", style: .default, handler: {(action) in self.openLibrary()})
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: {(action) in print("cancle")})
        
        cameraAlert.addAction(cameraAction)
        cameraAlert.addAction(photoAction)
        cameraAlert.addAction(cancleAction)
        
        present(cameraAlert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            
            imagePicker.sourceType = .camera
            //imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            self.presentAlert(title: "카메라 안됨")
        }
    
    }
    
    func openLibrary() {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
           
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            self.presentAlert(title: "앨범 안됨")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        self.userProfileImageView.image = newImage
        saveButton.setTitleColor(#colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1), for: .normal)
        picker.dismiss(animated: true, completion: nil)
 
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - Firebase
extension ProfileViewController {
    // Firebase 업로드
    func uploadImage(image: UIImage) {
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = "프로필 사진"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData) {
            (metaData, error) in if let error = error {
                print("실패")
                return
            } else {
                print("성공")
            }
        }

    }
    
    // Firebase 다운로드
    func downloadImage(imageView: UIImageView) {
        storage.reference(forURL: "gs://simsasukso.appspot.com/프로필 사진").downloadURL { (url, error) in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imageView.image = image
        }
    }
}
//MARK: - API
extension ProfileViewController {
    func profileImage(_ reuslt: ProfileImageResponse) {
        self.presentAlert(title: "프로필 사진 변경 완료")
        dismiss(animated: true, completion: nil)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
