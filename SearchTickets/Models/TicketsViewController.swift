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
    
    let button: UIButton = {
        let button = UIButton()
        button.isOpaque = true
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
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
            imageView.tintColor = .white
            return imageView
    }()
        
    private let fromTextField: UITextField = {
            let label = UITextField()
            label.attributedPlaceholder = NSAttributedString(string: "Минск", attributes: [.foregroundColor: UIColor.lightGray])
            label.textColor = .white
            label.textAlignment = .left
            label.backgroundColor = UIColor(hex: "3E3F43")
            label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
            return label
    }()
    let customButton: UIButton = {
        let button = CustomButton()
        return button
    }()
    
    let musicLabel: UILabel = {
        let label = UILabel()
        label.text = "Музыкально отлететь"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
        
    private let toTextField: UITextField = {
            let label = UITextField()
            label.attributedPlaceholder = NSAttributedString(string: "Куда - Турция", attributes: [.foregroundColor: UIColor.lightGray])
            label.textColor = .white
        label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            return label
    }()
    
    let musicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.showsHorizontalScrollIndicator = false
        cv.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        return cv
    }()
    
    var imageID: [Int] = []
    var singerArray: [String] = []
    var coutryArray: [String] = []
    var priceArray: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
    }
    
    func setupUI() {
        [mainLabel, musicLabel, musicCollectionView, customButton, button].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          
            customButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            customButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            customButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            customButton.heightAnchor.constraint(equalToConstant: 122),
            
            button.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 122),
            
            musicLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 302),
            musicLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            musicCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 354),
            musicCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            musicCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            musicCollectionView.heightAnchor.constraint(equalToConstant: 213.16)
            
            
        ])
        musicCollectionView.dataSource = self
        musicCollectionView.delegate = self
    }
    
    func fetchData() {
        guard let url = URL(string: "https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let offers = try JSONDecoder().decode([String: [Singer]].self, from: data)
                if let offersList = offers["offers"] {
                    DispatchQueue.main.async {
                        self.imageID.removeAll()
                        self.singerArray.removeAll()
                        self.coutryArray.removeAll()
                        self.priceArray.removeAll()
                        
                        for offer in offersList {
                            self.imageID.append(offer.id)
                            self.singerArray.append(offer.title)
                            self.coutryArray.append(offer.town)
                            self.priceArray.append(offer.price.value)
                        }
                        self.musicCollectionView.reloadData()
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    @objc func handleSearchButton() {
        let vc = SearchViewController()
        navigationController?.present(vc, animated: true)
    }


}

extension TicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        singerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = musicCollectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as! MusicCollectionViewCell
        cell.configure(imageID: imageID[indexPath.item] ,singer: singerArray[indexPath.item], country: coutryArray[indexPath.item], price: priceArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 213.16)
    }
    
}
