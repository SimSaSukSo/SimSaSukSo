//
//  HomeTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit

class HomeTabViewController: UIViewController {
    
    var hotPlace : [hotPlacesDetail] = []
    var regionPlace : [regionPlacesDetail] = []
    var trendPlace : [trendPlacesDetail] = []
    var likePlace : [likePlacesDetail] = []
    var believePlace : [believePlacesDetail] = []

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var BestSearchesCollectionView: UICollectionView!
    
    @IBOutlet weak var TrendPlacesCollectionView: UICollectionView!
    
    @IBOutlet weak var BestLikesCollectionView: UICollectionView!
    
    @IBOutlet weak var BestBelievesTableView: UITableView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    
    
    var timer = Timer() // 타이머로 자동 슬라이드 셋팅

    var counter = 0  // 그림이 어디로 슬라이드할지 init

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
         
        slidePageControl.numberOfPages = 5
        slidePageControl.currentPage = 0
        
        BestSearchesCollectionView.dataSource = self
        BestSearchesCollectionView.delegate = self
        
        TrendPlacesCollectionView.dataSource = self
        TrendPlacesCollectionView.delegate = self
        
        BestLikesCollectionView.dataSource = self
        BestLikesCollectionView.delegate = self
        
        BestBelievesTableView.dataSource = self
        BestBelievesTableView.delegate = self
        
        sliderCollectionView.reloadData()
        BestSearchesCollectionView.reloadData()
        TrendPlacesCollectionView.reloadData()
        BestLikesCollectionView.reloadData()
        BestBelievesTableView.reloadData()
        
        HomeDataManager().home(region: 1000,viewcontroller: self)
        DispatchQueue.main.async {

                      self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeIMG), userInfo: nil, repeats: true)

                  } //페이지가 실행되면 2초에 한번씩 changeIMG 펑션을 실행해라!!
        
        
    }
    
    @objc func changeIMG(){

        if counter < hotPlace.count{ //인덱스가 끝번호가 아니라면 -  마지막 이미지가 아니라면,

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
            count = hotPlace.count
        }
        else if collectionView == BestSearchesCollectionView{
            count = regionPlace.count
        
        }else if collectionView == TrendPlacesCollectionView{
            count = trendPlace.count
            
        }else if collectionView == BestLikesCollectionView{
            count = likePlace.count
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
    //MARK:- holplace
        if collectionView == sliderCollectionView{
        let slidercell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell

          
            slidercell.sliderLabelTitle.text = hotPlace[indexPath.row].name
            let urlString = hotPlace[indexPath.row].source
            if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                slidercell.sliderImageView.image = UIImage(data: data)
            }
            slidercell.sliderPageLabel.text = "\(indexPath.row + 1)"
            cell = slidercell
            
    //MARK:- region Places
        }else if collectionView == BestSearchesCollectionView{
            let searchscell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestSearchesCollectionViewCell", for: indexPath) as! BestSearchesCollectionViewCell
            searchscell.BestSearchesRankLabel.text = "\(indexPath.row+1)"
            if indexPath.row == 0 {
                searchscell.BestSearchesRankImageView.image = UIImage(named: "best5_green")
            }else{
                searchscell.BestSearchesRankImageView.image = UIImage(named: "best5_gray" )
            }
            let urlString = regionPlace[indexPath.row].source
            if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                searchscell.BestSearchesImageView.image = UIImage(data: data)
            }
            searchscell.BestSearchesNameLabel.text = regionPlace[indexPath.row].name
          
            cell = searchscell
            
    //MARK:- trendPlaces
        }else if collectionView == TrendPlacesCollectionView{
            let trendcell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendPlacesCollectionViewCell", for: indexPath) as! TrendPlacesCollectionViewCell
            
            trendcell.trendPlaceName.text = trendPlace[indexPath.row].name
            
            let urlString = trendPlace[indexPath.row].source
            if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                trendcell.trendImageView.image = UIImage(data: data)
            }
            cell = trendcell
            
    //MARK:- likePlaces
        }else if collectionView == BestLikesCollectionView{
            let likescell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestLikesCollectionViewCell", for: indexPath) as! BestLikesCollectionViewCell
            likescell.BestLikesRankLabel.text = "\(indexPath.row+1)"
            if indexPath.row == 0 {
                likescell.BestLikesRankImageView.image = UIImage(named: "best5_green")
            }else{
                likescell.BestLikesRankImageView.image = UIImage(named: "best5_gray" )
            }
            
            likescell.BestLikesLabel.text = likePlace[indexPath.row].name
            
            let urlString = likePlace[indexPath.row].source
            if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                likescell.BestLikesImageView.image = UIImage(data: data)
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
        }else if collectionView == TrendPlacesCollectionView{
            edgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        else if collectionView == BestLikesCollectionView{
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
        }else if collectionView == TrendPlacesCollectionView{
            size = CGSize(width: 150, height: 226)
        }
        else if collectionView == BestLikesCollectionView{
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
            
        }else if collectionView == TrendPlacesCollectionView{
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

extension HomeTabViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return believePlace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let believecell = tableView.dequeueReusableCell(withIdentifier: "BestBelievesTableViewCell") as! BestBelievesTableViewCell
       
        //셀 테두리
        believecell.layer.borderWidth = 1
        believecell.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        believecell.layer.cornerRadius = 4
        
        believecell.BestBelievesNameLabel.text = believePlace[indexPath.row].name
      //  believecell.cellDelegate = self
        
        let urlString = believePlace[indexPath.row].source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            believecell.BestBelievesImageView.image = UIImage(data: data)
        }
        
        
       return believecell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let feednavi = self.storyboard?.instantiateViewController(withIdentifier: "FeedNavigationController"){
//            feednavi.modalPresentationStyle = .fullScreen
//                self.present(feednavi, animated: true)
//        }
//    }
    
    
}

// MARK:- API
extension HomeTabViewController{
    func success(result : HomeResults){
        
        print("success")
        hotPlace = result.hotPlaces
        regionPlace = result.regionPlaces
        trendPlace = result.trendPlaces
        likePlace = result.likePlaces
        believePlace = result.believePlaces
        
        sliderCollectionView.reloadData()
        BestSearchesCollectionView.reloadData()
        TrendPlacesCollectionView.reloadData()
        BestLikesCollectionView.reloadData()
        BestBelievesTableView.reloadData()
    }
    
    func fail(){
        print("fail")
        
        
    }
    
    
}
