//
//  DownloadViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    
    
    var movieDetailsVM:MovieDetailsViewModel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var carouselHolderView: CorouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselHolderView.downloadVM = DownloadViewModel(torrents: movieDetailsVM.movie.torrents)
        carouselHolderView.carousalViewDelegate = self
        carouselHolderView.setupUI()
        setupUI()
    }
    
    private func setupUI(){
        UIHelper.circular(view: closeButton)
    }
    
    
    
    @IBAction func closeButtonOnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension DownloadViewController:CorouselViewDelegate{
    func onDownloadButtonClicked(for torrentViewModel: TorrentViewViewModel) {
        let code = "Here's YTS \(torrentViewModel.torrent.quality).\(torrentViewModel.torrent.type) torrent download link for the movie '\(movieDetailsVM.movie.title)'. Enjoy! \n \n \(torrentViewModel.torrent.downloadURL.absoluteString)"
        let textToShare = [code]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
