//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedInstance = DataStore()
    
    var messages:[Message] = []    //to get messages from core data
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func fetchData() {
        let context = persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Message> = Message.fetchRequest()
        //let fetchRequest:NSFetchRequest<NSManagedObject> = Message.fetchRequest()
        do {
            self.messages = try context.fetch(fetchRequest)
            
            print(messages)
        } catch { }
    }
    
    
    func generateTestData() {
        
        let context = DataStore.sharedInstance.persistentContainer.viewContext  //get context
        
        let message1 = Message(context: context)     //create entity/obj
        message1.content = "One"
        message1.createdAt = Date() as NSDate?
        DataStore.sharedInstance.messages.append(message1)
        
        let message2 = Message(context: context)
        message2.content = "Two"
        message2.createdAt = NSDate(timeIntervalSinceNow: 120)
        DataStore.sharedInstance.messages.append(message2)
        
        
        let message3 = Message(context: context)
        message3.content = "Three"
        message3.createdAt = NSDate(timeIntervalSinceNow: 180)
        DataStore.sharedInstance.messages.append(message2)
        
        //print("msg1:\(message1.createdAt) msg2:\(message2.createdAt) msg3:\(message3.createdAt)")
        
        DataStore.sharedInstance.saveContext()    //save messages in core data
        
        DataStore.sharedInstance.fetchData()    //get messages from core data
    }

    
}
