//
//  SimplePostTableViewCell.swift
//  Basem Emara
//
//  Created by Basem Emara on 2018-10-07.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import UIKit

class SimplePostTableViewCell: UITableViewCell, PostsDataViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var featuredImage: UIImageView!
}

extension SimplePostTableViewCell {
    
    func bind(_ model: PostsDataViewModel) {
        titleLabel.text = model.title
        featuredImage.setImage(from: model.imageURL)
    }
}
