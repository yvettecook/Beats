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
    
    override init() {
        values = [Record]()
    }
    
    func addValue(value: Int) {
        let record = Record()
        values?.append(record)
    }

}