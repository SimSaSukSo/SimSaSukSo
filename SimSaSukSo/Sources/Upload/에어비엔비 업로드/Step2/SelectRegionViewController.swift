//
//  SelectRegionViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/14.
//

import UIKit
class SelectRegionViewController : UIViewController{
    
    @IBOutlet weak var regionTableView: UITableView!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    var regionList : Array<String> = []
    var tagList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    var seoulList = ["강남 / 역삼 / 삼성","서초 / 교대 / 방배","사당","신사 / 압구정 / 청담","잠실 / 송파 / 잠실새내 / 천호 / 강동","서울역 / 이태원 / 용산","명동 / 중구","을지로 / 충무로","종로 / 동대문 / 대학로","인사동","서대문 / 마포 / 신촌 / 홍대","영등포","여의도","신림 / 서울대","구로 / 금천","김포공항","강서 / 화곡","건대 / 성수","왕십리","군자 / 상봉 / 중랑구","장안 / 청량리","강북 / 수유 / 도봉 / 미아 / 성북 / 노원"]
    var busanList = ["부산","부산"]
    var jejuList = ["제주제주","제주"]
    var gangwonList = ["강원","강원강원"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        regionTableView.dataSource = self
        regionTableView.delegate = self
        self.regionTableView.rowHeight = viewHeight.constant/17;
        regionList = seoulList
        
        //네비게이션 바 라인 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func regionButtonClicked(_ sender: UIButton) {
        switch sender.tag{
        case 1 :
            regionList = seoulList
            setFontnBackground(sender: sender)
            break
        case 2 :
            regionList = busanList
            setFontnBackground(sender: sender)
            break
         
        case 3 :
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 4 :
            regionList = gangwonList
            setFontnBackground(sender: sender)
            break
        case 5 :
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 6 :
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 7 :
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 8 :
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 9 :
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 10:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 11:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 12:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 13:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 14:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 15:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 16:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        case 17:
            regionList = jejuList
            setFontnBackground(sender: sender)
            break
        default:
            print("")
        }
        
    }
    
    func setFontnBackground(sender : UIButton){
        //눌러진 버튼 세팅
        let sender = sender
        self.regionTableView.reloadData()
        sender.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        sender.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        sender.backgroundColor = .white
        
        //눌러진 버튼 이외 버튼 세팅
        tagList.remove(at: sender.tag - 1)
        for i in tagList{
            let tmpButton = self.view.viewWithTag(i) as? UIButton
            tmpButton?.titleLabel?.font = UIFont(name: "Noto Sans CJK KR", size: 14)
            tmpButton!.setTitleColor(#colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1), for: .normal)
            tmpButton?.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            
        }
        tagList.append(sender.tag)
        tagList.sort()
        print(tagList)
        
        
    }
    
    
//    @objc func cellClicked(_ sender: UIButton) {
//
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected {
//            sender.setTitleColor(.simsasuksoGreen, for: .selected)
//
//
//        } else {
//            sender.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
//
//
//        }
//        }
    
}

extension SelectRegionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        regionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell") as! RegionTableViewCell
        
        cell.regionButton.setTitle(regionList[indexPath.row], for: .normal)
//        cell.regionButton.addTarget(self, action: #selector(self.cellClicked), for: .touchUpInside)
        return cell
    }
    
    
}
