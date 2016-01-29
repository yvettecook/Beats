//
//  UIButtonWithAspectFit.swift
//  Beats
//
//  Created by Yvette Cook on 29/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

class UIButtonWithAspectFit: UIButton {
    
    override func awakeFromNib() {
        self.imageView?.contentMode = .ScaleAspectFit
    }
    
}
