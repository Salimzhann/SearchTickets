//
//  CustomButton.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 05.06.2024.
//

import Foundation
import UIKit
class CustomButton: UIButton {

    private let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hex: "#2F3035")
            view.layer.cornerRadius = 16
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowRadius = 8
            return view
    }()
    
    private let subContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#3E3F43")
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        return view
    }()
    private let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.tintColor = .lightGray
        return imageView
    }()

    private let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "Минск"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let line: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "line")
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let toLabel: UILabel = {
        let label = UILabel()
        label.text = "Куда - Турция"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        [containerView,subContainer,searchIcon,fromLabel,toLabel, line].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            subContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            subContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            subContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            subContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            searchIcon.leadingAnchor.constraint(equalTo: subContainer.leadingAnchor, constant: 16),
            searchIcon.centerYAnchor.constraint(equalTo: subContainer.centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 24),
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            
            fromLabel.topAnchor.constraint(equalTo: subContainer.topAnchor, constant: 16),
            fromLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 16),
            
            line.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 5),
            line.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: subContainer.trailingAnchor, constant: -48),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            toLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            toLabel.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 16)
            
        ])
    }
}


