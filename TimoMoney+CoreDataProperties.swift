//
//  TimoMoney+CoreDataProperties.swift
//  Timo
//
//  Created by 김삼복 on 2020/11/07.
//  Copyright © 2020 김보민. All rights reserved.
//
//

import Foundation
import CoreData


extension TimoMoney {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimoMoney> {
        return NSFetchRequest<TimoMoney>(entityName: "TimoMoney")
    }

    @NSManaged public var money: Int64
	@NSManaged public var id: Int16
}
