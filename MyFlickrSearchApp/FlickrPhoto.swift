//
//  FlickrPhoto.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import Foundation

struct FlickrPhoto {
    
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg")!
    }
    
    var photoBigUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_b.jpg")!
    }
    
}
