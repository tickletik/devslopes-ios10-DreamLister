//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by ronny abraham on 10/25/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
