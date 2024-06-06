//
//  RecTableViewCell.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 06.06.2024.
//

import UIKit

class RecTableViewCell: UITableViewCell {
    static let identifier: String = "RecommendedCell"
    
    let countryImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let constLabel: UILabel = {
        let label = UILabel()
        label.text = "Популярное направление"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(country: String) {
        countryImage.image = UIImage(named: country)
        countryLabel.text = country
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hex: "#2F3035")
        [countryImage, countryLabel, constLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            countryImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            countryImage.heightAnchor.constraint(equalToConstant: 40),
            countryImage.widthAnchor.constraint(equalToConstant: 40),
            
            countryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 15),
            
            constLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 5),
            constLabel.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 15)
        ])
    }

}
