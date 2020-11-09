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
	var price = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(SupportCell.self, forCellReuseIdentifier: "SupportCell")
		
		imgView.image = UIImage(named: "TIMO_썸네일")
		
		
		var subStr1 = originProject?.prjct_nm
		subStr1?.removeFirst()
		subStr1?.removeLast()
		projectnameLabel.text = subStr1
		
		var subStr2 = originProject?.applcnt_nm
		subStr2?.removeFirst()
		subStr2?.removeLast()
		artistNameLabel.text = subStr2
		
		var subStr3 = originProject!.goal_am
		subStr3.removeFirst()
		subStr3.removeLast()
		goalLabel.text = subStr3 + "원"
		
		var subStr4 = originProject!.mys_am
		subStr4.removeFirst()
		subStr4.removeLast()
		currentLabel.text  = subStr4 + "원"
		
		var subStr5 = originProject!.spnser_co
		subStr5.removeFirst()
		subStr5.removeLast()
		supporterLabel.text = subStr5 + "명이 후원했습니다."
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = false
		navigationController?.interactivePopGestureRecognizer?.delegate = nil
	}
	
	func showAlert() {
		let showAlert = UIAlertController(title: "후원 되었습니다.", message: "\(price)이 후원되었습니다.", preferredStyle: .alert)
		showAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
		self.present(showAlert, animated: true, completion: nil)
	}
	
}

class SupportCell : UITableViewCell{
	
}

extension DetailViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
		tableView.deselectRow(at: indexPath, animated: true)
		tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		price = money[indexPath.row]
	}
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.accessoryType = .none
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
