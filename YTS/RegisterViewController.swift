//
//  RegisterViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var registerNowButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        UIHelper.addCornerRadius(to: registerNowButton)
        UIHelper.addShadow(to: holderView)
        UIHelper.roundCorners(view: holderView, corners: [.bottomLeft,.bottomRight], radius: 25)
    }
    
    
    @IBAction func registerNowButtonOnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func backButtonOnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
