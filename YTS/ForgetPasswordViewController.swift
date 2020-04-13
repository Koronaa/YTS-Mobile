//
//  ForgetPasswordViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var sendResetCodeButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        UIHelper.addCornerRadius(to: sendResetCodeButton)
        UIHelper.addShadow(to: holderView)
        UIHelper.roundCorners(view: holderView, corners: [.bottomLeft,.bottomRight], radius: 25)
    }
    
    
    @IBAction func backButtonOnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendResetPasswordCodeButtonOnTapped(_ sender: UIButton) {
        
        let resetPasswordVC = UIHelper.makeViewController(viewControllerName: UIConstants.StoryBoardID.ResetPasswordVC)
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
}
