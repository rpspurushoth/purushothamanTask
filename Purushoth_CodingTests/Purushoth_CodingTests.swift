//
//  Purushoth_CodingTests.swift
//  Purushoth_CodingTests
//
//  Created by AEL5625 on 19/12/19.
//  Copyright © 2019 AEL5106. All rights reserved.
//

import XCTest
@testable import Purushoth_Coding

class Purushoth_CodingTests: XCTestCase {
    
    var window: UIWindow?
    var navController: UINavigationController?
    var systemUnderTest: DataViewController!
    
    override func setUp() {
        super.setUp()
        let viewController: DataViewController = DataViewController()
        systemUnderTest = viewController
        _ = systemUnderTest.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_CanInstantiateViewController() {
        XCTAssertNotNil(systemUnderTest)
    }
    
    func testExample() {
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
    
    func testSUI_APIIsNetworkCONNECTED() {
           XCTAssertTrue(NetworkConnectivity.networkConnectionAvailable)
    }
    
    func testSUI_APIIsNetworkDISCONNECTED() {
        XCTAssertFalse(NetworkConnectivity.networkConnectionAvailable)
    }
    
    func testSUI_ResponseEmptyArray() {
        XCTAssertTrue(systemUnderTest.rowsData.count == 0)
    }
    
     func testSUI_ResponseNonEmptyArray() {
           XCTAssertTrue(systemUnderTest.rowsData.count > 0)
       }
    
    func testSUT_CollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(systemUnderTest.rowsData)
    }
    
    func testSUT_HasItemsForCollectionView() {
        XCTAssertNotNil(systemUnderTest.rowsData.count)
    }
    
    func testSUT_ShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(systemUnderTest.canadaCollectionView.dataSource)
    }
    
    func testSUT_ConformsToCollectionViewDataSource() {
        XCTAssert(systemUnderTest.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(systemUnderTest.responds(to: #selector(systemUnderTest.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(systemUnderTest.responds(to: #selector(systemUnderTest.collectionView(_:cellForItemAt:))))
    }
    
    
    func testSUT_ShouldSetNilCollectionViewDelegate() {
        XCTAssertNil(systemUnderTest.canadaCollectionView.delegate)
    }
    
    func testSUT_ShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(systemUnderTest.canadaCollectionView.delegate)
    }
    
    func testSUT_ConformsToCollectionViewDelegate() {
        XCTAssert(systemUnderTest.conforms(to: UICollectionViewDelegate.self))
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        XCTAssert(self.systemUnderTest.conforms(to: UICollectionViewDelegateFlowLayout.self))
        XCTAssert(systemUnderTest.responds(to: #selector(systemUnderTest.collectionView(_:layout:sizeForItemAt:))))
        XCTAssertTrue(systemUnderTest.responds(to: #selector(systemUnderTest.collectionView(_:layout:minimumLineSpacingForSectionAt:))))
        XCTAssertTrue(systemUnderTest.responds(to: #selector(systemUnderTest.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))))
    }
}
