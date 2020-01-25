//
//  PinBoardTests.swift
//  PinBoardTests
//
//  Created by Dhananjay on 22/01/20.
//  Copyright © 2020 Dhananjay Pawar. All rights reserved.
//

import XCTest
@testable import PinBoard

class PinBoardTests: XCTestCase {

    var pinDetailsArray = [PBPinsListModel]()
    var galleryViewController: PBGalleryViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let navigationController = UINavigationController()
        self.galleryViewController = Utility.getMainStroryBoard().instantiateViewController(withIdentifier: "PBGalleryViewController") as? PBGalleryViewController
        navigationController.viewControllers = [self.galleryViewController]
        self.galleryViewController.loadView()
        self.galleryViewController.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHasATableView() {
        XCTAssertNotNil(self.galleryViewController.tblGalleryPins)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(self.galleryViewController?.tblGalleryPins.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(self.galleryViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(self.galleryViewController.responds(to: #selector(self.galleryViewController.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(self.galleryViewController?.tblGalleryPins.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.galleryViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(self.galleryViewController.responds(to: #selector(self.galleryViewController.tableView(_:cellForRowAt:))))
    }

    func loadPinsFromServer() {
        let getData = self.expectation(description: "Data loaded from Pins Server")
        PBAPIRequestManager.getAllPinsList(reqUrl: PBConstants.kWsGetPinsListingUrl) { (pinsListArray, error) in
            if pinsListArray!.count > 0 {
                for pins in pinsListArray! {
                    self.pinDetailsArray.append(pins)
                }
                getData.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = self.galleryViewController.tableView(self.galleryViewController.tblGalleryPins, cellForRowAt: IndexPath(row: 0, section: 0)) as? PBPinDetailsTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "PBPinDetailsTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
}
