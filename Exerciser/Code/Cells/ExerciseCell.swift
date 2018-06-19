//
//  ExerciseCell.swift
//  Exerciser
//
//  Created by Markus Kruusmägi on 2018-06-11.
//  Copyright © 2018 GravelHill. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {

    // MARK: Private
    @IBOutlet private var label: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: Public
    
    func configure(for object: Exercise) {
        label.text = object.name
    }
    static private let itemsPerLine = 3
    
    static var itemSize: CGSize {
        let margins: Int = 20 * 2 + (itemsPerLine - 1) * 10
        let width: CGFloat = ((UIScreen.main.bounds.width - CGFloat(margins)) / 3)
        let height: CGFloat = width * 88.9 / 63.50
        return CGSize(width: width, height: height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.bounds = CGRect(x: 0, y: 0, width: 335, height: 55)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5.0
    }

}
