//
//  ListItem+CoreDataProperties.swift
//  QuickList
//
//  Created by Greg Alton on 11/8/18.
//  Copyright © 2018 Greg Alton. All rights reserved.
//
//

import Foundation
import CoreData


extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var text: String?

}
