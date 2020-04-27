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
    
    var movieDetailsVM:MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCoverImageView.kf.setImage(with: movieDetailsVM.movie.imageURL)
        setupUI()
    }
    
    func setupUI(){
        addBottomSheetView()
    }
    
    func addBottomSheetView(){
        let detailsBottomSheetVC = MovieInfoBottomSheetViewController()
        self.addChild(detailsBottomSheetVC)
        self.view.addSubview(detailsBottomSheetVC.view)
        detailsBottomSheetVC.didMove(toParent: self)
        detailsBottomSheetVC.movieDetailsVM = self.movieDetailsVM
        
        let height = view.frame.height
        let width  = view.frame.width
        detailsBottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
