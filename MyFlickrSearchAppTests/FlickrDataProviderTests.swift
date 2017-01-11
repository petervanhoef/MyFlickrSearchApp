//
//  FlickrDataProviderTests.swift
//  MyFlickrSearchApp
//
//  Created by Peter Vanhoef on 28/12/16.
//  Copyright © 2016 Peter Vanhoef. All rights reserved.
//

import XCTest
@testable import MyFlickrSearchApp

class FlickrDataProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    let flickrPhoto = FlickrPhoto(
        id: "30864358643",
        owner: "90836230@N06",
        secret: "2fe6af229f",
        server: "157",
        farm: 1,
        title: "2016 Training Camp: Snowboarding (12/15)",
        isPublic: true,
        isFriend: false,
        isFamily: false)
    
    let flickrPhotoDetailResult = FlickrPhotoDetail(
        id: "30864358643",
        secret: "2fe6af229f",
        username: "specialolympicsusa",
        realname: "",
        title: "2016 Training Camp: Snowboarding (12/15)",
        description: "Photos from Special Olympics USA Training Camp snowboarding Dec. 15 at Killington Resort in Vermont.",
        datetaken: "2016-12-15 00:29:41")
    
    func testGetDetails() {
        var flickrPhotoDetailReturned: FlickrPhotoDetail?
        let expected = expectation(description: "Wait to retrieve flickrPhoto")
        
        FlickrDataProvider.getDetails(forPhoto: flickrPhoto, onCompletion:  { (error: DataProviderError?, flickrPhotoDetail: FlickrPhotoDetail?) -> Void in

            expected.fulfill()
            flickrPhotoDetailReturned = flickrPhotoDetail
        })

        waitForExpectations(timeout: 20, handler: nil)
        // Or we should implement the Equatable protocol
        XCTAssertEqual(self.flickrPhotoDetailResult.id, flickrPhotoDetailReturned!.id)
        XCTAssertEqual(self.flickrPhotoDetailResult.secret, flickrPhotoDetailReturned!.secret)
        XCTAssertEqual(self.flickrPhotoDetailResult.username, flickrPhotoDetailReturned!.username)
        XCTAssertEqual(self.flickrPhotoDetailResult.realname, flickrPhotoDetailReturned!.realname)
        XCTAssertEqual(self.flickrPhotoDetailResult.title, flickrPhotoDetailReturned!.title)
        XCTAssertEqual(self.flickrPhotoDetailResult.description, flickrPhotoDetailReturned!.description)
        XCTAssertEqual(self.flickrPhotoDetailResult.datetaken, flickrPhotoDetailReturned!.datetaken)
        
    }

    func testFetchPhotos() {
        var flickrPhotosReturned: [FlickrPhoto]?
        let expected = expectation(description: "Wait to search for flickrPhoto")
        
        FlickrDataProvider.fetchPhotos(searchText: "Snowboarding", section: 1, onCompletion: { (error: DataProviderError?, flickrPhotos: [FlickrPhoto]?) -> Void in
        
            expected.fulfill()
            flickrPhotosReturned = flickrPhotos
        })
    
        waitForExpectations(timeout: 20, handler: nil)
        // Or we should implement the Equatable protocol
        XCTAssertNotEqual(0, flickrPhotosReturned!.count)
        
    }
}
