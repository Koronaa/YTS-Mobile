//
//  MovieDetailViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/15/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Kingfisher


class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieCoverImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var movieDetailsVM:MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCoverImageView.kf.setImage(with: movieDetailsVM.movie.imageURL)
        setupUI()
    }
    
    func setupUI(){
        UIHelper.addCornerRadius(to: backButton)
        addBottomSheetView()
    }
    
    func addBottomSheetView(){
        let detailsBottomSheetVC = MovieInfoBottomSheetViewController()
        detailsBottomSheetVC.movieDetailsVM = self.movieDetailsVM
        self.addChild(detailsBottomSheetVC)
        self.view.addSubview(detailsBottomSheetVC.view)
        detailsBottomSheetVC.didMove(toParent: self)
        
        
        let height = view.frame.height
        let width  = view.frame.width
        detailsBottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
