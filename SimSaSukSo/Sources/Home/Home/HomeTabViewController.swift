//
//  HomeTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit

class HomeTabViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var BestSearchesCollectionView: UICollectionView!
    
    @IBOutlet weak var BestLikesCollectionView: UICollectionView!
    
    @IBOutlet weak var slidePageControl: UIPageControl!
    
    
    var timer = Timer() // 타이머로 자동 슬라이드 셋팅

    var counter = 0  // 그림이 어디로 슬라이드할지 init

    
        var imgArr = [ UIImage(named: "img_slide1"),
                       UIImage(named: "img_slide2"),
                       UIImage(named: "img_slide3"),
                       UIImage(named: "img_slide4"),
                       UIImage(named: "img_slide5")
                       
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
         
        slidePageControl.numberOfPages = 5
        slidePageControl.currentPage = 0
        
        BestSearchesCollectionView.dataSource = self
        BestSearchesCollectionView.delegate = self
        
        
        BestLikesCollectionView.dataSource = self
        BestLikesCollectionView.delegate = self
        
        DispatchQueue.main.async {

                      self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeIMG), userInfo: nil, repeats: true)

                  } //페이지가 실행되면 2초에 한번씩 changeIMG 펑션을 실행해라!!
    }
    
    @objc func changeIMG(){

        if counter < imgArr.count{ //인덱스가 끝번호가 아니라면 -  마지막 이미지가 아니라면,

            let index = IndexPath.init(item: counter, section: 0) //인덱스 패스 생성.

            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true) // 해당 인덱스로 이동.
            slidePageControl.currentPage = counter // 페이지네비게이터를 해당 인덱스로 이동.

           counter += 1 // 인덱스 증가

        } else {//마지막 이미지라면

           counter = 0 // 처음으로 돌아가

            let index = IndexPath.init(item: counter, section: 0) // 이동할 곳.

            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true) // 해당인덱스로 이동.

            slidePageControl.currentPage = counter // 페이지네비게이터를 해당 인덱스로 이동.

        }

    }
    
}

extension HomeTabViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count : Int!
        if collectionView == sliderCollectionView{
            count = imgArr.count
        }
        else if collectionView == BestSearchesCollectionView{
            count = 5
        }else if collectionView == BestLikesCollectionView{
            count = 5
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        if collectionView == sliderCollectionView{
        let slidercell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell

        slidercell.sliderImageView.image = imgArr[indexPath.row]
        slidercell.sliderPageLabel.text = "\(indexPath.row + 1)"
            cell = slidercell
            
        }else if collectionView == BestSearchesCollectionView{
            let searchscell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestSearchesCollectionViewCell", for: indexPath) as! BestSearchesCollectionViewCell
            searchscell.BestSearchesRankLabel.text = "\(indexPath.row+1)"
            if indexPath.row == 0 {
                searchscell.BestSearchesRankImageView.image = UIImage(named: "best5_green")
            }else{
                searchscell.BestSearchesRankImageView.image = UIImage(named: "best5_gray" )
            }
            cell = searchscell
            
        }else if collectionView == BestLikesCollectionView{
            let likescell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestLikesCollectionViewCell", for: indexPath) as! BestLikesCollectionViewCell
            likescell.BestLikesRankLabel.text = "\(indexPath.row+1)"
            if indexPath.row == 0 {
                likescell.BestLikesRankImageView.image = UIImage(named: "best5_green")
            }else{
                likescell.BestLikesRankImageView.image = UIImage(named: "best5_gray" )
            }
            cell = likescell
        }
        
        return cell
    }
}

extension HomeTabViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInsets : UIEdgeInsets!
        if collectionView == sliderCollectionView{
         edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else if collectionView == BestSearchesCollectionView{
            edgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else if collectionView == BestLikesCollectionView{
            edgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size : CGSize!
        if collectionView == sliderCollectionView{
        size = sliderCollectionView.frame.size
        }else if collectionView == BestSearchesCollectionView{
            size = CGSize(width: 150, height: 177)
        }else if collectionView == BestLikesCollectionView{
            size = CGSize(width: 150, height: 177)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var space : CGFloat!
        if collectionView == sliderCollectionView{
            space = 0.0
        }else if collectionView == BestSearchesCollectionView{
            space = 4.0
        }else if collectionView == BestLikesCollectionView{
            space = 4.0
        }
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
