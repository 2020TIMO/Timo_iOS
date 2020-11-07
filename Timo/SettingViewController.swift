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
//		CoreDataManager.shared.saveMoney(money: timomoney)
	}
	@IBOutlet weak var nowMoney: UILabel!
	var timomoney: Int64 = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		timomoney = Int64((moneyText.text as! NSString).integerValue)
		nowMoney.text = CoreDataManager.shared.fetchedMoney.first?.value(forKey: "money") as? String
		
		
	}
}
