//
//  Exercise.swift
//  Exerciser
//
//  Created by Markus Kruusmägi on 2018-06-08.
//  Copyright © 2018 GravelHill. All rights reserved.
//

import Foundation
import CoreData

@objc(Exercise)
class Exercise: NSManagedObject {
    @NSManaged fileprivate(set) var name: String
}


extension Exercise: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(name), ascending: true)]
    }
    static var entityName: String {
        return String(describing: self)
    }
    
    @discardableResult static func insert(into context: NSManagedObjectContext, text: String) -> Exercise {
        let exercise: Exercise = context.insertObject()
        exercise.name = text
        return exercise
    }
}
