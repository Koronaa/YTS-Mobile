//
//  UIHelper.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

class UIHelper{
    
    static private func makeViewController(storyBoardName:String, viewControllerName:String) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
    static func makeViewController<T:UIViewController>(in storyboard:UIConstants.StoryBoard = .Main,viewControllerName:UIConstants.StoryBoardID) -> T{
        return makeViewController(storyBoardName: storyboard.rawValue, viewControllerName: viewControllerName.rawValue) as! T
    }
    
    static func makeHomeNavifationController() -> UINavigationController{
        makeViewController(storyBoardName: UIConstants.StoryBoard.Main.rawValue, viewControllerName: UIConstants.StoryBoardID.HomeNC.rawValue) as! UINavigationController
    }
    
    static func show(navigationController controller:UINavigationController?){
        if let navController = controller{
            navController.setNavigationBarHidden(false, animated: true)
        }
    }
    
    static func hide(navigationController controller:UINavigationController?){
        if let navController = controller{
            navController.setNavigationBarHidden(true, animated: true)
        }
    }
    
    static func addShadow(to view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        view.layer.shadowOpacity = 0.4
    }
    
    static func addCornerRadius(to view:UIView,withRadius radius:CGFloat = 4, withborder:Bool = false,using borderColor:CGColor = UIColor.black.cgColor){
        view.layer.cornerRadius = radius
        if (withborder){
            view.layer.borderWidth = 0.5
            view.layer.borderColor = borderColor
        }
    }
    
    static func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    static func makeRootViewController(viewController vc:UIViewController){
        let topWindow = UIApplication.shared.keyWindow
        topWindow!.rootViewController = vc
        topWindow!.makeKeyAndVisible()
    }
    
    static func circular(view:UIView){
        view.layer.borderWidth = 0.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = view.frame.height/2
        view.clipsToBounds = true
    }
    
    static func makeBanner(for error:Error,style:BannerStyle = .danger) -> GrowingNotificationBanner{
        return GrowingNotificationBanner(title: error.title, subtitle: error.message, style: style)
    }
    
}
