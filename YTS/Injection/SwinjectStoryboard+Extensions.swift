//
//  SwinjectStoryboard+Extensions.swift
//  Corona
//
//  Created by Sajith Konara on 4/1/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard{
    
    public class func setup(){
        if AppDelegate.dependencyRegistry == nil{
            AppDelegate.dependencyRegistry = DependencyRegistryIMPL(container: defaultContainer)
        }
        
        let dependencyRegistry:DependencyRegistryIMPL = AppDelegate.dependencyRegistry
        
        func main(){
            dependencyRegistry.container.storyboardInitCompleted(HomeViewController.self) { (resolver, viewController) in
                
                viewController.configure(movieListVCMaker: dependencyRegistry.makeMovieListViewController, movieDetailMaker: dependencyRegistry.makeMovieDetailsViewController, searchMaker: dependencyRegistry.makeSearchViewController, favouriteTableViewCellMaker: dependencyRegistry.makeFavouriteTableViewCell, homeTableViewCellMaker: dependencyRegistry.makeHomeTableViewCell, homeViewModel: resolver.resolve(HomeViewModel.self)!)
            }
        }
        main()
    }
}
