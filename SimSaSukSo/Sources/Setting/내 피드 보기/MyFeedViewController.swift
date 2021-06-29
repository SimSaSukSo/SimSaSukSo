//
//  MyFeedViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/25.
//

import UIKit

class MyFeedViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
       @IBOutlet var userNicknameLabel: UILabel!
       @IBOutlet var myFeedCollectionView: UICollectionView!
       

       override func viewDidLoad() {
           super.viewDidLoad()
           
           profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
           
           myFeedCollectionView.delegate = self
           myFeedCollectionView.dataSource = self
       }
       
       @IBAction func backButtonAction(_ sender: UIButton) {
           dismiss(animated: true, completion: nil)
       }
       
       

   }

   //MARK: - CollectionView
   extension MyFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 30
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFeedCollectionViewCell", for: indexPath) as! MyFeedCollectionViewCell
           
           return cell
       }
       
       
   }

//MARK: - CollectionView FlowLayout
extension MyFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width/3-3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "MyFeedDetailViewController")
        
        self.navigationController?.pushViewController(VC!, animated: true)
    }
}
