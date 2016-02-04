//
//  Record.swift
//  Beats
//
//  Created by Yvette Cook on 02/02/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class Record: NSObject {
    
    var value: Int!
    var time: NSDate!
    
    init(value: Int) {
        self.value = value
        self.time = NSDate()
    }
    
}