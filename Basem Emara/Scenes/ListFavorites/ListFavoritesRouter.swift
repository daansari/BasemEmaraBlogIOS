//
//  ListFavoritesRouter.swift
//  Basem Emara
//
//  Created by Basem Emara on 2018-10-06.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import UIKit

struct ListFavoritesRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension ListFavoritesRouter: ListFavoritesRoutable {
    
    func showPost(for model: PostsDataViewModel) {
        show(storyboard: .showPost) { (controller: ShowPostViewController) in
            controller.postID = model.id
        }
    }
}
