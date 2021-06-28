//
//  HomeTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit

class HomeTabViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
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
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let slidercell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell

        slidercell.sliderImageView.image = imgArr[indexPath.row]
        slidercell.sliderPageLabel.text = "\(indexPath.row + 1)"
        
        return slidercell}
}

extension HomeTabViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
