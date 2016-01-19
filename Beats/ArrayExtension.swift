//
//  ArrayExtension.swift
//  Beats
//
//  Created by Yvette Cook on 19/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

extension Array {
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}
