//
//  MovieInfoBottomSheetViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/15/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class MovieInfoBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dragView: UIView!
    @IBOutlet weak var movieDetailsView: MovieDetailsView!
    
    var count:Int!
    var movieDetailsVM:MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView.movieDetailsDelegate = self
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        backgroundView.addGestureRecognizer(gesture)
        count = 0
        print("Bottom sheet height = \(self.view.frame.height)")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if count == 0{
            setupUI()
            self.moveView(state: .Partial)
            count += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        movieDetailsView.setupData()
    }
    
    private func setupUI(){
        movieDetailsView.movieDetailsVM = self.movieDetailsVM
        UIHelper.roundCorners(view: backgroundView, corners: [.topLeft,.topRight], radius: 25)
        UIHelper.addCornerRadius(to: dragView,withRadius: 2.5)
    }
    
    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY
        
        if (minY + translation.y >= Constant.fullViewYPosition) && (minY + translation.y <= Constant.partialViewYPosition) {
            view.frame = CGRect(x: 0, y: minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    private func moveView(state: State) {
        let yPosition = state == .Partial ? Constant.partialViewYPosition : Constant.fullViewYPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations: {
                let state: State = recognizer.velocity(in: self.view).y >= 0 ? .Partial : .Full
                self.moveView(state: state)
            }, completion: nil)
        }
    }
}

extension MovieInfoBottomSheetViewController{
    
    private enum State{
        case Partial
        case Full
    }
    
    private enum Constant{
        static let fullViewYPosition:CGFloat = UIScreen.main.bounds.height/3 - 100
        static var partialViewYPosition:CGFloat { (UIScreen.main.bounds.height/3)*2 - 100}
    }
}

extension MovieInfoBottomSheetViewController:MovieDetailsDelegate{
    
    func downloadButtonOnTapped(for movieDetailsVM: MovieDetailsViewModel) {
        let downloadVC = UIHelper.makeViewController(in: .Main, viewControllerName: .DownloadVC) as! DownloadViewController
        downloadVC.movieDetailsVM = movieDetailsVM
        downloadVC.modalPresentationStyle = .overFullScreen
        self.present(downloadVC, animated: true, completion: nil)
    }
    
    func shareButtonOnTapped(for movieDetailsVM: MovieDetailsViewModel) {
        let code = "Here's the YTS link for the movie '\(movieDetailsVM.movie.title)'. Enjoy! \n \n \(movieDetailsVM.movie.ytsPageURL)"
        let textToShare = [code]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}




