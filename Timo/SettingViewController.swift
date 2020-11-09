//
//  SettingViewController.swift
//  Timo
//
//  Created by 김삼복 on 2020/11/07.
//  Copyright © 2020 김보민. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController{
	
	@IBOutlet weak var moneyText: UITextField!
	@IBAction func charge(_ sender: Any) {
		CoreDataManager.shared
			.saveMoney(id: 1, money: timomoney) { onSuccess in
							   print("saved = \(onSuccess)")
			   }
		nowMoney.text = (moneyText.text ?? "0") + "원"
	}
	@IBOutlet weak var nowMoney: UILabel! {
		didSet{
			DispatchQueue.main.async {
				self.nowMoney.reloadInputViews()
			}
		}
	}
	var timomoney: Int64 = 0
	var txtmoney: String = "0"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		timomoney = Int64((moneyText.text as! NSString).integerValue)
		let users: [TimoMoney] = CoreDataManager.shared.getMoney()
		let userNames: [Int64] = users.map({$0.money})
		
		
	}
}
