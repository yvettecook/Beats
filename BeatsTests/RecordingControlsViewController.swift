//
//  RecordingControlsViewController.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class RecordingControlsViewControllerTests : XCTestCase {
    
    var recordingControlsVC: RecordingControlsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        recordingControlsVC = storyboard.instantiateViewControllerWithIdentifier("RecordingControlsViewController") as! RecordingControlsViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = recordingControlsVC
        
        XCTAssertNotNil(recordingControlsVC.view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasHeartRateKit() {
        XCTAssertNotNil(recordingControlsVC.heartRateKit)
    }
    
}
