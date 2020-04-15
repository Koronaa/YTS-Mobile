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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCoverImageView.kf.setImage(with: URL(string: "https://yts.mx/assets/images/movies/batman_hush_2019/large-cover.jpg"))
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
        
        let height = view.frame.height
        let width  = view.frame.width
        detailsBottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }
    
    
    
    
}
