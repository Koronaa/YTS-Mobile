//
//  SearchViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/16/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterTapBar: UITabBar!
    @IBOutlet weak var filerHolderView: UIView!
    @IBOutlet weak var clearFiltersButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var qualityTapBarItem: UITabBarItem!
    @IBOutlet weak var genreTapBarItem: UITabBarItem!
    @IBOutlet weak var ratingTapBarItem: UITabBarItem!
    @IBOutlet weak var orderByTapBarItem: UITabBarItem!
    
    var currenFilter:[Filter] = []
    var genreFilter:[Filter] = [],qualityFilter:[Filter] = [],ratingFilter:[Filter] = [],orderByFilter:[Filter] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFilters()
        tableView.register(UINib(nibName: "FiltersTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstants.Cell.FilterTableViewCell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        filterTapBar.delegate = self
        
    }
    
    private func setupFilters(){
        qualityFilter = Filter.generateFilter(for: .Quality)
        genreFilter = Filter.generateFilter(for: .Genre)
        ratingFilter = Filter.generateFilter(for: .Rating)
        orderByFilter = Filter.generateFilter(for: .OrderBy)
        currenFilter = qualityFilter
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
        
    }
    
    @IBAction func clearFiltersButtonOnTapped(_ sender: Any) {
        setupFilters()
        filterTapBar.selectedItem = qualityTapBarItem
        tableView.reloadData()
    }
    
    @IBAction func searchButtonOnTapped(_ sender: Any) {
        let movieListVC = UIHelper.makeViewController(in: .Main, viewControllerName: .MovieListVC)
        self.navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    @IBAction func closeButtonOnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        filterTapBar.selectedItem = qualityTapBarItem
        UIHelper.addCornerRadius(to: searchButton)
        UIHelper.addCornerRadius(to: clearFiltersButton, withborder: true, using: UIColor().YTSGreen.cgColor)
        UIHelper.roundCorners(view: filerHolderView, corners: [.topLeft,.topRight], radius: 25)
        filterTapBar.tintColor = UIColor().YTSGreen
        
    }
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedFilter = currenFilter[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.FilterTableViewCell.rawValue, for: indexPath) as! FiltersTableViewCell
        cell.filter = selectedFilter
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFilter = currenFilter[indexPath.row]
        for filter in currenFilter{
            if selectedFilter == filter{
                filter.isSelected = true
            }else{
                filter.isSelected = false
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension SearchViewController:UITabBarDelegate{
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        filterTapBar.selectedItem = item
        switch item {
        case qualityTapBarItem:
            currenFilter = qualityFilter
        case genreTapBarItem:
            currenFilter = genreFilter
        case ratingTapBarItem:
            currenFilter = ratingFilter
        case orderByTapBarItem:
            currenFilter = orderByFilter
        default:()
        }
        self.tableView.reloadData()
    }
    
}
