//
//  MaterialView.swift
//  DreamLister
//
//  Created by ronny abraham on 10/26/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIView {

    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        }
        
        set {
            materialKey = newValue
        }
    }
}
