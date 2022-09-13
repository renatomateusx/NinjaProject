//
//  DetailItemViewController.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 13/09/22.
//

import UIKit

class DetailItemViewController: UICollectionViewController {
    
    //MARK: Properties
    private var loading: UIActivityIndicatorView?
    
    var data: Equipments? {
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
        collectionView.register(ItemDetailCell.self, forCellWithReuseIdentifier: ItemDetailCell.identifier)
        
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
    
    //MARK: Selectors
    
    @objc func handleRefresh(){
        collectionView.reloadData()
    }
}
//MARK: UICollectionViewDelegate/DataSource
extension DetailItemViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = data?[indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailCell.identifier,
                                                      for: indexPath) as! ItemDetailCell
            cell.configure(data: data)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

//MARK: UICollectionViewDelegate/FlowLayout
extension DetailItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let plusHeight: CGFloat = 400
        return CGSize(width: collectionView.bounds.size.width, height: plusHeight)
    }
}

