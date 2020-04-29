//
//  HomeViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: "FavouriteTableViewCell")
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        searchTextField.delegate = self
}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        UIHelper.hide(navigationController: self.navigationController)
        UIHelper.roundCorners(view: bottomView, corners: [.topLeft,.topRight], radius: 25)
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
            cell.collectionViewDelegate = self
            cell.section = indexPath.section
            return cell
        case 1,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            cell.section = indexPath.section
            cell.collectionViewDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Latest Uploads"
        case 1:
            return "Pupular Downloads"
        case 2:
            return "Top Rated Movies"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 5, y: 1, width: 320, height: 20)
        myLabel.font = UIFont(name: "Avenir-Heavy", size: 18)
        myLabel.isSkeletonable = true
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let seeMoreButton = UIButton()
        seeMoreButton.setTitle("See more", for: .normal)
        seeMoreButton.tag = section
        seeMoreButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        seeMoreButton.titleColor(for: .normal)
        if #available(iOS 13.0, *) {
            seeMoreButton.titleLabel?.textColor = UIColor.label
        } else {
            seeMoreButton.titleLabel?.textColor = .black
        }
        seeMoreButton.frame = CGRect(x: self.view.frame.width - 125, y: 1, width: 120, height: 20)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        let headerView = UIView()
        if #available(iOS 13.0, *) {
            headerView.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
        }
        
        headerView.addSubview(seeMoreButton)
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 320.0
        case 1:
            return 385.0
        case 2:
            return 385.0
        default:()
        }
        return 120.0
    }
    
    
    @objc func seeMoreButtonTapped(sender:UIButton){
        let movieListVC = UIHelper.makeViewController(in: .Main, viewControllerName: .MovieListVC) as! MovieListViewController
        switch sender.tag {
        case 0:
            movieListVC.type = .LATEST
        case 1:
            movieListVC.type = .POPULAR
        case 2:
            movieListVC.type = .RATED
        default:()
        }
        self.navigationController?.pushViewController(movieListVC, animated: true)
        
    }
}

extension HomeViewController:UITextFieldDelegate,HomeCollectionViewDelegate{
    
    func didSelectItem(for movie: Movie) {
        let movieDetailsVM = MovieDetailsViewModel(movie: movie)
        let movieDetailsVC = UIHelper.makeViewController(in: .Main, viewControllerName: .MovieDetailsVC) as! MovieDetailViewController
        movieDetailsVC.movieDetailsVM = movieDetailsVM
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        let searchVC = UIHelper.makeViewController(in: .Main, viewControllerName: .SearchVC)
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
}


