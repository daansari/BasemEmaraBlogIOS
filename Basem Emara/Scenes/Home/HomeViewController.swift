//
//  HomeViewController.swift
//  Basem Emara
//
//  Created by Basem Emara on 2019-05-20.
//  Copyright © 2019 Zamzam Inc. All rights reserved.
//

import UIKit
import SwiftyPress
import ZamzamKit

class HomeViewController: UITableViewController, HasDependencies {
    
    // MARK: - Controls
    
    @IBOutlet private var headerView: UIView!
    
    // MARK: - Scene variables
    
    private lazy var router: HomeRoutable = HomeRouter(
        viewController: self,
        listPostsDelegate: splitViewController as? MainSplitViewController,
        mailComposer: dependencies.resolve(),
        constants: dependencies.resolve(),
        theme: dependencies.resolve()
    )
    
    // MARK: - Internal variable
    
    private lazy var constants: ConstantsType = dependencies.resolve()
    private lazy var theme: Theme = dependencies.resolve()
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme.statusBarStyle
    }
}

// MARK: - Events

private extension HomeViewController {
    
    func configure() {
        tableView.tableHeaderView = headerView
    }
}

// MARK: - Interactions

private extension HomeViewController {
    
    @IBAction func socialButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            router.showSocial(for: .github)
        case 2:
            router.showSocial(for: .linkedIn)
        case 3:
            router.showSocial(for: .twitter)
        case 4:
            router.sendEmail(
                subject: .localizedFormat(
                    .emailFeedbackSubject,
                    constants.appDisplayName ?? ""
                )
            )
        default:
            break
        }
    }
}

// MARK: - Scene cycle

extension HomeViewController: HomeDisplayable {
    
}

// MARK: - Nested types

extension HomeViewController: CellIdentifiable {
    
    enum CellIdentifier: String {
        case about
        case portfolio
        case seriesScalableApp
        case seriesSwiftUtilities
        case coursesArchitecture
        case coursesFramework
        case consultingDevelopment
        case consultingMentorship
    }
}

// MARK: - Delegates

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath),
            let identifier = CellIdentifier(from: cell) else {
                return
        }
        
        switch identifier {
        case .about:
            router.showAbout()
        case .portfolio:
            router.showPortfolio()
        case .seriesScalableApp:
            router.showSeriesScalableApp(
                title: cell.textLabel?.text
            )
        case .seriesSwiftUtilities:
            router.showSeriesSwiftUtilities(
                title: cell.textLabel?.text
            )
        case .coursesArchitecture:
            router.showCoursesArchitecture()
        case .coursesFramework:
            router.showCoursesFramework()
        case .consultingDevelopment:
            router.showConsultingDevelopment()
        case .consultingMentorship:
            router.showConsultingMentorship()
        }
    }
}
