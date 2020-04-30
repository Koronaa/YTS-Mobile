//
//  DeviceManager.swift
//  YTS
//
//  Created by Sajith Konara on 4/30/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit

class DeviceManager{
    
    enum DeviceType{
        case iPhone_5_5s_5C_SE
        case iPhone_6_6s_7_8
        case iPhone_6Plus_6sPlus_7Plus_8Plus
        case iPhone_X_Xs_11Pro
        case iPhone_Xr_11
        case iPhone_XsMax_11ProMax
        case Unknown
    }
    
    static func getDeviceType()->DeviceType{
        switch UIScreen.main.nativeBounds.height {
        case CGFloat(UIDevice.ScreenSize.iPhone_5_5s_5C_SE.rawValue):
            return .iPhone_5_5s_5C_SE
        case CGFloat(UIDevice.ScreenSize.iPhone_6_6s_7_8.rawValue):
            return .iPhone_6_6s_7_8
        case CGFloat(UIDevice.ScreenSize.iPhone_6Plus_6sPlus_7Plus_8Plus.rawValue):
            return .iPhone_6Plus_6sPlus_7Plus_8Plus
        case CGFloat(UIDevice.ScreenSize.iPhone_X_Xs_11Pro.rawValue):
            return .iPhone_X_Xs_11Pro
        case CGFloat(UIDevice.ScreenSize.iPhone_Xr_11.rawValue):
            return .iPhone_Xr_11
        case CGFloat(UIDevice.ScreenSize.iPhone_XsMax_11ProMax.rawValue):
            return .iPhone_XsMax_11ProMax
        default:
            return .Unknown
            
        }
    }
    
}
