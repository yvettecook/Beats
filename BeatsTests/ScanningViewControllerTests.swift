//
//  ScanningViewControllerTests.swift
//  Beats
//
//  Created by Yvette Cook on 19/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class ScanningViewControllerTests: XCTestCase {
    
    var scanningVC: ScanningViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        scanningVC = storyboard.instantiateViewControllerWithIdentifier("ScanningViewController") as! ScanningViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = scanningVC
        
        let _ = scanningVC.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasState() {
        XCTAssertNotNil(scanningVC.state)
    }
    
    func testHasHeartRateKit() {
        XCTAssertNotNil(scanningVC.heartRateKit)
    }

    func testCanSetHRKitToDemo() {
        scanningVC.setToDemoMode()
        XCTAssertEqual(scanningVC.heartRateKit!.mode, HeartRateKitMode.Demo)
    }
    
    func testCanUpdateVCStateWhenHRKitStateChanges() {
        scanningVC.setToDemoMode()
        scanningVC.heartRateKit?.state = .Connected
        XCTAssertEqual(self.scanningVC.state, UIState.Connected)
    }
}
