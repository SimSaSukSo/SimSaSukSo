//
//  CustomCircularCollectionViewLayout.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/11.
//

import UIKit

class CustomCircularCollectionViewLayout: UICollectionViewLayout {
    
    var itemSize = CGSize(width: 200, height: 150)
    var attributesList = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        let itemNo = collectionView?.numberOfItems(inSection: 0) ?? 0
        let length = (collectionView!.frame.width - 40)/3
        itemSize = CGSize(width: length, height: length)
        
        attributesList = (0..<itemNo).map { (i) -> UICollectionViewLayoutAttributes in
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            
            attributes.size = self.itemSize
            
            var x = CGFloat(i%3)*(itemSize.width+10) + 10
            var y = CGFloat(i/3)*(itemSize.width+10) + 10
        
            //28, 46(-10), 64(-20), 82(-30), 100
            if (i == 0 || i == 10 || (i % 18 == 0) || (i == 28) || i == 46 || i == 64 || i == 82 || i == 100) {
                attributes.frame = CGRect(x: x, y: y, width: itemSize.width*2+10, height: itemSize.height*2+10)
            } else if i > 2 {
                y += (itemSize.width+10)
                attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
                
            } else {
                x = itemSize.width*2 + 30
                if i == 2 {
                    y += itemSize.height + 10
                }
                attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
            }

            return attributes
        }
    }
    
    override var collectionViewContentSize : CGSize {
        
        return CGSize(width: collectionView!.bounds.width, height: (itemSize.height + 10)*CGFloat(ceil(Double(collectionView!.numberOfItems(inSection: 0))/3))+(itemSize.height + 20))
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.row < attributesList.count
        {
            return attributesList[indexPath.row]
        }
        return nil
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
