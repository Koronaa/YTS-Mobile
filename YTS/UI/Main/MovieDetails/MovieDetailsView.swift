//
//  MovieDetails.swift
//  YTS
//
//  Created by Sajith Konara on 4/15/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

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
    }
    
    
    private func commonInit(){
        Bundle.main.loadNibNamed("MovieDetailsView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //FIXME: Figure out a way to get the content size
        contentViewBottomConstraint.constant = (UIScreen.main.bounds.height/3)
        setupUI()
    }
}
