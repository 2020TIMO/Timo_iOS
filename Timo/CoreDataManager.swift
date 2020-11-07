//
//  CoreDataManager.swift
//  Timo
//
//  Created by 김삼복 on 2020/11/07.
//  Copyright © 2020 김보민. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "TimoMoney"
	var fetchedMoney = [NSManagedObject]()
    
	func saveMoney(money: Int64) {
       guard let appDelegate =
		  UIApplication.shared.delegate as? AppDelegate else {
		  return
		}
		let managedContext = appDelegate.persistentContainer.viewContext

		let entity = NSEntityDescription.entity(forEntityName: "TimoMoney", in: managedContext)!

		let money = NSManagedObject(entity: entity, insertInto: managedContext)
		money.setValue(money, forKeyPath: "money")
		do {
		  try managedContext.save()
		  fetchedMoney.append(money)
		} catch let error as NSError {
		  print("Could not save. \(error), \(error.userInfo)")
		}
    }
	
	func fetchMoney() {
		guard let appDelegate =
		  UIApplication.shared.delegate as? AppDelegate else {
			return
		}
		let managedContext =
		  appDelegate.persistentContainer.viewContext

		let fetchRequest =
		  NSFetchRequest<NSManagedObject>(entityName: "TimoMoney")

		do {
		  fetchedMoney = try managedContext.fetch(fetchRequest)
		} catch let error as NSError {
		  print("Could not fetch. \(error), \(error.userInfo)")
		}
		
	}
	

}
