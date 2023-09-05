//
//  MyList+CoreDataClass.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/04.
//
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    static func new(itemData: ItemData) -> MyList {
        let entity: MyList = CoreDataRepository.entity()
        entity.id = itemData.id
        entity.title = itemData.title
        entity.detail = itemData.description
        return entity
    }
    
    func update(newName: String) {
        self.title = newName
    }
}
