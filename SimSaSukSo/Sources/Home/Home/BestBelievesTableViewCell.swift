//
//  BestBelievesTableViewCell.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/30.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: believeTagCell?, index: Int, didTappedInTableViewCell: BestBelievesTableViewCell)

}

class BestBelievesTableViewCell : UITableViewCell{

    var rowWithCollectionview: [String]?
    
    weak var cellDelegate: CollectionViewCellDelegate?

    @IBOutlet weak var BestBelievesImageView: UIImageView!

    @IBOutlet weak var BestBelievesNameLabel: UILabel!

    @IBOutlet weak var tagCollectionView: UICollectionView!

    override func awakeFromNib() {
        
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let flowLayout = UICollectionViewFlowLayout()
                flowLayout.scrollDirection = .horizontal
                flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
                flowLayout.minimumInteritemSpacing = 8.0
                self.tagCollectionView.collectionViewLayout = flowLayout
                self.tagCollectionView.showsHorizontalScrollIndicator = false

            
                self.tagCollectionView.dataSource = self
                self.tagCollectionView.delegate = self

    }

}

extension BestBelievesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: [String]) {
        self.rowWithCollectionview = row
        self.tagCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowWithCollectionview?.count ?? 0
    }


    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "believeTagCell", for: indexPath) as? believeTagCell {
            
            //셀 테두리
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
            cell.layer.cornerRadius = 4
            
            cell.believeTagLabel.text = self.rowWithCollectionview?[indexPath.item]
            

            return cell
        }
        return UICollectionViewCell()
    }

 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as? believeTagCell
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let label = UILabel(frame: CGRect.zero)
        label.text = self.rowWithCollectionview?[indexPath.item]
        label.sizeToFit()
        
        
        return CGSize(width: label.frame.width + 1, height: 30)
        
    }
}





