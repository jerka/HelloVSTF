//
//  DataSource.swift
//  Exerciser
//
//  Created by Markus Kruusmägi on 2018-06-11.
//  Copyright © 2018 GravelHill. All rights reserved.
//

import UIKit
import CoreData

protocol DataSourceDelegate: class {
    associatedtype Object: NSFetchRequestResult
    associatedtype Cell: UICollectionViewCell
    func configure(_ cell: Cell, for object: Object)
    func controllerDidChange(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
}

class DataSource<Delegate: DataSourceDelegate>: NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    private let collectionView: UICollectionView
    private let cellIdentifier: String
    private let fetchedResultsController: NSFetchedResultsController<Object>
    private weak var delegate: Delegate!
    
    required init(collectionView: UICollectionView, cellIdentifier: String, fetchedResultsController: NSFetchedResultsController<Object>, delegate: Delegate) {
        
        self.collectionView = collectionView
        self.cellIdentifier = cellIdentifier
        self.fetchedResultsController = fetchedResultsController
        self.delegate = delegate
        super.init()
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
        collectionView.dataSource = self
        collectionView.reloadData()
    }

    func objectAtIndexPath(_ indexPath: IndexPath) -> Object {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = self.objectAtIndexPath(indexPath)
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? Cell
        else { fatalError("Unexpected cell identifier at \(indexPath)") }
        delegate.configure(cell, for: object)
        return cell
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate.controllerDidChange(controller)
    }
    
}

