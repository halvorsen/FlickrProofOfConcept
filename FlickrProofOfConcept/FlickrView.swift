//
//  FlickrView.swift
//  FlickrProofOfConcept
//
//  Created by Aaron Halvorsen on 5/19/18.
//  Copyright © 2018 Aaron Halvorsen. All rights reserved.
//

import UIKit

internal final class FlickrView: UIView {
    internal let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    internal let searchView: SearchView
    internal var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        let searchHeight = frame.width * 0.2
        searchView = SearchView(frame: CGRect(x: 0, y: 0, width: frame.width, height: searchHeight))
        super.init(frame: frame)
        backgroundColor = .white
        activityIndicator.center = center
        
        addSubview(searchView)
        addSubview(activityIndicator)
        activityIndicator.alpha = 0.0
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: frame.width, height: frame.width * 0.7)
        
        let collectionFrame = CGRect(x: 0, y: frame.width * 0.2, width: frame.width, height: frame.height - searchHeight)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        
        if let collectionView = collectionView {
            collectionView.backgroundColor = .white
            addSubview(collectionView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
