//
//  UIConstants.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class UIConstants{
    
    enum StoryBoardID:String{
        
        case LoginVC = "loginVC"
        case RegisterVC = "registerVC"
        case ForgetPasswordVC = "forgotPasswordVC"
        case ResetPasswordVC = "resetPasswordVC"
        case HomeVC = "homeVC"
        case HomeNC = "homeNC"
        case MovieDetailsVC = "movieDetailsVC"
        case SearchVC = "searchVC"
        case MovieListVC = "movieListVC"
        case DownloadVC = "downloadVC"
    }
    
    enum StoryBoard:String{
        case Login = "Login"
        case Main = "Main"
    }
    
    enum Cell:String{
        case FavouritesCollectionViewCell = "favouritesCVCell"
        case HomeCollectionViewCell = "homeCVCell"
        case CastCollectionViewCell = "castCVCell"
        case FilterTableViewCell = "filterTVCell"
        case FavouriteTableViewCell = "FavouriteTableViewCell"
        case HomeTableViewCell = "HomeTableViewCell"
    }
    
}
