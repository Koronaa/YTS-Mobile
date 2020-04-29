//
//  TorrentView.swift
//  YTS
//
//  Created by Sajith Konara on 4/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Kingfisher

protocol TorrentViewDelegate {
    func downloadButtonOnTapped(for torrentViewModel:TorrentViewViewModel)
}

class TorrentView: UIView {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var torrentViewDelegate:TorrentViewDelegate!
    
    var torrentViewVM:TorrentViewViewModel!{
        didSet{
            setupUI()
            titleLabel.text = "\(torrentViewVM.torrent.quality) \(torrentViewVM.torrent.type)"
            sizeLabel.text = torrentViewVM.torrent.size
            movieImageView.kf.setImage(with: torrentViewVM.torrent.posterURL)
            print(torrentViewVM.torrent.posterURL)
        }
    }
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: holderView, withRadius: 25)
        UIHelper.addCornerRadius(to: movieImageView, withRadius: 25)
        UIHelper.addCornerRadius(to: downloadButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func downloadButtonOnTapped(_ sender: Any) {
        torrentViewDelegate.downloadButtonOnTapped(for: torrentViewVM)
    }
}
