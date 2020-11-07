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
		
		func getMoney(ascending: Bool = false) -> [TimoMoney] {
			var models: [TimoMoney] = [TimoMoney]()
			
			if let context = context {
				let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
				let fetchRequest: NSFetchRequest<NSManagedObject>
					= NSFetchRequest<NSManagedObject>(entityName: modelName)
				fetchRequest.sortDescriptors = [idSort]
				
				do {
					if let fetchResult: [TimoMoney] = try context.fetch(fetchRequest) as? [TimoMoney] {
						models = fetchResult
					}
				} catch let error as NSError {
					print("Could not fetch🥺: \(error), \(error.userInfo)")
				}
			}
			return models
		}
		
	func saveMoney(id: Int16, money: Int64, onSuccess: @escaping ((Bool) -> Void)) {
			if let context = context,
				let entity: NSEntityDescription
				= NSEntityDescription.entity(forEntityName: modelName, in: context) {
				
				if let timo: TimoMoney = NSManagedObject(entity: entity, insertInto: context) as? TimoMoney {
					timo.id = id
					timo.money = money
					
					contextSave { success in
						onSuccess(success)
					}
				}
			}
		}
		
	}

	extension CoreDataManager {
		fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
			let fetchRequest: NSFetchRequest<NSFetchRequestResult>
				= NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
			fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
			return fetchRequest
		}
		
		fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
			do {
				try context?.save()
				onSuccess(true)
			} catch let error as NSError {
				print("Could not save🥶: \(error), \(error.userInfo)")
				onSuccess(false)
			}
		}
}
