//
//  SearchViewController.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 05.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#2F3035")
        view.layer.cornerRadius = 16
        return view
    }()
    
    let rectangleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "closeRectangel")
        return image
    }()
    
    let lineImage: UIImageView = CustomButton().line
    let airplaneImage: UIImageView = MusicCollectionViewCell().icon
    let searchImage: UIImageView = CustomButton().searchIcon
    
    let fromTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Минск"
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white ])
        return tf
    }()
    
    let toTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Куда - Турция"
        tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray ])
        tf.textColor = .white
        return tf
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#242529")
        
        [backView, rectangleImage, fromTextField,toTextField, searchImage, airplaneImage, lineImage].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backView.heightAnchor.constraint(equalToConstant: 96),
            
            rectangleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            rectangleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleImage.widthAnchor.constraint(equalToConstant: 38),
            rectangleImage.heightAnchor.constraint(equalToConstant: 5),
            
            airplaneImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 13),
            airplaneImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            
            fromTextField.topAnchor.constraint(equalTo: backView.topAnchor),
            fromTextField.leadingAnchor.constraint(equalTo: airplaneImage.trailingAnchor, constant: 5),
            fromTextField.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            fromTextField.heightAnchor.constraint(equalToConstant: 48),
            
            lineImage.topAnchor.constraint(equalTo: fromTextField.bottomAnchor),
            lineImage.leadingAnchor.constraint(equalTo: airplaneImage.leadingAnchor),
            lineImage.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
            
            searchImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -13),
            searchImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor),
            toTextField.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 5),
            toTextField.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            toTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
