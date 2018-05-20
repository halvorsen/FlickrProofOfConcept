//
//  SearchView.swift
//  FlickrProofOfConcept
//
//  Created by Aaron Halvorsen on 5/19/18.
//  Copyright © 2018 Aaron Halvorsen. All rights reserved.
//

import UIKit

internal final class SearchView: UIView {
    
    internal let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        addSubview(searchBar)
        searchBar.placeholder = "Search Flickr"
        searchBar.backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
