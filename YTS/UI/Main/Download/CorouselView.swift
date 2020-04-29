//
//  CorousalView.swift
//  YTS
//
//  Created by Sajith Konara on 4/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

protocol CorouselViewDelegate {
    func onDownloadButtonClicked(for torrentViewModel: TorrentViewViewModel)
}

class CorouselView: UIView {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var carouselView: iCarousel!
    
    var carousalViewDelegate:CorouselViewDelegate!
    var downloadVM:DownloadViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setupUI(){
        Bundle.main.loadNibNamed("CarouselView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        carouselView.dataSource = self
        carouselView.type = .rotary
    }
}

extension CorouselView:iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return downloadVM.torrents.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let torrent = downloadVM.torrents[index]
        let torrentViewVM = TorrentViewViewModel(torrent: torrent)
        let torrentView = Bundle.main.loadNibNamed("TorrentView", owner: self, options: nil)!.first as! TorrentView
        torrentView.torrentViewVM = torrentViewVM
        torrentView.torrentViewDelegate = self
        return torrentView
    }
}

extension CorouselView:TorrentViewDelegate{
    func downloadButtonOnTapped(for torrentViewModel: TorrentViewViewModel) {
        carousalViewDelegate.onDownloadButtonClicked(for: torrentViewModel)
    }
}
