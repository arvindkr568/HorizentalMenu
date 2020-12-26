//
//  ViewController.swift
//  HorizentalMenu
//
//  Created by Arvind on 24/12/20.
//

import UIKit

class ViewController: UIViewController, HorizentalMenuDelegate {
   
//    func horizentalMenuView(horizentalMenuView: HorizentalMenuView, cellForItemAt indexPath: IndexPath) -> MenuItemCollectionViewCell {
//
//        return MenuItemCollectionViewCell
//    }
    
    func menuDidSelectItem(item: String, indexPath: IndexPath) {
        print("Selected item is : \(item) index \(indexPath.row)")
        textLabel.text = "Selected item is : \(item) index \(indexPath.row)"
    }
    

    @IBOutlet weak var horizantalMenuView: HorizentalMenuView!
    @IBOutlet weak var textLabel: UILabel!
    
    let itemsArray = ["Zero", "One", "Two", "Three", "Four", "Five"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //horizantalMenuView.dataSource = self
        horizantalMenuView.delegate = self
        horizantalMenuView.data = itemsArray
        horizantalMenuView.reloadData()
    }


}

