//
//  CoreDataService.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import CoreData
import UIKit

final class CoreDataService: CoreDataServiceProtocol {
    private let context = PersistenceController.shared.container.viewContext
    
    func saveResponse<T: Codable>(_ object: T, forKey key: String) {
        context.perform {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CachedResponse")
            fetchRequest.predicate = NSPredicate(format: "id == %@", key)
            
            let cachedEntity: NSManagedObject
            if let existingEntity = try? self.context.fetch(fetchRequest).first {
                cachedEntity = existingEntity
            } else {
                let entityDescription = NSEntityDescription.entity(forEntityName: "CachedResponse", in: self.context)!
                cachedEntity = NSManagedObject(entity: entityDescription, insertInto: self.context)
                cachedEntity.setValue(key, forKey: "id")
            }
            
            if let jsonData = try? JSONEncoder().encode(object),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                cachedEntity.setValue(jsonString, forKey: "json")
                cachedEntity.setValue(Date(), forKey: "timestamp")
            }
            
            do {
                try self.context.save()
            } catch {
                print("Error saving response: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchResponse<T: Codable>(forKey key: String, as type: T.Type) -> (object: T?, timestamp: Date?) {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CachedResponse")
        fetchRequest.predicate = NSPredicate(format: "id == %@", key)
        
        guard let cachedEntity = try? context.fetch(fetchRequest).first,
              let jsonString = cachedEntity.value(forKey: "json") as? String,
              let jsonData = jsonString.data(using: .utf8),
              let decodedObject = try? JSONDecoder().decode(type, from: jsonData) else {
            return (nil, nil)
        }
        
        let timestamp = cachedEntity.value(forKey: "timestamp") as? Date
        return (decodedObject, timestamp)
    }
    
    func cleanupExpiredCache(forKey key: String, expiration: TimeInterval = 300) {
        let backgroundContext = PersistenceController.shared.container.newBackgroundContext()
        backgroundContext.perform {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CachedResponse")
            fetchRequest.predicate = NSPredicate(format: "id == %@", key)  
            
            if let cachedItems = try? backgroundContext.fetch(fetchRequest) {
                for item in cachedItems {
                    if let timestamp = item.value(forKey: "timestamp") as? Date,
                       Date().timeIntervalSince(timestamp) > expiration {
                        backgroundContext.delete(item)
                    }
                }
                do {
                    try backgroundContext.save()
                } catch {
                    print("Error cleaning up expired cache: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteCache(forKey key: String) {
        context.perform {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CachedResponse")
            fetchRequest.predicate = NSPredicate(format: "id == %@", key)
            
            if let cachedEntity = try? self.context.fetch(fetchRequest).first {
                self.context.delete(cachedEntity)
                do {
                    try self.context.save()
                } catch {
                    print("Error deleting cache for key \(key): \(error.localizedDescription)")
                }
            }
        }
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        context.perform {
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CachedResponse")
            fetchRequest.predicate = NSPredicate(format: "id == %@", key)
            
            let cachedEntity: NSManagedObject
            if let existingEntity = try? self.context.fetch(fetchRequest).first {
                cachedEntity = existingEntity
            } else {
                let entityDescription = NSEntityDescription.entity(forEntityName: "CachedResponse", in: self.context)!
                cachedEntity = NSManagedObject(entity: entityDescription, insertInto: self.context)
                cachedEntity.setValue(key, forKey: "id")
            }
            
            if let imageData = image.pngData() {
                cachedEntity.setValue(imageData, forKey: "imageData")
                cachedEntity.setValue(Date(), forKey: "timestamp")
            }
            
            do {
                try self.context.save()
            } catch {
                print("Error saving image: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchImage(forKey key: String) -> UIImage? {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "CachedResponse")
        fetchRequest.predicate = NSPredicate(format: "id == %@", key)
        
        guard let cachedEntity = try? context.fetch(fetchRequest).first,
              let imageData = cachedEntity.value(forKey: "imageData") as? Data,
              let image = UIImage(data: imageData) else {
            return nil
        }
        
        return image
    }
    
    func clearAllData() {
        let persistentContainer = PersistenceController.shared.container
        let context = persistentContainer.viewContext
        
        context.perform {
            do {
                for entity in persistentContainer.managedObjectModel.entities {
                    guard let entityName = entity.name else { continue }
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    try context.execute(deleteRequest)
                }
                try context.save()
            } catch {
                print("Failed to clear Core Data: \(error.localizedDescription)")
            }
        }
    }
}
