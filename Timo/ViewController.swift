//
//  ViewController.swift
//  Timo
//
//  Created by 김삼복 on 2020/11/07.
//  Copyright © 2020 김보민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBAction func allBtn(_ sender: Any) {
		allbtn.setTitleColor(UIColor.black, for: .normal)
		culturebtn.setTitleColor(UIColor.lightGray, for: .normal)
		traditionbtn.setTitleColor(UIColor.lightGray, for: .normal)
		visualbtn.setTitleColor(UIColor.lightGray, for: .normal)
		showbtn.setTitleColor(UIColor.lightGray, for: .normal)
		
		projects.removeAll()
		convertCSVIntoArray()
		collectionView.reloadData()
	}
	
	@IBAction func cultureBtn(_ sender: Any) {
		allbtn.setTitleColor(UIColor.lightGray, for: .normal)
		culturebtn.setTitleColor(UIColor.black, for: .normal)
		traditionbtn.setTitleColor(UIColor.lightGray, for: .normal)
		visualbtn.setTitleColor(UIColor.lightGray, for: .normal)
		showbtn.setTitleColor(UIColor.lightGray, for: .normal)
		
		projects.removeAll()
		projects = cultures
		collectionView.reloadData()
	}
	@IBAction func traditionBtn(_ sender: Any) {
		allbtn.setTitleColor(UIColor.lightGray, for: .normal)
		culturebtn.setTitleColor(UIColor.lightGray, for: .normal)
		traditionbtn.setTitleColor(UIColor.black, for: .normal)
		visualbtn.setTitleColor(UIColor.lightGray, for: .normal)
		showbtn.setTitleColor(UIColor.lightGray, for: .normal)
		
		projects.removeAll()
		projects = traditions
		collectionView.reloadData()
	}
	@IBAction func visualBtn(_ sender: Any) {
		allbtn.setTitleColor(UIColor.lightGray, for: .normal)
		culturebtn.setTitleColor(UIColor.lightGray, for: .normal)
		traditionbtn.setTitleColor(UIColor.lightGray, for: .normal)
		visualbtn.setTitleColor(UIColor.black, for: .normal)
		showbtn.setTitleColor(UIColor.lightGray, for: .normal)
		
		projects.removeAll()
		projects = visuals
		collectionView.reloadData()
	}
	@IBAction func showBtn(_ sender: Any) {
		allbtn.setTitleColor(UIColor.lightGray, for: .normal)
		culturebtn.setTitleColor(UIColor.lightGray, for: .normal)
		traditionbtn.setTitleColor(UIColor.lightGray, for: .normal)
		visualbtn.setTitleColor(UIColor.lightGray, for: .normal)
		showbtn.setTitleColor(UIColor.black, for: .normal)
		
		projects.removeAll()
		projects = shows
		collectionView.reloadData()
	}
	@IBOutlet weak var collectionView: UICollectionView!
	
	@IBAction func settingBtn(_ sender: Any) {
		let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
		let settingVC = storyBoard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
		self.navigationController?.pushViewController(settingVC, animated: true)
	}
	
	@IBOutlet weak var allbtn: UIButton!
	@IBOutlet weak var traditionbtn: UIButton!
	@IBOutlet weak var showbtn: UIButton!
	@IBOutlet weak var culturebtn: UIButton!
	@IBOutlet weak var visualbtn: UIButton!
	
	
	var projects = [Project]()
	var visuals = [Project]()
	var cultures = [Project]()
	var traditions = [Project]()
	var shows = [Project]()
	var selectProject: Project? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.delegate = self
		collectionView.dataSource = self
		view.backgroundColor = UIColor(red: 246/255, green: 247/255, blue: 251/255, alpha: 100)
		collectionView.backgroundColor = UIColor(red: 246/255, green: 247/255, blue: 251/255, alpha: 100)
		
		convertCSVIntoArray()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = false
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	
	func convertCSVIntoArray() {
        guard let filepath = Bundle.main.path(forResource: "HT_CRFD", ofType: "csv") else {
            return
        }
        var data = ""
        do {
            data = try String(contentsOfFile: filepath)
        } catch {
            print(error)
            return
        }
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        for row in rows {
            let columns = row.components(separatedBy: "|")
            if columns.count == 10 {
                let yy = columns[0]
                let sttus_dc = columns[1]
				let ctgry_nm = columns[2]
				let prjct_nm = columns[3]
				let applcnt_nm = columns[4]
				let crfd_begin_de = columns[5]
				let crfd_clos_de = columns[6]
				let goal_am = columns[7]
				let mys_am = columns[8]
				let spnser_co = columns[9]

				if(ctgry_nm == "\"시각\""){
					let projects = Project(yy: yy, sttus_dc: sttus_dc, ctgry_nm: ctgry_nm, prjct_nm: prjct_nm, applcnt_nm: applcnt_nm, crfd_begin_de: crfd_begin_de, crfd_clos_de: crfd_clos_de, goal_am: goal_am, mys_am: mys_am, spnser_co: spnser_co)
					visuals.append(projects)
				}
				if(ctgry_nm == "\"공연\""){
					let projects = Project(yy: yy, sttus_dc: sttus_dc, ctgry_nm: ctgry_nm, prjct_nm: prjct_nm, applcnt_nm: applcnt_nm, crfd_begin_de: crfd_begin_de, crfd_clos_de: crfd_clos_de, goal_am: goal_am, mys_am: mys_am, spnser_co: spnser_co)
					shows.append(projects)
				}
				if(ctgry_nm == "\"전통\""){
					let projects = Project(yy: yy, sttus_dc: sttus_dc, ctgry_nm: ctgry_nm, prjct_nm: prjct_nm, applcnt_nm: applcnt_nm, crfd_begin_de: crfd_begin_de, crfd_clos_de: crfd_clos_de, goal_am: goal_am, mys_am: mys_am, spnser_co: spnser_co)
					traditions.append(projects)
				}
				if(ctgry_nm == "\"문화일반\""){
					let projects = Project(yy: yy, sttus_dc: sttus_dc, ctgry_nm: ctgry_nm, prjct_nm: prjct_nm, applcnt_nm: applcnt_nm, crfd_begin_de: crfd_begin_de, crfd_clos_de: crfd_clos_de, goal_am: goal_am, mys_am: mys_am, spnser_co: spnser_co)
					cultures.append(projects)
				}
				let project = Project(yy: yy, sttus_dc: sttus_dc, ctgry_nm: ctgry_nm, prjct_nm: prjct_nm, applcnt_nm: applcnt_nm, crfd_begin_de: crfd_begin_de, crfd_clos_de: crfd_clos_de, goal_am: goal_am, mys_am: mys_am, spnser_co: spnser_co)
                projects.append(project)
            }
        }
    }
	
	

}
class ProjectCollectionCell: UICollectionViewCell {
	
