//
//  TinyPixUtils.swift
//  TinyPix
//
//  Created by Admin on 24.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TinyPixUtils {
    class func getTintColorForIndex(index: Int) -> UIColor {
        let color: UIColor
        switch index {
        case 0:
            color = UIColor.red
        case 1:
            color = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        case 2:
            color = UIColor.blue

        default:
            color = UIColor.red
        }
        return color
    }
}
