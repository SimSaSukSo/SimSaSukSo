//
//  FavoriteDetailViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/12.
//

import UIKit

class FavoriteDetailViewController: UIViewController {

    @IBOutlet var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func filterButtonAction(_ sender: UIButton) {
    }
    
}

//MARK: - CollectionView
extension FavoriteDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteDetailCollectionViewCell", for: indexPath)
        
        return cell
    }
    
    
}

extension FavoriteDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width/3-3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
