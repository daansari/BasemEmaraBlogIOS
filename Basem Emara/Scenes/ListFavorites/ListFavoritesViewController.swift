//
//  FavoritesViewController.swift
//  Basem Emara
//
//  Created by Basem Emara on 2018-05-24.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import UIKit
import Shank
import SwiftyPress
import ZamzamUI

class ListFavoritesViewController: UIViewController {
    
    // MARK: - Controls
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(nib: PostTableViewCell.self)
            tableView.contentInset.bottom += 20
        }
    }
    
    @IBOutlet private var emptyPlaceholderView: UIView!
    
    // MARK: - Dependencies
    
    @Inject private var module: ListFavoritesModuleType
    
    private lazy var action: ListFavoritesActionable = module.component(with: self)
    private lazy var router: ListFavoritesRoutable = module.component(with: self)
    
    // MARK: - State
    
    private lazy var tableViewAdapter = PostsDataViewAdapter(
        for: tableView,
        delegate: self
    )
    
    private var removedIDs = [Int]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
}

// MARK: - Setup

private extension ListFavoritesViewController {
    
    func configure() {
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
    }
    
    func loadData() {
        action.fetchFavoritePosts(
            with: ListFavoritesAPI.FetchPostsRequest()
        )
    }
}

// MARK: - Scene

extension ListFavoritesViewController: ListFavoritesDisplayable {
    
    func displayPosts(with viewModels: [PostsDataViewModel]) {
        removedIDs.removeAll()
        tableViewAdapter.reloadData(with: viewModels)
    }
    
    func displayToggleFavorite(with viewModel: ListFavoritesAPI.FavoriteViewModel) {
        removedIDs.append(viewModel.postID)
        
        let isEmpty = tableViewAdapter.viewModels?
            .filter { !removedIDs.contains($0.id) }
            .isEmpty ?? true
        
        // Ensure empty screen to show if empty
        guard isEmpty else { return }
        loadData()
    }
}

// MARK: - Delegates

extension ListFavoritesViewController: PostsDataViewDelegate {
    
    func postsDataViewNumberOfSections(in dataView: DataViewable) -> Int {
        let isEmpty = tableViewAdapter.viewModels?.isEmpty == true
        tableView.backgroundView = isEmpty ? emptyPlaceholderView : nil
        tableView.separatorStyle = isEmpty ? .none : .singleLine
        return 1
    }
    
    func postsDataView(didSelect model: PostsDataViewModel, at indexPath: IndexPath, from dataView: DataViewable) {
        router.showPost(for: model)
    }
    
    func postsDataView(trailingSwipeActionsForModel model: PostsDataViewModel, at indexPath: IndexPath, from tableView: UITableView) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(
            actions: [
                UIContextualAction(style: .destructive, title: .localized(.unfavorTitle)) { _, _, completion in
                    self.action.toggleFavorite(with: ListFavoritesAPI.FavoriteRequest(postID: model.id))
                    completion(true)
                }.with {
                    $0.image = UIImage(named: .favoriteEmpty)
                }
            ]
        )
    }
}

extension ListFavoritesViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
        
        guard let models = tableViewAdapter.viewModels?[indexPath.row] else { return nil }
        return router.previewPost(for: models)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        guard let viewModel = (viewControllerToCommit as? PreviewPostViewController)?.viewModel else { return }
        router.showPost(for: viewModel)
    }
}
