//
//  ItemDetailCell.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 13/09/22.
//

import UIKit
import SDWebImage

class ItemDetailCell: UICollectionViewCell  {
    
    // MARK: Properties
    static let identifier = "ItemDetailCell"
    var data: Equipment?
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.layer.masksToBounds = true
        return categoryImageView
    }()
    
    private let itemHeaderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let itemLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let categoryHeaderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let descriptionHeaderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let commonLocationsHeaderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let commonLocationsLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        
        let stack = UIStackView(arrangedSubviews: [categoryImageView,
                                                   itemHeaderLabel, itemLabel,
                                                   categoryHeaderLabel, categoryLabel,
                                                   descriptionHeaderLabel, descriptionLabel,
                                                   commonLocationsHeaderLabel, commonLocationsLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor,
                             right: rightAnchor, paddingTop: 4,
                             paddingLeft: 12, paddingRight: 12)
        
        categoryImageView.setDimensions(width: 40, height: 300)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Selectors
    
    
    // MARK: Helpers
    
    func configure(data: Equipment){
        self.data = data
        
        
        self.itemHeaderLabel.text = "Name"
        self.categoryHeaderLabel.text = "Category"
        self.descriptionHeaderLabel.text = "Description"
        
        self.commonLocationsHeaderLabel.text = "Common Locations"
        
        
        
        self.itemLabel.text = data.name
        self.categoryLabel.text = data.category.rawValue
        self.descriptionLabel.text = data.equipmentDescription
        
        self.commonLocationsLabel.text = data.commonLocations?.joined(separator: ", ")
        
        if let url = URL(string: data.image) {
            self.categoryImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
