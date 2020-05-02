//
//  MovieDetails.swift
//  YTS
//
//  Created by Sajith Konara on 4/15/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Cosmos

protocol MovieDetailsDelegate {
    func downloadButtonOnTapped(for movieDetailsVM:MovieDetailsViewModel)
    func shareButtonOnTapped(for movieDetailsVM:MovieDetailsViewModel)
}

class MovieDetailsView: UIView {
    
    @IBOutlet weak var noCastInfoLabel: UILabel!
    @IBOutlet weak var castHeaderLabel: UILabel!
    @IBOutlet weak var synopsisHeaderLabel: UILabel!
    @IBOutlet weak var availableInHeaderLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var availableInLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    var movieDetailsVM:MovieDetailsViewModel!
    var movieDetailsDelegate:MovieDetailsDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupRatingView()
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
//                print("NO youtube link")
                //ERROR
            }
        }else{
//            print("NO youtube link")
        }
        
    }
    
    @IBAction func downloadButtonOnTapped(_ sender: Any) {
        movieDetailsDelegate.downloadButtonOnTapped(for: movieDetailsVM)
    }
    
    @IBAction func shareButtonOnTapped(_ sender: Any) {
        movieDetailsDelegate.shareButtonOnTapped(for: movieDetailsVM)
    }
    
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: watchTrailerButton)
        UIHelper.addCornerRadius(to: downloadButton)
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.CastCollectionViewCell.rawValue)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupRatingView()
        
        switch DeviceManager.getDeviceType() {
        case .iPhone_5_5s_5C_SE:
            bottomViewConstraint.constant = 75
            ratingView.settings.starSize = 20
        case .iPhone_6_6s_7_8:
            bottomViewConstraint.constant = 110
        case .iPhone_6Plus_6sPlus_7Plus_8Plus:
            bottomViewConstraint.constant = 130
        case .iPhone_X_Xs_11Pro:
            bottomViewConstraint.constant = 170
        case .iPhone_Xr_11:
            bottomViewConstraint.constant = 200
        case .iPhone_XsMax_11ProMax:
            bottomViewConstraint.constant = 200
        default:
            bottomViewConstraint.constant = 200
        }
        
        if #available(iOS 13.0, *) {
            //Storyboard will handle this
        }else{
            downloadButton.setImage(UIImage(named: "download"), for: .normal)
            watchTrailerButton.setImage(UIImage(named: "play"), for: .normal)
            shareButton.setImage(UIImage(named: "share"), for: .normal)
        }
    }
    
    private func setupRatingView(){
        if #available(iOS 13.0, *) {
            ratingView.settings.filledColor = .label
            ratingView.settings.emptyBorderColor = .label
            ratingView.settings.filledBorderColor = .label
            ratingView.settings.textColor = .label
        } else {
            ratingView.settings.filledColor = .black
            ratingView.settings.emptyBorderColor = .black
            ratingView.settings.filledBorderColor = .black
            ratingView.settings.textColor = .black
        }
        ratingView.settings.textFont = UIFont(name: "Avenir-Medium", size: 18)!
        
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
        
        UIHelper.addShadow(to: availableInHeaderLabel)
        UIHelper.addCornerRadius(to: availableInHeaderLabel)
        availableInHeaderLabel.layer.masksToBounds = true
        
        UIHelper.addShadow(to: synopsisHeaderLabel)
        UIHelper.addCornerRadius(to: synopsisHeaderLabel)
        synopsisHeaderLabel.layer.masksToBounds = true
        
        UIHelper.addShadow(to: castHeaderLabel)
        UIHelper.addCornerRadius(to: castHeaderLabel)
        castHeaderLabel.layer.masksToBounds = true
        
        movieDetailsVM.getCast {
            self.collectionView.reloadData()
            if self.movieDetailsVM.cast.count == 0{
                self.collectionView.isHidden = true
            }else{
                self.collectionView.isHidden = false
            }
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
