//
//  DependencyRegistry.swift
//  Corona
//
//  Created by Sajith Konara on 4/1/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class DependencyRegistryIMPL/*:DependencyRegistry*/{
    
    //    var navigationCoordinator: NavigationCoordinatorIMPL!
    var container:Container
    
    init(container:Container) {
        self.container = container
        
        Container.loggingFunction = nil
        
        registerDependencies()
        registerViewModels()
        registerViewControllers()
    }
    
    
    func registerDependencies(){
        container.register(NetworkLayer.self) { _ in NetworkLayer()}.inObjectScope(.container)
        container.register(TranslationLayer.self){_ in TranslationLayer()}.inObjectScope(.container)
        
        container.register(ModelLayer.self){resolver in
            ModelLayer(networkLayer: resolver.resolve(NetworkLayer.self)!, translationLayer: resolver.resolve(TranslationLayer.self)!)
        }.inObjectScope(.container)
        
        //        container.register(NavigationCoordinatorIMPL.self){(resolver,rootViewController:UIViewController) in
        //            return NavigationCoordinatorIMPL(with: rootViewController, registry: self)
        //        }.inObjectScope(.container)
    }
    
    func registerViewModels(){
        
        container.register(CommonViewModel.self) { resolver in CommonViewModel(modelLayer: resolver.resolve(ModelLayer.self)!)}
        container.register(HomeViewModel.self) { resolver in HomeViewModel(commonViewModel: resolver.resolve(CommonViewModel.self)!)}
        container.register(FavouriteCellViewModel.self) { (resolver,movie:Movie) in FavouriteCellViewModel(movie: movie)}
        container.register(HomeCellViewModel.self) { (resolver,movie:Movie) in HomeCellViewModel(movie: movie)}
        container.register(MovieDetailsViewModel.self) { (resolver,movie:Movie) in MovieDetailsViewModel(modelLayer: resolver.resolve(ModelLayer.self)!, movie: movie)}
        container.register(CastCellViewModel.self) { (reslover, cast:Cast) in CastCellViewModel(cast: cast)}
        container.register(SearchViewModel.self) { resolver in SearchViewModel(modelLayer: resolver.resolve(ModelLayer.self)!)}
        container.register(MovieListViewModel.self) { (resolver, listType:MovieListType) in MovieListViewModel(commonViewModel: resolver.resolve(CommonViewModel.self), movieListType: listType)}
        container.register(TorrentViewViewModel.self) { (reslover,torrent:Torrent) in
            TorrentViewViewModel(torrent: torrent)}
        container.register(DownloadViewModel.self) { (reslover,torrents:[Torrent]) in
            DownloadViewModel(torrents: torrents)
        }
        
        
        
    }
    
    func registerViewControllers(){
        
        container.register(MovieInfoBottomSheetViewController.self) { (resolver,movie:Movie) in
            let movieInfoBottomSheetVC = MovieInfoBottomSheetViewController()
            movieInfoBottomSheetVC.configure(with: resolver.resolve(MovieDetailsViewModel.self, argument: movie)!, downloadVCMaker: self.makeDownloadViewController)
            return movieInfoBottomSheetVC
        }
        
        container.register(DownloadViewController.self) { (resolver,movie:Movie)  in
            let downloadVC = UIHelper.makeViewController(viewControllerName: .DownloadVC) as! DownloadViewController
            downloadVC.configure(with: resolver.resolve(MovieDetailsViewModel.self, argument: movie)!, downloadViewModel: resolver.resolve(DownloadViewModel.self, argument: movie.torrents)!)
            return downloadVC
        }
        
        container.register(MovieListViewController.self) { (resolver,listType:MovieListType) in
            let movieListVC = UIHelper.makeViewController(viewControllerName: .MovieListVC) as! MovieListViewController
            movieListVC.configure(with: resolver.resolve(MovieListViewModel.self, argument: listType)!, homeCollectionViewCellMaker: self.makeHomeCollectionViewCell, movieDetailsVCMaker: self.makeMovieDetailsViewController)
            return movieListVC
        }
        
        container.register(MovieDetailViewController.self) { (resolver,movie:Movie) in
            let movieDetailsVC = UIHelper.makeViewController(viewControllerName: .MovieDetailsVC) as! MovieDetailViewController
            movieDetailsVC.configure(with: resolver.resolve(MovieDetailsViewModel.self, argument: movie)!, movieInfoBottomSheetVCMaker: self.makeMovieInfoBottomSheetViewController)
            return movieDetailsVC
        }
        
        container.register(SearchViewController.self) { (resolver) in
            let searchVC = UIHelper.makeViewController(viewControllerName: .SearchVC) as! SearchViewController
            searchVC.configure(with: resolver.resolve(SearchViewModel.self)!, movieListVCMaker: self.makeMovieListViewController)
            return searchVC
        }
    }
    
    
    //MARK: Maker Methods
    typealias FavouriteCollectionViewCellMaker = (UICollectionView,IndexPath,Movie) -> FavouritesCollectionViewCell
    func makeFavouritesCollectionViewCell(for collectionView:UICollectionView,at indexPath:IndexPath,movie:Movie) -> FavouritesCollectionViewCell{
        let cellViewModel = container.resolve(FavouriteCellViewModel.self, argument: movie)!
        let cell = FavouritesCollectionViewCell.dequeue(from: collectionView, for: indexPath, with: cellViewModel)
        return cell
    }
    
    typealias HomeCollectionViewCellMaker = (UICollectionView,IndexPath,Movie) -> HomeCollectionViewCell
    func makeHomeCollectionViewCell(for collectionView:UICollectionView,at indexPath:IndexPath,movie:Movie) -> HomeCollectionViewCell{
        let cellViewModel = container.resolve(HomeCellViewModel.self, argument: movie)!
        let cell = HomeCollectionViewCell.dequeue(from: collectionView, for: indexPath, with: cellViewModel)
        return cell
    }
    
    typealias FavouriteTableViewCellMaker = (UITableView,IndexPath,HomeCollectionViewDelegate) -> FavouriteTableViewCell
    func makeFavouriteTableViewCell(for tableView:UITableView,
                                    for indexPath:IndexPath,
                                    collectionViewDelgate:HomeCollectionViewDelegate)->FavouriteTableViewCell{
        let cell = FavouriteTableViewCell.dequeue(from: tableView, for: indexPath)
        cell.configure(favouriteCollectionCellMaker: self.makeFavouritesCollectionViewCell, collectionViewDelegate: collectionViewDelgate)
        return cell
    }
    
    typealias HomeTableViewCellMaker = (UITableView,IndexPath,HomeCollectionViewDelegate) -> HomeTableViewCell
    func makeHomeTableViewCell(for tableView:UITableView,
                               for indexPath:IndexPath,
                               collectionViewDelgate:HomeCollectionViewDelegate)->HomeTableViewCell{
        let cell = HomeTableViewCell.dequeue(from: tableView, for: indexPath)
        cell.congifure(homeCollectionViewCellMaker: self.makeHomeCollectionViewCell, collectionViewDelegate: collectionViewDelgate)
        return cell
    }
    
    typealias MovieListViewControllerMaker = (MovieListType,SearchViewModel?) -> MovieListViewController
    func makeMovieListViewController(for movieListType:MovieListType,searchViewModel:SearchViewModel?) -> MovieListViewController{
        let movieListVC = container.resolve(MovieListViewController.self, argument: movieListType)!
        movieListVC.movieListVM.searchViewModel = searchViewModel
        return movieListVC
    }
    
    typealias MovieDetailsViewControllerMaker = (Movie) -> MovieDetailViewController
    func makeMovieDetailsViewController(for movie:Movie) -> MovieDetailViewController{
        return container.resolve(MovieDetailViewController.self, argument: movie)!
    }
    
    typealias SearchViewControllerMaker = () -> SearchViewController
    func makeSearchViewController() -> SearchViewController{
        return container.resolve(SearchViewController.self)!
    }
    
    typealias DownloadViewControllerMaker = (Movie) -> DownloadViewController
    func makeDownloadViewController(for movie:Movie) -> DownloadViewController{
        return container.resolve(DownloadViewController.self, argument: movie)!
    }
    
    typealias MovieInfoBottomSheetViewControllerMaker = (Movie) -> MovieInfoBottomSheetViewController
    func makeMovieInfoBottomSheetViewController(for movie:Movie) -> MovieInfoBottomSheetViewController{
        return container.resolve(MovieInfoBottomSheetViewController.self, argument: movie)!
    }
    
    
}
