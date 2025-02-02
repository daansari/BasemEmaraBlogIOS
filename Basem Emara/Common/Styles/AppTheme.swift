//
//  Theme.swift
//  Basem Emara
//
//  Created by Basem Emara on 2018-09-22.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import UIKit
import SwiftyPress

struct AppTheme: Theme {
    let tint = UIColor(named: "tint") ?? .init(rgb: (49, 169, 234))
    let secondaryTint = UIColor(named: "secondaryTint") ?? .init(rgb: (137, 167, 167))
    
    let backgroundColor = UIColor(named: "backgroundColor") ?? .black
    let secondaryBackgroundColor = UIColor(named: "secondaryBackgroundColor") ?? .init(rgb: (28, 28, 30))
    let tertiaryBackgroundColor = UIColor(named: "tertiaryBackgroundColor") ?? .init(rgb: (44, 44, 46))
    let quaternaryBackgroundColor = UIColor(named: "quaternaryBackgroundColor") ?? .init(rgb: (58, 58, 60))
    
    let separatorColor = UIColor(named: "separatorColor") ?? .darkGray
    let opaqueColor = UIColor(named: "opaqueColor") ?? .lightGray
    
    let labelColor = UIColor(named: "labelColor") ?? .white
    let secondaryLabelColor = UIColor(named: "secondaryLabelColor") ?? .init(rgb: (242, 242, 247))
    let tertiaryLabelColor = UIColor(named: "tertiaryLabelColor") ?? .init(rgb: (229, 229, 234))
    let quaternaryLabelColor = UIColor(named: "quaternaryLabelColor") ?? .init(rgb: (209, 209, 214))
    let placeholderLabelColor = UIColor(named: "placeholderLabelColor") ?? .darkGray
    
    let buttonCornerRadius: CGFloat = 3
    
    let positiveColor = UIColor(named: "positiveColor") ?? .green
    let negativeColor = UIColor(named: "negativeColor") ?? .red
    
    let isDarkStyle: Bool = {
        guard #available(iOS 13.0, *) else { return false }
        return UITraitCollection.current.userInterfaceStyle == .dark
    }()
}
