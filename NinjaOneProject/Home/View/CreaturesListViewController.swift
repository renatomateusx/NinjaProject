//
//  CreaturesListViewController.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 14/09/22.
//

import UIKit

class CreaturesListViewController: UICollectionViewController {
    
    //MARK: Properties
    private var loading: UIActivityIndicatorView?
    
    var viewModel: HomeViewModel! {
        didSet {
            setupObservers()
        }
    }
    
    var data: Creatures? {
        didSet {
            self.collectionView.reloadData()
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
        loading?.color = UIColor.red
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
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
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
        viewModel.equipment.bind { [weak self] (_) in
            if let equipment = self?.viewModel.equipment.value {
                self?.viewModel.coordinator.goToItemDetail(item: equipment.data)
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
extension CreaturesListViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? data?.food?.count ?? 0 : data?.nonFood?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = indexPath.section == 0 ? data?.food?[indexPath.row] : data?.nonFood?[indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier,
                                                      for: indexPath) as! ItemCell
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = indexPath.section == 0 ? data?.food?[indexPath.row] : data?.nonFood?[indexPath.row] {
            self.showLoading()
            self.viewModel.fetchById(id: item.id)
        }
    }
}

//MARK: UICollectionViewDelegate/FlowLayout
extension CreaturesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let plusHeight: CGFloat = 400
        return CGSize(width: collectionView.bounds.size.width, height: plusHeight)
    }
}


