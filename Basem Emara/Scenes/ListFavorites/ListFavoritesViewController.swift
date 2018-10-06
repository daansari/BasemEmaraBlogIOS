//
//  FavoritesViewController.swift
//  Basem Emara
//
//  Created by Basem Emara on 2018-05-24.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import UIKit
import SwiftyPress
import ZamzamKit

class ListFavoritesViewController: UIViewController, HasDependencies {
    
    // MARK: - Controls
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(nib: PostTableViewCell.self)
            tableView.contentInset.bottom += 20
        }
    }
    
    @IBOutlet var emptyPlaceholderView: UIView!
    
    // MARK: - Scene variables
    
    private lazy var interactor: ListFavoritesBusinessLogic = ListFavoritesInteractor(
        presenter: ListFavoritesPresenter(viewController: self),
        postsWorker: dependencies.resolveWorker(),
        mediaWorker: dependencies.resolveWorker()
    )
    
    private lazy var router: ListFavoritesRoutable = ListFavoritesRouter(
        viewController: self
    )
    
    // MARK: - Internal variable
    
    private var viewModels = [PostsDataViewModel]()
    private lazy var tableViewAdapter = PostsDataViewAdapter(
        for: tableView,
        delegate: self
    )
    
    // MARK: - Controller cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
}

// MARK: - Events

private extension ListFavoritesViewController {
    
    func loadData() {
        interactor.fetchFavoritePosts(
            with: ListFavoritesModels.FetchPostsRequest()
        )
    }
}

// MARK: - Scene cycle

extension ListFavoritesViewController: ListFavoritesDisplayable {
    
    func displayPosts(with viewModels: [PostsDataViewModel]) {
        self.viewModels = viewModels
        tableViewAdapter.reloadData(with: viewModels)
    }
}

// MARK: - Delegates

extension ListFavoritesViewController: PostsDataViewDelegate {
    
    func postsDataViewNumberOfSections(in dataView: DataViewable) -> Int {
        tableView.backgroundView = viewModels.isEmpty ? emptyPlaceholderView : nil
        tableView.separatorStyle = viewModels.isEmpty ? .none : .singleLine
        return 1
    }
    
    func postsDataView(didSelect model: PostsDataViewModel, at indexPath: IndexPath, from dataView: DataViewable) {
        router.showPost(for: model)
    }
}
