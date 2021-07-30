//
//  HomeTabViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/24.
//

import UIKit
import CoreLocation
class HomeTabViewController: UIViewController{
    
    static var regionNumber : Int = 0
    
    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let locale = Locale(identifier: "Ko-kr")
    var findLocation = CLLocation()
    
    var hotPlace : [hotPlacesDetail] = []
    var regionPlace : [regionPlacesDetail] = []
    var trendPlace : [trendPlacesDetail] = []
    var likePlace : [likePlacesDetail] = []
    var believePlace : [believePlacesDetail] = []

    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var Top5HotelLabel: UILabel!
    @IBOutlet weak var BestSearchesCollectionView: UICollectionView!
    
    @IBOutlet weak var TrendPlacesCollectionView: UICollectionView!
    
    @IBOutlet weak var BestLikesCollectionView: UICollectionView!
    
    @IBOutlet weak var BestBelievesTableView: UITableView!
    @IBOutlet weak var slidePageControl: UIPageControl!
    
    
    var timer = Timer() // 타이머로 자동 슬라이드 셋팅

    var counter = 0  // 그림이 어디로 슬라이드할지 init

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingGps()
        
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
        
        
        
        DispatchQueue.main.async {

                      self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeIMG), userInfo: nil, repeats: true)

                  } //페이지가 실행되면 2초에 한번씩 changeIMG 펑션을 실행해라!!
        
        
    }
    
    func settingGps(){
        // 델리게이트 설정
        locationManager.delegate = self
                // 거리 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                // 사용자에게 허용 받기 alert 띄우기
        getLocationUsagePermission()
          
        
        
        
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
            cell.tag = likePlace[indexPath.row].feedIndex
            
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
    
    // Feed Index 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! FeedDetailViewController
            detailVC.feedIndex = (sender as! UICollectionViewCell).tag
        }
    }
    
    
}

extension HomeTabViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return believePlace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let believecell = tableView.dequeueReusableCell(withIdentifier: "BestBelievesTableViewCell") as! BestBelievesTableViewCell
       
        
        
        believecell.BestBelievesNameLabel.text = believePlace[indexPath.row].name
        
        
        let urlString = believePlace[indexPath.row].source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            believecell.BestBelievesImageView.image = UIImage(data: data)
        }
        
        believecell.cellDelegate = self
        
        // Pass the data to colletionview inside the tableviewcell
        let rowArray = believePlace[indexPath.row].tags.components(separatedBy: ",")
        believecell.updateCellWith(row: rowArray)
        
       return believecell
    }
}

extension HomeTabViewController: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: believeTagCell?, index: Int, didTappedInTableViewCell: BestBelievesTableViewCell) {
        if let colorsRow = didTappedInTableViewCell.rowWithCollectionview {
            print("You tapped the cell \(index) in the row of colors \(colorsRow)")
            // You can also do changes to the cell you tapped using the 'collectionviewcell'
        }
    }
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
        Top5HotelLabel.text = result.regionName + " Top5 숙소"
        TrendPlacesCollectionView.reloadData()
        BestLikesCollectionView.reloadData()
        BestBelievesTableView.reloadData()
        
        dismissIndicator()
    }
    
    func fail(){
        print("fail")
        
        
    }
    
    
}


//MARK:- GPS
extension HomeTabViewController : CLLocationManagerDelegate{
    
    func getLocationUsagePermission() {
            //location4
            self.locationManager.requestWhenInUseAuthorization()

        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            //location5
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                print("GPS 권한 설정됨")
                // 아이폰 설정에서의 위치 서비스가 켜진 상태라면
                if CLLocationManager.locationServicesEnabled() {
                    print("위치 서비스 On 상태")
                    self.locationManager.startUpdatingLocation() //위치 정보 받아오기 시작
                    print(locationManager.location?.coordinate)
                    
                    let coor = locationManager.location?.coordinate
                    let latititude = coor?.latitude
                    let logitude = coor?.longitude
                    
                    print("여긴가?")
                    print(latititude)
                    print(logitude)
                    
                    findLocation = CLLocation(latitude: latititude!, longitude: logitude!)
                        
                    geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in if let address: [CLPlacemark] = placemarks { if let name: String = address.first?.administrativeArea { print(name)
                                        self.convertToRegionNumber(region: name)
                                    } } })
                } else {
                    print("위치 서비스 Off 상태")
                }
                
            case .restricted, .notDetermined:
                print("GPS 권한 설정되지 않음")
                getLocationUsagePermission()
                HomeTabViewController.regionNumber = 2000
            case .denied:
                print("GPS 권한 요청 거부됨")
                getLocationUsagePermission()
                HomeTabViewController.regionNumber = 2000
            default:
                print("GPS: Default")
                HomeTabViewController.regionNumber = 2000
            }
        }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//            // the most recent location update is at the end of the array.
//            let location: CLLocation = locations[locations.count - 1]
//            let longtitude: CLLocationDegrees = location.coordinate.longitude
//            let latitude:CLLocationDegrees = location.coordinate.latitude
//
//        print("저긴가?")
//            print(location)
//            print(longtitude)
//        print(latitude)
//    }
//
//    // 위치 정보 계속 업데이트 -> 위도 경도 받아옴
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            print("didUpdateLocations")
//            if let location = locations.first {
//                print("위도: \(location.coordinate.latitude)")
//                print("경도: \(location.coordinate.longitude)")
//                geocoder.reverseGeocodeLocation(location, preferredLocale: locale, completionHandler: {(placemarks, error) in if let address: [CLPlacemark] = placemarks { if let name: String = address.first?.administrativeArea { print(name)
//                    self.convertToRegionNumber(region: name)
//                } } })
//
//
//            }
//        }
        
        // 위도 경도 받아오기 에러
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
    
    func convertToRegionNumber(region : String){
        switch region{
        case "서울특별시" :
            print("잘되냐")
            HomeTabViewController.regionNumber = 1000
           
            break
        case "부산광역시":
            HomeTabViewController.regionNumber = 1001
            
            break
        case "제주도" :
            HomeTabViewController.regionNumber = 1002
            
            break
        case "강원도" :
            HomeTabViewController.regionNumber = 1003
            
            break
        case "경기도" :
            HomeTabViewController.regionNumber = 1004
            
            break
        case "인천광역시":
            HomeTabViewController.regionNumber = 1005
           
            break
        case "대구광역시" :
            HomeTabViewController.regionNumber = 1006
           
            break
        case "울산광역시" :
            HomeTabViewController.regionNumber = 1007
            
            break
        case "경상남도" :
            HomeTabViewController.regionNumber = 1008
           
            break
        case "경상북도":
            HomeTabViewController.regionNumber = 1009
         
            break
        case "광주광역시" :
            HomeTabViewController.regionNumber = 1010
            
            break
        case "전라남도" :
            HomeTabViewController.regionNumber = 1011
          
            break
        case "전라북도" :
            HomeTabViewController.regionNumber = 1012
           
            break
        case "대전광역시":
            HomeTabViewController.regionNumber = 1013
           
            break
        case "충청남도" :
            HomeTabViewController.regionNumber = 1014
           
            break
        case "충청북도" :
            HomeTabViewController.regionNumber = 1015
           
            break
        default :
           
            HomeTabViewController.regionNumber = 2000
         
            break
            
        }
        showIndicator()
        HomeDataManager().home(region: HomeTabViewController.regionNumber,viewcontroller: self)
        
        
        
    }

}
