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
        [mainLabel, containerView,  subContainer, fromTextField, toTextField, searchIcon, musicLabel, musicCollectionView].forEach({
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
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            searchIcon.widthAnchor.constraint(equalToConstant: 24),
            
            fromTextField.topAnchor.constraint(equalTo: subContainer.topAnchor, constant: 16),
            fromTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 16),
            
            toTextField.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 5),
            toTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 16),
            
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
                let offers = try JSONDecoder().decode([String: [Offer]].self, from: data)
                if let offersList = offers["offers"] {
                    DispatchQueue.main.async {
                        self.imageID.removeAll()
                        self.singerArray.removeAll()
                        self.coutryArray.removeAll()
                        self.priceArray.removeAll()
                        
                        for offer in offersList {
                            print("ID: \(offer.id), Title: \(offer.title), Town: \(offer.town), Price: \(offer.price.value)")
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
struct Offer: Codable {
    let id: Int
    let title: String
    let town: String
    let price: Price
}

struct Price: Codable {
    let value: Int
}

struct OffersResponse: Codable {
    let offers: [Offer]
}

