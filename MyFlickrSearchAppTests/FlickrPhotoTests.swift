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
    
    func testInstantiationFlickrPhoto() {
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
    
    let flickrPhotoExt = try! FlickrPhoto(json: ["id": "30864358643", "owner": "90836230@N06", "secret": "2fe6af229f", "server": "157", "farm": 1, "title": "2016 Training Camp: Snowboarding", "ispublic": 1, "isfriend": 0, "isfamily": 0])
    
    func testInstantiationFlickrPhotoExt() {
        XCTAssertEqual(flickrPhotoExt.id, "30864358643")
        XCTAssertEqual(flickrPhotoExt.owner, "90836230@N06")
        XCTAssertEqual(flickrPhotoExt.secret, "2fe6af229f")
        XCTAssertEqual(flickrPhotoExt.server, "157")
        XCTAssertEqual(flickrPhotoExt.farm, 1)
        XCTAssertEqual(flickrPhotoExt.title, "2016 Training Camp: Snowboarding")
        XCTAssertEqual(flickrPhotoExt.isPublic, true)
        XCTAssertEqual(flickrPhotoExt.isFriend, false)
        XCTAssertEqual(flickrPhotoExt.isFamily, false)
    }
    
    let flickrFail = FlickrFail(stat: "fail", code: 100, message: "Invalid API Key (Key has invalid format)")
    
    func testInstantiationFlickrFail() {
        XCTAssertEqual(flickrFail.stat, "fail")
        XCTAssertEqual(flickrFail.code, 100)
        XCTAssertEqual(flickrFail.message, "Invalid API Key (Key has invalid format)")
    }
    
    let flickrFailExt = try! FlickrFail(json: ["stat":"fail","code":100,"message":"Invalid API Key (Key has invalid format)"])
    
    func testInstantiationFlickrFailExt() {
        XCTAssertEqual(flickrFailExt.stat, "fail")
        XCTAssertEqual(flickrFailExt.code, 100)
        XCTAssertEqual(flickrFailExt.message, "Invalid API Key (Key has invalid format)")
    }
    
}
