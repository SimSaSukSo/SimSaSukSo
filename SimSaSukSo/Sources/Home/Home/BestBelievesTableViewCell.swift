//
//  BestBelievesTableViewCell.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/30.
//

import UIKit

protocol CollectionViewCellDelegate: class {
//    func collectionView(collectionviewcell: ReviewPictureCollectionViewCell?, index: Int, didTappedInTableViewCell: ReviewTableViewCell)

}

class BestBelievesTableViewCell : UITableViewCell{

    weak var cellDelegate: CollectionViewCellDelegate?

    @IBOutlet weak var BestBelievesImageView: UIImageView!

    @IBOutlet weak var BestBelievesNameLabel: UILabel!

    @IBOutlet weak var tagCollectionView: UICollectionView!

    override func awakeFromNib() {
        //profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        super.awakeFromNib()
        // Initialization code}
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        let flowLayout = UICollectionViewFlowLayout()
//                flowLayout.scrollDirection = .horizontal
//                flowLayout.itemSize = CGSize(width: 300, height: 180)
//                flowLayout.minimumLineSpacing = 2.0
//                flowLayout.minimumInteritemSpacing = 5.0
//                self.tagCollectionView.collectionViewLayout = flowLayout
//                self.tagCollectionView.showsHorizontalScrollIndicator = false
//
//            // Comment if you set Datasource and delegate in .xib
//                self.tagCollectionView.dataSource = self
//                self.tagCollectionView.delegate = self
//
//    }
//
//}

//extension BestBelievesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    // The data we passed from the TableView send them to the CollectionView Model
////    func updateCellWith(row: [ReviewCollectionViewCellModel]) {
////        self.rowWithCollectionview = row
////        self.tagCollectionView.reloadData()
////    }
//
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return self.rowWithCollectionview?.count ?? 0
////    }
//
//
//    // Set the data for each cell (color and color name)
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "believeTagCell", for: indexPath) as? believeTagCell {
////            cell.reviewPictureImageView.image = UIImage(named: self.rowWithCollectionview?[indexPath.item].images ?? "")
////
////
////            return cell
////        }
////        return UICollectionViewCell()
////    }
//
//    // Add spaces at the beginning and the end of the collection view
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var height : CGFloat = 0
//        var width : CGFloat = 0
//        var size : CGSize = CGSize(width: 0,height: 0)
//
//            width = collectionView.frame.width
//            height = collectionView.frame.height
//            size = CGSize(width: width, height: height)
//
//        return size
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let cell = collectionView.cellForItem(at: indexPath) as? believeTagCell
////            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
//
//
//        }
//}
//
//
//
//
}
