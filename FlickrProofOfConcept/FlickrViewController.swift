//
//  FlickrViewController.swift
//  FlickrProofOfConcept
//
//  Created by Aaron Halvorsen on 5/19/18.
//  Copyright © 2018 Aaron Halvorsen. All rights reserved.
//

import UIKit

internal final class FlickrViewController: UIViewController, FlickrDelegate {
    
    private let flickr = Flickr()
    private var flickerView: FlickrView?
    private let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flickerView = FlickrView(frame: view.bounds)
        if let flickerView = flickerView,
            let collectionView = flickerView.collectionView {
            view.addSubview(flickerView)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: cellId)
            collectionView.showsVerticalScrollIndicator = false
            flickerView.searchView.searchBar.delegate = self
            flickr.delegate = self
            
        }
        
    }
    
    internal func imageSetDidChange(_ images: [UIImage]) {
        
        toggleActivityIndicator(false)
        DispatchQueue.main.async {
            self.flickerView?.collectionView?.reloadData()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func toggleActivityIndicator(_ turnOn: Bool) {
        guard let flickerView = flickerView else { return }
        DispatchQueue.main.async {
            if !turnOn {
                if flickerView.activityIndicator.isAnimating {
                    flickerView.activityIndicator.stopAnimating()
                    flickerView.activityIndicator.alpha = 0.0
                }
            }
            else {
                flickerView.activityIndicator.startAnimating()
                flickerView.activityIndicator.alpha = 1.0
            }
        }
    }
    
    private func clearPhotos() {
        flickr.removeAllImages()
        flickerView?.collectionView?.reloadData()
    }
    
}

extension FlickrViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            toggleActivityIndicator(true)
            clearPhotos()
            flickerView?.searchView.searchBar.resignFirstResponder()
            flickr.didEndEditingSearchBar(withDescription: searchText)
        }
    }
    
}

extension FlickrViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickr.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoCollectionCell
        
        if flickr.images.count > indexPath.row {
            cell.setImage(flickr.images[indexPath.row])
        }
        
        return cell
    }
    
}
