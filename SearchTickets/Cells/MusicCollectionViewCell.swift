//
//  MusicCollectionViewCell.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 05.06.2024.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MusicCell"
    
    let singerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    let icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "airplane")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [singerImage, nameLabel,countryLabel, priceLabel, icon].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            singerImage.topAnchor.constraint(equalTo: self.topAnchor),
            singerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            singerImage.heightAnchor.constraint(equalToConstant: 133.16),
            singerImage.widthAnchor.constraint(equalToConstant: 132),
            
            nameLabel.topAnchor.constraint(equalTo: singerImage.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            countryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            icon.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 5),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            
            priceLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 2)
        ])
        
    }
    
    func configure(imageID: Int, singer: String, country: String, price: Int){
        singerImage.image = UIImage(named: "\(imageID)")
        nameLabel.text = singer
        countryLabel.text = country
        priceLabel.text = "от \(price) ₽"
    }
}
