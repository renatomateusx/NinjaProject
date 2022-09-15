//
//  HomeViewController.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import UIKit

class HomeViewController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Private Properties
    
    private var loading: UIActivityIndicatorView?
    var viewModel: HomeViewModel! {
        didSet {
            setupView()
            setupObserver()
            setupData()
        }
    }
    var data: DataClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: SetupView
extension HomeViewController {
    private func setupView() {
        
        view.backgroundColor = .systemBackground
        self.delegate = self
        
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        feed.viewModel = self.viewModel
        let nav1 = setTemplateNavController(image: "home_unselected", rootViewController: feed)
        viewControllers = [nav1]
        
        setupLoading()
    }
    
    private func setTemplateNavController(image: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(named: image)
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    private func setupLoading() {
        loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loading?.color = UIColor.white
        loading?.translatesAutoresizingMaskIntoConstraints = false
        if let loading = loading {
            self.view.addSubview(loading)
            loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loading?.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loading?.stopAnimating()
        }
    }
    
    private func setupData() {
        viewModel.fetchData(0)
    }
    
    private func showDataRetrieved(data: DataClass) {
        self.data = data
    }
}

// MARK: SetupData
extension HomeViewController {
    
    private func setupObserver() {
        viewModel.monsters.bind { [weak self] (_) in
            if let monsters = self?.viewModel.monsters.value {
                self?.showDataRetrieved(data: monsters)
            }
           
            self?.stopLoading()
        }
        
        viewModel.error.bind { [weak self] (_) in
            if let error = self?.viewModel.error.value {
                DispatchQueue.main.async {
                    self?.alert(title: .localized(.oopsTitle), message: error.localizedDescription)
                    
                }
            }
            self?.stopLoading()
        }
    }
}
