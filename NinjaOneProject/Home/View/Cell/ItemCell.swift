//
//  ItemCell.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 13/09/22.
//

import UIKit
import SDWebImage

class ItemCell: UICollectionViewCell  {
    
    // MARK: Properties
    static let identifier = "ItemCell"
    var data: Equipment?
    
    private lazy var categoryImageView: UIImageView = {
        let categoryImageView = UIImageView()
        categoryImageView.layer.masksToBounds = true
        categoryImageView.image = UIImage(named: "placeholder")
        return categoryImageView
    }()
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        
        let stack = UIStackView(arrangedSubviews: [categoryImageView, categoryLabel])
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
        self.categoryLabel.text = captalize(data.name)
        if let url = URL(string: data.image) {
            self.categoryImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
