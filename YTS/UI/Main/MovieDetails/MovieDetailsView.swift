//
//  MovieDetails.swift
//  YTS
//
//  Created by Sajith Konara on 4/15/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var watchLaterButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: watchLaterButton)
        UIHelper.addCornerRadius(to: downloadButton)
        
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.castCollectionViewCell.rawValue)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func commonInit(){
        Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
      
        print("Constraint height = \(UIScreen.main.bounds.height - self.frame.height + 20)")
        
        //FIXME: Hanlde iPhone 8,SE & iPads
        contentViewBottomConstraint.constant =  self.frame.height - UIScreen.main.bounds.height/2
        setupUI()
    }
}


extension MovieDetailsView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.castCollectionViewCell.rawValue, for: indexPath) as! CastCollectionViewCell
        cell.configure()
        return cell
    }
    
    
}
