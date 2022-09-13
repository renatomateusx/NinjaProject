//
//  FeedViewController.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import UIKit

class FeedViewController: UICollectionViewController {
    
    //MARK: Properties
    private var loading: UIActivityIndicatorView?
    private var category: Category?
    var viewModel: HomeViewModel! {
        didSet {
            setupObservers()
        }
    }
    var data = Category.allCases {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Helpers
    
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
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        setupLoading()
    }
    
    private func showLoading() {
        DispatchQueue.main.async {
            self.loading?.startAnimating()
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            self.loading?.stopAnimating()
        }
    }
    
    private func setupObservers() {
        viewModel.equipments.bind { [weak self] (_) in
            if let equipments = self?.viewModel.equipments.value {
                self?.viewModel.coordinator.goToCategoriesItems(category: self?.category,
                                                                items: equipments.data,
                                                                viewModel: self?.viewModel)
            }
           
            self?.stopLoading()
        }
        
    }
    
    //MARK: Selectors
    
    @objc func handleRefresh(){
        collectionView.reloadData()
    }
}
//MARK: UICollectionViewDelegate/DataSource
extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier,
                                                      for: indexPath) as! CategoryCell
        cell.configure(data: data)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = data[indexPath.row]
        self.category = category
        self.showLoading()
        viewModel.fetchDataByCategory(category: category)
    }
}

//MARK: UICollectionViewDelegate/FlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let plusHeight: CGFloat = 72
        return CGSize(width: collectionView.bounds.size.width, height: plusHeight)
    }
}
