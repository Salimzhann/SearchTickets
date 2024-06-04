//
//  TicketsViewController.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 04.06.2024.
//

import UIKit

class TicketsViewController: UIViewController {
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск дешевых \n    авиабилетов"
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
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
            imageView.image = UIImage(systemName: "magnifyingglass")
            imageView.tintColor = .white
            return imageView
    }()
        
    private let fromTextField: UITextField = {
            let label = UITextField()
            label.placeholder = "Минск"
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
            return label
    }()
        
    private let toTextField: UITextField = {
            let label = UITextField()
            label.placeholder = "Куда - Турция"
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        [mainLabel, containerView,  subContainer, fromTextField, toTextField, searchIcon].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 148),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.heightAnchor.constraint(equalToConstant: 122),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            subContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            subContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            subContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            searchIcon.topAnchor.constraint(equalTo: subContainer.topAnchor, constant: 33),
            searchIcon.leadingAnchor.constraint(equalTo: subContainer.leadingAnchor, constant: 8),
            
            fromTextField.topAnchor.constraint(equalTo: subContainer.topAnchor, constant: 8),
            fromTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8),
            
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 5),
            toTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 8)
            

        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
