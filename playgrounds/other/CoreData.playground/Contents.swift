import CoreData
import Foundation

@objc(Item)
class Item: NSManagedObject {
    
    @NSManaged var createdDate: Date?
}



class Storage<Object: NSManagedObject> {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    var objects: [Object] = []
    
    func fetch(with predicate: NSPredicate) {
        
        let request = NSFetchRequest<Object>(entityName: String(describing: Object.self))
        request.predicate = predicate
        guard context.hasChanges else { return }
        do {
            objects = try context.fetch(request)
        } catch {
            print(error)
            context.rollback()
        }
    }
    
    
    func fetch<Value>(key: KeyPath<Object, Value>, _ arg: String) {
        
        let request = NSFetchRequest<Object>(entityName: String(describing: Object.self))
        
        let predicate = NSPredicate(format: "%K %@", key.stringValue, arg)
        
        request.predicate = predicate
        guard context.hasChanges else { return }
        do {
            objects = try context.fetch(request)
        } catch {
            print(error)
            context.rollback()
        }
    }
}

let storage = Storage<Item>(context: .init(concurrencyType: .mainQueueConcurrencyType))
storage.fetch(key: \.createdDate, ">= 1")

extension KeyPath where Root: NSObject {
    var stringValue: String {
        NSExpression(forKeyPath: self).keyPath
    }
}
let keyPath = \Item.createdDate
let newPredicate = NSPredicate(format: "%K %@", keyPath.stringValue, "")

let oldPredicate = NSPredicate(format: "%K = %@", #keyPath(Item.createdDate), "1")
