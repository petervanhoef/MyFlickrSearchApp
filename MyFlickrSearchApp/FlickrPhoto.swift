//
//  FlickrPhoto.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 17/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import Foundation

struct FlickrPhoto {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Bool
    let isFriend: Bool
    let isFamily: Bool
    
    // computed
    var photoSquareUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg")!
    }
    var photoLargeUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg")!
    }
    
}

extension FlickrPhoto {
    init(json: [String: Any]) throws {
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        
        // Extract owner
        guard let owner = json["owner"] as? String else {
            throw SerializationError.missing("owner")
        }
        
        // Extract secret
        guard let secret = json["secret"] as? String else {
            throw SerializationError.missing("secret")
        }
        
        // Extract server
        guard let server = json["server"] as? String else {
            throw SerializationError.missing("server")
        }

        // Extract farm
        guard let farm = json["farm"] as? Int else {
            throw SerializationError.missing("farm")
        }

        // Extract title
        guard let title = json["title"] as? String else {
            throw SerializationError.missing("title")
        }

        // Extract isPublic
        guard let isPublic = json["ispublic"] as? Bool else {
            throw SerializationError.missing("isPublic")
        }

        // Extract isFriend
        guard let isFriend = json["isfriend"] as? Bool else {
            throw SerializationError.missing("isFriend")
        }
        
        // Extract isFamily
        guard let isFamily = json["isfamily"] as? Bool else {
            throw SerializationError.missing("isFamily")
        }
        
        // Initialize properties
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.isPublic = isPublic
        self.isFriend = isFriend
        self.isFamily = isFamily
    }    
}

struct FlickrFail {
    let stat: String
    let code: Int
    let message: String
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

extension FlickrFail {
    init(json: [String: Any]) throws {
        // Extract stat
        guard let stat = json["stat"] as? String else {
            throw SerializationError.missing("stat")
        }
        
        // Extract code
        guard let code = json["code"] as? Int else {
            throw SerializationError.missing("code")
        }
        
        // Extract message
        guard let message = json["message"] as? String else {
            throw SerializationError.missing("message")
        }
        
        // Initialize properties
        self.stat = stat
        self.code = code
        self.message = message
    }
}

struct FlickrPhotoDetail {
    let id: String
    let secret: String
    let username: String
    let realname: String
    let title: String
    let description: String
    let datetaken: String
}

extension FlickrPhotoDetail {
    init(json: [String : Any]) throws {
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }

        // Extract secret
        guard let secret = json["secret"] as? String else {
            throw SerializationError.missing("secret")
        }

        // Extract username and realname
        guard let ownerJSON = json["owner"] as? [String : Any],
            let username = ownerJSON["username"] as? String,
            let realname = ownerJSON["realname"] as? String
        else {
            throw SerializationError.missing("owner")
        }

        // Extract title
        guard let titleJSON = json["title"] as? [String : Any],
            let title = titleJSON["_content"] as? String
        else {
            throw SerializationError.missing("title")
        }

        // Extract description
        guard let descriptionJSON = json["description"] as? [String : Any],
            let description = descriptionJSON["_content"] as? String
        else {
            throw SerializationError.missing("description")
        }

        // Extract datetaken
        guard let datesJSON = json["dates"] as? [String : Any],
            let datetaken = datesJSON["taken"] as? String
        else {
            throw SerializationError.missing("dates.taken")
        }

        // Initialize properties
        self.id = id
        self.secret = secret
        self.username = username
        self.realname = realname
        self.title = title
        self.description = description
        self.datetaken = datetaken
    }
}
