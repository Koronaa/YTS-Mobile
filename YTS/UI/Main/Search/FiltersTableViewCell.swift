//
//  FiltersTableViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/17/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    
    var filter:Filter!{
        didSet{
            setupCell()
            filterNameLabel.text = filter.name
            selectedImageView.isHidden = !filter.isSelected
        }
    }
    

    
    private func setupCell(){
        UIHelper.addCornerRadius(to: holderView)
    }
}
