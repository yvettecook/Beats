//
//  HalfSizePresentationController.swift
//  Beats
//
//  Created by Yvette Cook on 08/02/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

class HalfSizePresentationController: UIPresentationController {
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerView = containerView else {
            fatalError("No container view")
        }
        return CGRect(x: 0, y: containerView.bounds.height * 0.3 , width: containerView.bounds.width, height: containerView.bounds.height * 0.7 )
    }
    
}