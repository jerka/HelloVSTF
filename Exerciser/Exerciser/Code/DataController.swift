//
//  DataController.swift
//  Exerciser
//
//  Created by Markus Kruusmägi on 2018-06-08.
//  Copyright © 2018 GravelHill. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    
    var managedObjectContext: NSManagedObjectContext
    var backgroundContext: NSManagedObjectContext
    
    init(completion: @escaping () -> ()) {
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("Error loading model!")
        }

        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error init mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = psc
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { fatalError("Unable to resolve document directory") }
            let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                DispatchQueue.main.sync(execute: completion)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}
