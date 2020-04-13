//
//  ViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/13/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    func setupUI(){
        UIHelper.hide(navigationController: self.navigationController)
        UIHelper.addCornerRadius(to: loginButton)
        UIHelper.addCornerRadius(to: registerButton, withborder: true, using: UIColor().YTSGreen.cgColor)
    }
    
    @IBAction func RegisterButtonOnTapped(_ sender: UIButton) {
        let registerVC = UIHelper.makeViewController(viewControllerName: .RegisterVC)
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    @IBAction func LoginButtonOnTapped(_ sender: UIButton) {
        let loginVC = UIHelper.makeViewController(viewControllerName: .LoginVC)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}

