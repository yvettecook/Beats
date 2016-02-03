//
//  Session.swift
//  Beats
//
//  Created by Yvette Cook on 02/02/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class Session: NSObject {
    
    var values: [Record]?
    
    var startTime: NSDate?
    var endTime: NSDate?
    var name: String?
    
    override init() {
        values = [Record]()
        startTime = NSDate()
    }
    
    func addValue(value: Int) {
        let record = Record(value: value)
        values?.append(record)
    }
    
    func end() {
        endTime = NSDate()
    }
    
    func name(name: String) {
        self.name = name
    }

}