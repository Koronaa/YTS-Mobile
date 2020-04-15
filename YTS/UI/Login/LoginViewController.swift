//
//  LoginViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginNowButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        UIHelper.addCornerRadius(to: loginNowButton)
        UIHelper.addShadow(to: holderView)
        UIHelper.roundCorners(view: holderView, corners: [.bottomLeft,.bottomRight], radius: 25)
        
        let forgotPasswordTap = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordLabelOnTapped))
        forgotPasswordLabel.addGestureRecognizer(forgotPasswordTap)
    }
    
    
    @IBAction func loginNowButtonOnTapped(_ sender: Any) {
        //Test
        let detailVC = UIHelper.makeViewController(in: UIConstants.StoryBoard.Main, viewControllerName: UIConstants.StoryBoardID.MovieDetailsVC)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func backButtonOnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func forgotPasswordLabelOnTapped(){
        let forgotPasswordVC = UIHelper.makeViewController(viewControllerName: UIConstants.StoryBoardID.ForgetPasswordVC)
        self.navigationController?.pushViewController(forgotPasswordVC, animated: true)
        
    }
}
