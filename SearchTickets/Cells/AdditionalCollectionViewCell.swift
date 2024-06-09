//
//  AdditionalCollectionViewCell.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 09.06.2024.
//

import UIKit

class AdditionalCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "AdditionalCell"
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    let filterIcon = UIImageView()
    
    func configure(icon: String, label: String) {
        filterLabel.text = label
        filterIcon.image = UIImage(named: icon)
        
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hex: "#2F3035")
        self.layer.cornerRadius = 8
        
        [filterIcon, filterLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            filterIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            filterIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            filterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: filterIcon.trailingAnchor, constant: 10)
        ])
    }
}
