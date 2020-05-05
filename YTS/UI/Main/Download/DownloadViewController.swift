//
//  DownloadViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    
    @IBOutlet weak var closeButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var carouselHolderView: CorouselView!
    
    fileprivate var movieDetailsVM:MovieDetailsViewModel!
    fileprivate var downloadViewModel:DownloadViewModel!
    
    
    func configure(with movieDetailsVM:MovieDetailsViewModel,downloadViewModel:DownloadViewModel){
        self.movieDetailsVM = movieDetailsVM
        self.downloadViewModel = downloadViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselHolderView.configure(downloadVM: self.downloadViewModel, carousalViewDelegate: self)
        carouselHolderView.setupUI()
        setupUI()
    }
    
    private func setupUI(){
        if #available(iOS 13, *){
            closeButtonTopConstraint.constant = 20
        }
        UIHelper.circular(view: closeButton)
    }
    
    
    
    @IBAction func closeButtonOnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension DownloadViewController:CorouselViewDelegate{
    func onDownloadButtonClicked(for torrentViewModel: TorrentViewViewModel) {
        let code = "Here's YTS \(torrentViewModel.torrent.quality).\(torrentViewModel.torrent.type) torrent download link for the movie '\(movieDetailsVM.title)'. Enjoy! \n \n \(torrentViewModel.torrent.downloadURL.absoluteString)"
        let textToShare = [code]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
