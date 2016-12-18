//
//  FlickrDataProvider.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import Foundation

class FlickrDataProvider {
    
    typealias FlickrResponse = (NSError?, [FlickrPhoto]?) -> Void
    
    fileprivate struct Keys {
        static let flickrKey = "62847c623bf5b121ba54f85717beb784"
    }
    
    struct FlickrErrors {
        static let invalidAPIKey = 100
    }
    
    class func fetchPhotos(searchText: String, section page: Int, onCompletion: @escaping FlickrResponse) -> Void {
        // formatting search text
        let replacement = searchText.replacingOccurrences(of: " ", with: "+")
        let escapedSearchText: String = replacement.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        // formatting URL
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&tags=\(escapedSearchText)&per_page=25&page=\(page)&format=json&nojsoncallback=1"
        print("\(urlString)")
        let url: URL = URL(string: urlString)!
        
        // performing the search
        let searchTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("Error fetching photos: \(error)")
                onCompletion(error as NSError?, nil)
                return
            }
            
            do {
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                guard let results = resultsDictionary else { return }
                
                // check if status code was returned instead of answer
                if let statusCode = results["code"] as? Int {
                    if statusCode == FlickrErrors.invalidAPIKey {
                        let invalidAccessError = NSError(domain: "com.flickr.api", code: statusCode, userInfo: nil)
                        onCompletion(invalidAccessError, nil)
                        return
                    }
                }
                
                // we should have a valid response
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                guard let currentPage = photosContainer["page"] as? Int else { return }
                guard let totalPages = photosContainer["pages"] as? Int else { return }
                //guard let totalPictures = photosContainer["total"] as? String else { return } // variable not used
                
                // if we are requesting more pages than present, we return - seems this is an ugly hack
                if (currentPage > totalPages) {
                    onCompletion(NSError(domain: "Requested to much pages", code: 1, userInfo: nil), nil)
                    return
                }
                
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                let flickrPhotos: [FlickrPhoto] = photosArray.map { photoDictionary in
                    
                    let id          = photoDictionary["id"] as? String ?? ""
                    let owner       = photoDictionary["owner"] as? String ?? ""
                    let secret      = photoDictionary["secret"] as? String ?? ""
                    let server      = photoDictionary["server"] as? String ?? ""
                    let farm        = photoDictionary["farm"] as? Int ?? 0
                    let title       = photoDictionary["title"] as? String ?? ""
                    let isPublic    = photoDictionary["ispublic"] as? Bool ?? false
                    let isFriend    = photoDictionary["isfriend"] as? Bool ?? false
                    let isFamily    = photoDictionary["isfamily"] as? Bool ?? false
                    
                    let flickrPhoto = FlickrPhoto(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title, isPublic: isPublic, isFriend: isFriend, isFamily: isFamily)
                    return flickrPhoto
                }
                
                onCompletion(nil, flickrPhotos)
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(error, nil)
                return
            }
            
        })
        searchTask.resume()
    }
    
}
