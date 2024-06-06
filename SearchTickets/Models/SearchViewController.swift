//
//  SearchViewController.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 05.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let countryArray: [String] = ["Стамбул","Сочи", "Пхукет"]
    
    let recommendTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 60
        tv.backgroundColor = UIColor(hex: "#2F3035")
        tv.layer.cornerRadius = 16
        tv.separatorColor = .lightGray
        tv.register(RecTableViewCell.self, forCellReuseIdentifier: RecTableViewCell.identifier)
        return tv
    }()
    
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
        tf.text = "Минск"
        tf.textColor = .white
        tf.clearButtonMode = .whileEditing
        tf.attributedPlaceholder = NSAttributedString(string: tf.text!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray ])
        return tf
    }()
    
    let toTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Куда - Турция"
        tf.clearButtonMode = .whileEditing
        tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray ])
        tf.textColor = .white
        return tf
    }()
    
    let button1: UIButton = {
      let button = SearchCustomButton(icon: UIImage(named: "hardWay")!, title: "Сложный \nмаршрут")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let button2 = SearchCustomButton(icon: UIImage(named: "anyplace")!, title: "Куда угодно")
    let button3 = SearchCustomButton(icon: UIImage(named: "holidays")!, title: "Выходные")
    let button4 = SearchCustomButton(icon: UIImage(named: "hot")!, title: "Горячие \nбилеты")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#242529")
        
        let stackView: UIStackView = {
            let view = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
            view.axis = .horizontal
            view.spacing = 10
            view.alignment = .top
            view.isUserInteractionEnabled = true
            view.distribution = .fillEqually
            return view
        }()
        
        [backView, rectangleImage, fromTextField,toTextField, searchImage, airplaneImage, lineImage, stackView, recommendTableView].forEach({
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
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            recommendTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 284),
            recommendTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recommendTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            recommendTableView.heightAnchor.constraint(equalToConstant: 216)
        ])
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 15))
        recommendTableView.tableHeaderView = headerView
        
        addCancelButton(to: fromTextField)
        addCancelButton(to: toTextField)
        button1.isUserInteractionEnabled = true
        button1.addTarget(self, action: #selector(handleButton1), for: .touchUpInside)
        
        recommendTableView.dataSource = self
        recommendTableView.delegate = self
        fromTextField.delegate = self
        toTextField.delegate = self
    }
    
    func addCancelButton(to textField: UITextField) {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelButton.tintColor = .lightGray
        cancelButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        cancelButton.addTarget(self, action: #selector(clearTextField(_:)), for: .touchUpInside)
        textField.rightView = cancelButton
        textField.rightViewMode = .whileEditing
    }
        
    @objc func clearTextField(_ sender: UIButton) {
        if let textField = sender.superview as? UITextField {
            textField.text = ""
        }
    }
    @objc func handleButton1() {
        print("lol")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendTableView.dequeueReusableCell(withIdentifier: RecTableViewCell.identifier, for: indexPath) as! RecTableViewCell
        cell.configure(country: countryArray[indexPath.item])
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            if textField == fromTextField {
                toTextField.becomeFirstResponder()
            } else if textField == toTextField {
                textField.resignFirstResponder()
                if let from = fromTextField.text, let to = toTextField.text,
                           !from.isEmpty, !to.isEmpty {
                            fetchData()
                        } else {
                            showAlert(message: "Please enter both 'from' and 'to' locations")
                            return true
                        }
            }
            return true
        }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func fetchData() {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let ticketsResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    for ticketOffer in ticketsResponse.ticketsOffers {
                        print("ID: \(ticketOffer.id), Title: \(ticketOffer.title), Time Range: \(ticketOffer.timeRange), Price: \(ticketOffer.price)")
                               }
                }catch { print(error) }
            }
            
        }.resume()
    }
}


