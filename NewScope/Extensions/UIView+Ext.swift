//
//  UIView+Ext.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }

}
