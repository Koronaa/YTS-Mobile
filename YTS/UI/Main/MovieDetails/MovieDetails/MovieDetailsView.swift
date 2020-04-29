//
//  MovieDetails.swift
//  YTS
//
//  Created by Sajith Konara on 4/15/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Cosmos

class MovieDetailsView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var watchLaterButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var availableInLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movieDetailsVM:MovieDetailsViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @IBAction func trailerButtonOnTapped(_ sender: UIButton) {
        if let trailerCode = movieDetailsVM.movie.youtubeTrailerCode{
            if trailerCode != "" {
                var url = URL(string: "youtube://"+trailerCode)
                if !UIApplication.shared.canOpenURL(url!){
                    url = URL(string:"http://www.youtube.com/watch?v="+trailerCode)!
                }
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }else{
                print("NO youtube link")
                //ERROR
            }
        }else{
            print("NO youtube link")
        }
        
    }
    
    @IBAction func downloadButtonOnTapped(_ sender: Any) {
        //TODO
    }
    
    @IBAction func shareButtonOnTapped(_ sender: Any) {
        
        //TODO
            let code = "Here's the yts link for the movie \(movieDetailsVM.movie.title). Enjoy! \t \t \(movieDetailsVM.movie.ytsPageURL)"
            let textToShare = [code]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self
//            self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: watchLaterButton)
        UIHelper.addCornerRadius(to: downloadButton)
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.CastCollectionViewCell.rawValue)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupData(){
        titleLabel.text = movieDetailsVM.title
        yearLabel.text = movieDetailsVM.year
        genreLabel.text = movieDetailsVM.genre
        ratingView.rating = movieDetailsVM.rating
        ratingView.text = movieDetailsVM.rating.description
        shortDescriptionLabel.text = movieDetailsVM.shortDescription
        availableInLabel.text = movieDetailsVM.availableIn
        synopsisLabel.text = movieDetailsVM.synopsis
        
        movieDetailsVM.getCast {
            self.collectionView.reloadData()
        }
    }
    

    
    
    
    private func commonInit(){
        Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        setupUI()
    }
}


extension MovieDetailsView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailsVM.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cast = movieDetailsVM.cast[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.CastCollectionViewCell.rawValue, for: indexPath) as! CastCollectionViewCell
        cell.castCellViewModel = CastCellViewModel(cast: cast)
        return cell
    }
    
    
}
