//
//  TestHelpers.swift
//  Beats
//
//  Created by Yvette Cook on 17/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func asyncTest(completion: () -> Void, wait: Int64){
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), wait * Int64(NSEC_PER_SEC))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            completion()
        }
    }

}