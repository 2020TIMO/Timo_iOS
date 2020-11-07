//
//  DetailViewController.swift
//  Timo
//
//  Created by 김삼복 on 2020/11/07.
//  Copyright © 2020 김보민. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController{
	@IBOutlet weak var projectnameLabel: UILabel!
	@IBOutlet weak var artistNameLabel: UILabel!
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var goalLabel: UILabel!
	@IBOutlet weak var currentLabel: UILabel!
	@IBOutlet weak var supporterLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBAction func supportBtn(_ sender: Any) {
		showAlert()
	}
	
	@IBAction func backBtn(_ sender: Any) {
	self.navigationController?.popViewController(animated: true)
	}
	let money = ["1000원","2000원","3000원","4000원","5000원","10000원","20000원"]
	var originProject: Project? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(SupportCell.self, forCellReuseIdentifier: "SupportCell")
		
		imgView.image = UIImage(named: "TIMO_썸네일")
		
		projectnameLabel.text = originProject?.prjct_nm
		artistNameLabel.text = originProject?.applcnt_nm
		if originProject?.goal_am == nil{
			goalLabel.text = "0원"
		} else {
			goalLabel.text = originProject!.goal_am + "원"
		}
		
		currentLabel.text = originProject!.mys_am + "원"
		supporterLabel.text = originProject!.spnser_co + "명이 후원했습니다."
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = false
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	
	func showAlert() {
		let showAlert = UIAlertController(title: "후원 되었습니다.", message: nil, preferredStyle: .alert)
		showAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
		self.present(showAlert, animated: true, completion: nil)
	}
	
}

class SupportCell : UITableViewCell{
	
}

extension DetailViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
		
	}
}

extension DetailViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return money.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
		cell.textLabel?.text = money[indexPath.row]
		return cell
	}
	
	
}
