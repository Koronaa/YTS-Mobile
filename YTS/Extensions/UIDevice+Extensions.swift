//
//  UIDevice+Extensions.swift
//  YTS
//
//  Created by Sajith Konara on 4/30/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice{
    
    enum ScreenSize:Double{
        case iPhone_5_5s_5C_SE = 1136.0
        case iPhone_6_6s_7_8 = 1334.0
        case iPhone_6Plus_6sPlus_7Plus_8Plus = 2208.0//1920.0
        case iPhone_X_Xs_11Pro = 2436.0
        case iPhone_Xr_11 = 1792.0
        case iPhone_XsMax_11ProMax = 2688.0
        case iPad_Pro_12_9 = 2732.0
        case iPad_Pro_11 = 2388.0
        case iPad_Pro_10_5 = 2224.0
        case iPad_Pro_9_7_Air2_Mini4 = 2048.0
        case iPad_Legacy = 1024.0
    }
}

