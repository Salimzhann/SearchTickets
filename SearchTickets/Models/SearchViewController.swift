//
//  SearchViewController.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 05.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let rectangleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "closeRectangel")
        return image
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#242529")
    }
}
