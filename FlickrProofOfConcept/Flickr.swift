//
//  Flickr.swift
//  FlickrProofOfConcept
//
//  Created by Aaron Halvorsen on 5/20/18.
//  Copyright © 2018 Aaron Halvorsen. All rights reserved.
//
import UIKit.UIImage

internal protocol FlickrDelegate: class {
    func imageSetDidChange(_ images: [UIImage])
}

internal final class Flickr {
    
    internal weak var delegate: FlickrDelegate?
    
    private(set) internal var images: [UIImage] = [] {
        didSet {
            
            delegate?.imageSetDidChange(images)
        }
    }
    
    internal func didEndEditingSearchBar(withDescription text: String) {
        
        let words = text.components(separatedBy: " ")
        fetchWith(tags: words)
        
    }
    
    internal func removeAllImages() {
        images.removeAll()
    }
    
    internal func fetchWith(tags: [String]) {
        
        var tagsList = "&tags="
        for tag in tags {
            tagsList = tagsList + tag + ","
        }
        tagsList.removeLast()
        
        let _url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1" + tagsList)
        
        guard let url = _url else { return }
        
        let searchTask = URLSession.shared.dataTask(with: url) { [weak self] (_data, _, _error) -> Void in
            guard let weakself = self else { return }
            if let error = _error {
                print(error.localizedDescription)
            }
            else if let data = _data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any],
                        let items = json["items"] as? [Any] {
                        for item in items {
                            
                            if let subItem = item as? [String: Any],
                                let media = subItem["media"] as? [String: Any],
                                let urlString = media["m"] as? String {
                                weakself.fetchAndStoreImage(imageURL: urlString)
                            }
                        }
                    }
                } catch let error {
                    print("json fail: \(error.localizedDescription)")
                }
            }
        }
        searchTask.resume()
    }
    
    private func fetchAndStoreImage(imageURL: String)  {
        
        guard let url = URL(string: imageURL) else { return }
        
        let imageTask = URLSession.shared.dataTask(with: url) { (_data, response, _error) in
            if let error = _error {
                print("Error downloading cat picture: \(error)")
            }
            else if let data = _data {
                if let image = UIImage(data: data) {
                    self.images.append(image)
                } else {
                    print("data to image failure")
                }
            }
                
            else {
                print("image fetch failure")
            }
        }
        imageTask.resume()
    }
}
