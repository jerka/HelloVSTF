//
//  ViewController.swift
//  Exerciser
//
//  Created by Markus Kruusmägi on 2018-06-08.
//  Copyright © 2018 GravelHill. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var dataSource: DataSource<ViewController>!
    
    private var layout = UICollectionViewFlowLayout()
    
    lazy var viewContext: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Could not get context from \(String(describing: AppDelegate.self))") }
        return appDelegate.dataController.managedObjectContext
    }()
    
    func setupCollectionView() {
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = UIColor.init(red: 71/255.0, green: 113/255.0, blue: 72/255.0, alpha: 1.0)
        view.addSubview(collectionView)
        collectionView.register(UINib.init(nibName: "ExerciseCell", bundle: Bundle.main), forCellWithReuseIdentifier: ExerciseCell.identifier)
        layout.itemSize = ExerciseCell.itemSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
        
    }
    
    func setupDataSource() {
        let fetchRequest = Exercise.sortedFetchRequest
        
        fetchRequest.fetchBatchSize = 20

        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)

        dataSource = DataSource.init(collectionView: self.collectionView, cellIdentifier: ExerciseCell.identifier, fetchedResultsController: frc, delegate: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayCard.allCards.forEach { (card) in
            Exercise.insert(into: viewContext, text: card.description)
        }

        setupCollectionView()
        setupDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: DataSourceDelegate {
    func configure(_ cell: ExerciseCell, for object: Exercise) {
        cell.configure(for: object)
    }
    
    func controllerDidChange(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let itemCount = controller.fetchedObjects?.count ?? 0
        print("#Items: \(itemCount)")
        self.title = "Items: \(itemCount)"
    }
}
