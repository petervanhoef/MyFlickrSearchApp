//
//  FlickrDataProvider.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import Foundation

enum DataProviderError: Error {
    case serialization(String)
    case network(String)
    case fetching(FlickrFail)
}

class FlickrDataProvider {
    
    typealias FlickrResponse = (DataProviderError?, [FlickrPhoto]?) -> Void
    typealias FlickrDetailResponse = (DataProviderError?, FlickrPhotoDetail?) -> Void
    
    fileprivate struct Keys {
        static let flickrKey = "todo"
    }
    
    // note: escaping because the closure is invoked after the functions returns
    class func fetchPhotos(searchText: String, section page: Int, onCompletion: @escaping FlickrResponse) {
        // formatting search text
        let replacement = searchText.replacingOccurrences(of: " ", with: "+")
        let escapedSearchText: String = replacement.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        // formatting URL
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&tags=\(escapedSearchText)&per_page=25&page=\(page)&format=json&nojsoncallback=1"
        print("\(urlString)")
        let url: URL = URL(string: urlString)!
        
        // performing the search
        let searchTask = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if error != nil {
                print("Error fetching photos: \(error)")
                onCompletion(DataProviderError.network("dataTask failed"), nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                guard let results = json else { return }
                
                if let stat = results["stat"] as? String {
                    switch stat {
                    case "ok":
                        var flickrPhotos2: [FlickrPhoto] = []
                        print("search ok")
                        
                        guard let photosContainerJSON = results["photos"] as? [String: Any] else { print("photosjson faild"); return }
                        
                        
                        guard let currentPage2 = photosContainerJSON["page"] as? Int else {print("curpage2 failed") ; return }
                        guard let totalPages2 = photosContainerJSON["pages"] as? Int else {print("totalpage2 failed") ; return }
                        
                        
                        if let photosContainer2 = photosContainerJSON["photo"] as? [Any]
                        {
                            for case let photo in photosContainer2 {
                                if let flickrPhoto = try FlickrPhoto(json: (photo as? [String : Any])!) as? FlickrPhoto {
                                    print("json passed = \(photo)")
                                    flickrPhotos2.append(flickrPhoto)
                                }
                            }
                            onCompletion(nil, flickrPhotos2)
                            
                        }
                        
                    //case "fail":
                    default:
                        print("search fail")
                        let flickrError = try FlickrFail(json: json!)
                        onCompletion(DataProviderError.fetching(flickrError), nil)
                        return
                    }
                }
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(DataProviderError.network("unkown error"), nil)
                return
            }
            
        }
        searchTask.resume()
    }

    class func getDetails(forPhoto: FlickrPhoto, onCompletion: @escaping FlickrDetailResponse) {
        
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=\(Keys.flickrKey)&photo_id=\(forPhoto.id)&secret=\(forPhoto.secret)&format=json&nojsoncallback=1"
        let url = URL(string: urlString)!
        
        let searchTask = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if error != nil {
                print("Error fetching details: \(error)")
                onCompletion(DataProviderError.network("dataTask failed"), nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                guard let results = json else { return }
                
                if let stat = results["stat"] as? String {
                    switch stat {
                    case "ok":
                        print("search ok")
                        
                        guard let photosContainerJSON = results["photo"] as? [String: Any] else { print("photosjson faild"); return }
                        
                        let flickrPhotoDetail = try! FlickrPhotoDetail(json: photosContainerJSON)
                        
                        onCompletion(nil, flickrPhotoDetail)
                        
                    //case "fail":
                    default:
                        print("search fail")
                        let flickrError = try FlickrFail(json: json!)
                        onCompletion(DataProviderError.fetching(flickrError), nil)
                        return
                    }
                }
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                onCompletion(DataProviderError.network("unkown error"), nil)
                return
            }
            
        }
        searchTask.resume()
        
    }
}
