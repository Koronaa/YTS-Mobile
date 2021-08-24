//
//  UITableViewCell+Extensions.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-24.
//

import UIKit

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
