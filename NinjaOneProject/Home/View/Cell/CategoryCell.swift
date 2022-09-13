//
//  CategoryCell.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import UIKit

class CategoryCell: UICollectionViewCell  {
    
    // MARK: Properties
    static let identifier = "CategoryCell"
    var data: Category?
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, left: leftAnchor,
                             right: rightAnchor, paddingTop: 4,
                             paddingLeft: 12, paddingRight: 12,
                             height: 48)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    
    // MARK: Helpers
    
    func configure(data: Category){
        self.data = data
        self.categoryLabel.text = data.rawValue
    }
}
