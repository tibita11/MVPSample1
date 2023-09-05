//
//  CoreDataRepository.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/04.
//

import CoreData

final class CoreDataRepository {
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private static var context: NSManagedObjectContext {
            return CoreDataRepository.persistentContainer.viewContext
        }
}

// MARK: for Create
extension CoreDataRepository {
    static func entity<T: NSManagedObject>() -> T {
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: context)!
        return T(entity: entityDescription, insertInto: nil)
    }
}

// MARK: CRUD
extension CoreDataRepository {
    static func array<T: NSManagedObject>() -> [T] {
        do {
            let request = NSFetchRequest<T>(entityName: String(describing: T.self))
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }

    static func add(_ object: NSManagedObject) {
        context.insert(object)
    }

    static func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    static func fetchObject<T: NSManagedObject>(id: Int16) -> T? {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        let predicate = NSPredicate(format:"id = %d",id)
        request.predicate = predicate
        
        do {
            return try context.fetch(request).first
        } catch {
            fatalError("Error: CoreData取得処理に失敗しました。")
        }
    }
}

// MARK: context CRUD
extension CoreDataRepository {
    static func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error: \(error), \(error.userInfo)")
        }
    }

    static func rollback() {
        guard context.hasChanges else { return }
        context.rollback()
    }
}
