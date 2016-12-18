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
    
    let flickrPhoto = FlickrPhoto(id: "30864358643", owner: "90836230@N06", secret: "2fe6af229f", server: "157", farm: 1, title: "2016 Training Camp: Snowboarding", isPublic: true, isFriend: false, isFamily: false)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
  
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotoURL(){
        XCTAssertEqual(flickrPhoto.photoSquareUrl.absoluteString, "https://farm1.staticflickr.com/157/30864358643_2fe6af229f_q.jpg")
    }
    
    func testPhotoBigURL() {
        XCTAssertEqual(flickrPhoto.photoLargeUrl.absoluteString, "https://farm1.staticflickr.com/157/30864358643_2fe6af229f_b.jpg")
    }
    
    func testInstantiation() {
        XCTAssertEqual(flickrPhoto.id, "30864358643")
        XCTAssertEqual(flickrPhoto.owner, "90836230@N06")
        XCTAssertEqual(flickrPhoto.secret, "2fe6af229f")
        XCTAssertEqual(flickrPhoto.server, "157")
        XCTAssertEqual(flickrPhoto.farm, 1)
        XCTAssertEqual(flickrPhoto.title, "2016 Training Camp: Snowboarding")
        XCTAssertEqual(flickrPhoto.isPublic, true)
        XCTAssertEqual(flickrPhoto.isFriend, false)
        XCTAssertEqual(flickrPhoto.isFamily, false)
    }
    
}
