//
//  MenuItemCollectionViewCell.swift
//  HorizentalMenu
//
//  Created by Arvind on 24/12/20.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var selectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            self.selectionLabel.isHidden = !isSelected
        }
    }
    
    func configureCellWithNameAndSelectedState(name: String, isSelected: Bool) {
        self.categoryNameLabel.text = name
        self.isSelected = isSelected
    }
    
    func configureCellWithName(name: String) {
        self.categoryNameLabel.text = name
    }

}
