//
//  PhotoCollectionCell.swift
//  FlickrProofOfConcept
//
//  Created by Aaron Halvorsen on 5/19/18.
//  Copyright © 2018 Aaron Halvorsen. All rights reserved.
//

import UIKit

internal final class PhotoCollectionCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = bounds
        addSubview(imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
}
