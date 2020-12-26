//
//  HorizentalMenuView.swift
//  HorizentalMenu
//
//  Created by Arvind on 24/12/20.
//

import UIKit

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

protocol HorizentalMenuDelegate {
    func menuDidSelectItem(item: String, indexPath: IndexPath)
}

//protocol HorizentalMenuDataSource {
//    func horizentalMenuView( horizentalMenuView: HorizentalMenuView, cellForItemAt indexPath: IndexPath) -> MenuItemCollectionViewCell
//}

class HorizentalMenuView: UIView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "MenuItemCollectionViewCell"
    var data = [String]()
    var delegate: HorizentalMenuDelegate?
    //var dataSource: HorizentalMenuDataSource?
    
    override init(frame: CGRect) {
     super.init(frame: frame)
     setup()
    }
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
  
  func setup() {
      view = loadViewFromNib()
      view.frame = bounds
      addSubview(view)
      setUpcolltionView()
    }
  
    func loadViewFromNib() -> UIView! {
       let bundle = Bundle(for: type(of: self))
       let nib = UINib(nibName: "HorizentalMenuView", bundle: bundle)
       let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
       return view
     }
    
    func layoutViewInController(_ viewController: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let topLayout = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: viewController, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
        let bottomLayout = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: viewController, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
       
        let trailingLayout = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: viewController, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0)
        let leadingLayout = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: viewController, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0)
        viewController.addConstraint(topLayout)
        viewController.addConstraint(leadingLayout)
        viewController.addConstraint(trailingLayout)
        viewController.addConstraint(bottomLayout)
        viewController.addSubview(self)
        viewController.bringSubviewToFront(self)
    }
    
    func setUpcolltionView() {
        self.collectionView.register(UINib(nibName: MenuItemCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: MenuItemCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }

}

extension HorizentalMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! MenuItemCollectionViewCell
        cell.backgroundColor = .gray
        cell.configureCellWithNameAndSelectedState(name: data[indexPath.row], isSelected: false)
        return cell
    }
}

extension HorizentalMenuView: UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.menuDidSelectItem(item: data[indexPath.row], indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
            let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
                - sectionInset.left
                - sectionInset.right
                - collectionView.contentInset.left
                - collectionView.contentInset.right
            let width = referenceWidth-40
        
        let referenceHeight = collectionView.safeAreaLayoutGuide.layoutFrame.height
            - sectionInset.top
            - sectionInset.bottom
            - collectionView.contentInset.top
            - collectionView.contentInset.bottom
        let height = referenceHeight
            return CGSize(width: width/3, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
