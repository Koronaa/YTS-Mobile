//
//  ResetPasswordViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        UIHelper.addCornerRadius(to: resetPasswordButton)
        UIHelper.addShadow(to: holderView)
        UIHelper.roundCorners(view: holderView, corners: [.bottomLeft,.bottomRight], radius: 25)
    }
    
    
    @IBAction func backButtonOnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
