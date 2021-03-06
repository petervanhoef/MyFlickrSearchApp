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
    
    func instantiation(flickrPhoto: FlickrPhoto) {
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

    func instantiation(flickrFail: FlickrFail) {
        XCTAssertEqual(flickrFail.stat, "fail")
        XCTAssertEqual(flickrFail.code, 100)
        XCTAssertEqual(flickrFail.message, "Invalid API Key (Key has invalid format)")
    }
    
    func testInstantiationFlickrPhoto() {
        instantiation(flickrPhoto: flickrPhoto)
        instantiation(flickrPhoto: flickrPhotoExt)
    }
    
    let flickrPhotoExt = try! FlickrPhoto(json: ["id": "30864358643", "owner": "90836230@N06", "secret": "2fe6af229f", "server": "157", "farm": 1, "title": "2016 Training Camp: Snowboarding", "ispublic": true, "isfriend": false, "isfamily": false] as [String : Any])
    
    let flickrFail = FlickrFail(stat: "fail", code: 100, message: "Invalid API Key (Key has invalid format)")
    
    func testInstantiationFlickrFail() {
        instantiation(flickrFail: flickrFail)
        instantiation(flickrFail: flickrFailExt)
    }
    
    let flickrFailExt = try! FlickrFail(json: ["stat":"fail","code":100,"message":"Invalid API Key (Key has invalid format)"])
    
    let flickrPhotoDetail = FlickrPhotoDetail(
        id: "30864358643",
        secret: "2fe6af229f",
        username: "specialolympicsusa",
        realname: "",
        title: "2016 Training Camp: Snowboarding",
        description: "Photos from Special Olympics USA Training Camp snowboarding Dec. 15 at Killington Resort in Vermont.",
        datetaken: "2016-12-15 00:29:41")
    
    func instantiation(flickrPhotoDetail: FlickrPhotoDetail) {
        XCTAssertEqual(flickrPhotoDetail.id, "30864358643")
        XCTAssertEqual(flickrPhotoDetail.secret, "2fe6af229f")
        XCTAssertEqual(flickrPhotoDetail.username, "specialolympicsusa")
        XCTAssertEqual(flickrPhotoDetail.realname, "")
        XCTAssertEqual(flickrPhotoDetail.title, "2016 Training Camp: Snowboarding")
        XCTAssertEqual(flickrPhotoDetail.description, "Photos from Special Olympics USA Training Camp snowboarding Dec. 15 at Killington Resort in Vermont.")
        XCTAssertEqual(flickrPhotoDetail.datetaken, "2016-12-15 00:29:41")
    }
    
    let flickrPhotoDetailExt = try! FlickrPhotoDetail(json: [
        "id": "30864358643",
        "secret": "2fe6af229f",
        "owner": ["username": "specialolympicsusa", "realname": ""],
        "title": ["_content": "2016 Training Camp: Snowboarding"],
        "description": ["_content": "Photos from Special Olympics USA Training Camp snowboarding Dec. 15 at Killington Resort in Vermont."],
        "dates": ["taken": "2016-12-15 00:29:41"]
    ])
    
    func testInstantiationFlickPhotoDetail() {
        instantiation(flickrPhotoDetail: flickrPhotoDetail)
        instantiation(flickrPhotoDetail: flickrPhotoDetailExt)
    }
}
