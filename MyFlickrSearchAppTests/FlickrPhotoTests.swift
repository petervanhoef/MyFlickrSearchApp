//
//  FlickrPhotoTests.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 18/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import XCTest
@testable import MyFlickrSearchApp

class FlickrPhotoTests: XCTestCase {
    
    let flickrPhoto = FlickrPhoto(photoId: "31680208796", farm: 1, secret: "7338166310", server: "718", title: "Gingerbread House")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotoURL(){
        XCTAssertEqual(flickrPhoto.photoUrl.absoluteString, "https://farm1.staticflickr.com/718/31680208796_7338166310_m.jpg")
    }
    
    func testPhotoBigURL() {
        XCTAssertEqual(flickrPhoto.photoBigUrl.absoluteString, "https://farm1.staticflickr.com/718/31680208796_7338166310_b.jpg")
    }
    
    func testInstantiation() {
        XCTAssertEqual(flickrPhoto.farm, 1)
        XCTAssertEqual(flickrPhoto.photoId, "31680208796")
        XCTAssertEqual(flickrPhoto.secret, "7338166310")
        XCTAssertEqual(flickrPhoto.server, "718")
        XCTAssertEqual(flickrPhoto.title, "Gingerbread House")
    }
    
}
