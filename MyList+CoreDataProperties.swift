//
//  MyList+CoreDataProperties.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/05.
//
//

import Foundation
import CoreData


extension MyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var id: Int16

}

extension MyList : Identifiable {

}
