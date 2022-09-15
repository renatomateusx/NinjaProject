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
    var data: NinjaCategory?
    
    private let categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
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
    
    func configure(data: NinjaCategory){
        self.data = data
        self.categoryLabel.text = captalize(data.rawValue)
    }
}


extension UICollectionViewCell {
    func captalize(_ value: String) -> String {
        var output = ""
        
        let phraseArray = value.components(separatedBy: " ")
        for phra in phraseArray {
            var index = 0
            
            for c in phra {
                if index == 0 {
                    output += String(c).uppercased()
                } else {
                    output += String(c)
                }
                index += 1
                
                if index == phra.count {
                    output += " "
                    index = 0
                }
            }
        }
        
        return output
    }
}
