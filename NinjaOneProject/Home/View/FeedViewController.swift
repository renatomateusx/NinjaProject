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
    private var category: NinjaCategory?
    var viewModel: HomeViewModel! {
        didSet {
            setupObservers()
        }
    }
    var data = NinjaCategory.allCases {
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
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    private func setupObservers() {
        viewModel.equipments.bind { [weak self] (_) in
            if let equipments = self?.viewModel.equipments.value {
                self?.viewModel.coordinator.goToCategoriesItems(category: self?.category,
                                                                items: equipments.data,
                                                                viewModel: self?.viewModel)
            }
        }
        
        viewModel.creatures.bind { [weak self] (_) in
            if let creatures = self?.viewModel.creatures.value {
                self?.viewModel.coordinator.goToCreatureItems(category: self?.category,
                                                                items: creatures,
                                                                viewModel: self?.viewModel)
            }
        }
        
        viewModel.error.bind { [weak self] (_) in
            if let error = self?.viewModel.error.value {
                DispatchQueue.main.async {
                    self?.alert(title: .localized(.oopsTitle), message: error.localizedDescription)
                }
            }
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
        if case NinjaCategory.creatures = category {
            viewModel.fetchItemByCreature(creature: category)
        } else {
            viewModel.fetchDataByCategory(category: category)
        }
    }
}

//MARK: UICollectionViewDelegate/FlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let plusHeight: CGFloat = 72
        return CGSize(width: collectionView.bounds.size.width, height: plusHeight)
    }
}
