//
//  CollectionViewController.swift
//  ImagePreview
//
//  Created by Hector Ghinaglia on 8/28/17.
//  Copyright © 2017 Hector Ghinaglia. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, TappableImageViewDelegate {

    let images: [UIImage] = [#imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img3"), #imageLiteral(resourceName: "img4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: CollectionCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionCell
        cell.iconImageView.delegate = self
        cell.iconImageView.image = images[indexPath.row]        
        return cell
    }
    
}