	@IBOutlet weak var ctgryLabel: UILabel!
	@IBOutlet weak var moreBtn: UIButton!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var donedateLabel: UILabel!
	
	
}

extension ViewController: UICollectionViewDelegate{
	
}

extension ViewController: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return projects.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCollectionCell", for: indexPath) as! ProjectCollectionCell
		var subStr1 = projects[indexPath.row].prjct_nm
		subStr1.removeLast()
		subStr1.removeFirst()
		cell.titleLabel.text = subStr1
		cell.titleLabel.font = UIFont(name: "GmarketSansLight", size: 17)
		
		var subStr2 = projects[indexPath.row].crfd_begin_de
		subStr2.removeLast()
		subStr2.removeFirst()
		cell.dateLabel.text = subStr2 + " - "
		
		var subStr3 = projects[indexPath.row].crfd_clos_de
		subStr3.removeLast()
		subStr3.removeFirst()
		cell.donedateLabel.text = subStr3
		
		cell.imgView.image = UIImage(named: "TIMO_썸네일")
		
		var a = projects[indexPath.row].ctgry_nm
		a.removeLast()
		a.removeFirst()
		cell.ctgryLabel.text = a
		
		cell.moreBtn.tag = indexPath.row
		
		cell.moreBtn.addTarget(self, action: Selector("moreFunc:"), for: .touchUpInside)
		
		cell.layer.masksToBounds = false
		cell.layer.backgroundColor = UIColor(red: 246/255, green: 247/255, blue: 251/255, alpha: 100).cgColor
        let cornerRadius: CGFloat = 15
        let shadowRadius: CGFloat = 4

        let darkShadow = CALayer()
        darkShadow.frame = cell.bounds
        darkShadow.backgroundColor = view.backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.0).cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        cell.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = cell.bounds
        lightShadow.backgroundColor = view.backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        cell.layer.insertSublayer(lightShadow, at: 0)
		
		
		return cell
	}
	
	@objc func moreFunc(_ sender: UIButton) {
		let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
		let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
		detailVC.originProject = projects[sender.tag].self
		self.navigationController?.pushViewController(detailVC, animated: true)
	}
	
	
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: collectionView.bounds.width/2.1, height: collectionView.bounds.height/2 - 10)
	}
	
}


