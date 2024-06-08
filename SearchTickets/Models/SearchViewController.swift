//
//  SearchViewController.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 05.06.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    var switchBool: Bool = false {
        didSet {
            updateStackViewVisibility()
        }
    }
    var isSelect: Bool = false
    
    let followPriceBackground: UIView = {
        let back = UIView()
        back.layer.cornerRadius = 8
        back.backgroundColor = UIColor(hex: "#2F3035")
        back.isHidden = true
        return back
    }()
    let followIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "follows")
        image.isHidden = true
        return image
    }()
    
    let followLabel: UILabel = {
        let label = UILabel()
        label.text = "Подписка на цену"
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    let radioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "radioOff"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.isHidden = true
        button.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        return button
    }()
    
    let showAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Посмотреть все билеты", for: .normal)
        button.backgroundColor = UIColor(hex: "#2261BC")
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(showAllButtonHandle), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let label: CustomLabel = {
        let label = CustomLabel()
        label.textColor = .white
        label.layer.cornerRadius = 16
        label.clipsToBounds = true
        label.text = "Прямые рельсы"
        label.backgroundColor = UIColor(hex: "#2F3035")
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
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
    
    let responseTableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 56
        tv.backgroundColor = UIColor(hex: "#2F3035")
        tv.layer.cornerRadius = 16
        tv.isHidden = true
        tv.separatorColor = .lightGray
        tv.register(ResponseTableViewCell.self, forCellReuseIdentifier: ResponseTableViewCell.identifier)
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
    
    var stackView: UIStackView!
    
    var titleArray: [String] = []
    var priceArray: [Int] = []
    var rangeArray: [[String]] = []
    var idArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
//    MARK: - UI configuration
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#242529")
        
        stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.isUserInteractionEnabled = true
        stackView.distribution = .fillEqually
        stackView.isHidden = switchBool
        
        [backView, rectangleImage, fromTextField,toTextField, searchImage, airplaneImage, lineImage, stackView, recommendTableView, responseTableView, label, showAllButton,followPriceBackground , followLabel, followIcon, radioButton].forEach({
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
            recommendTableView.heightAnchor.constraint(equalToConstant: 216),
            
            responseTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 238),
            responseTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            responseTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            responseTableView.heightAnchor.constraint(equalToConstant: 288),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 211),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 55),
            
            showAllButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 544),
            showAllButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showAllButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            showAllButton.heightAnchor.constraint(equalToConstant: 42),
            
            followPriceBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 610),
            followPriceBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            followPriceBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            followPriceBackground.heightAnchor.constraint(equalToConstant: 51),
            
            followIcon.centerYAnchor.constraint(equalTo: followPriceBackground.centerYAnchor),
            followIcon.leadingAnchor.constraint(equalTo: followPriceBackground.leadingAnchor, constant: 16),
            
            followLabel.centerYAnchor.constraint(equalTo: followPriceBackground.centerYAnchor),
            followLabel.leadingAnchor.constraint(equalTo: followIcon.trailingAnchor, constant: 5),
            
            radioButton.centerYAnchor.constraint(equalTo: followPriceBackground.centerYAnchor),
            radioButton.trailingAnchor.constraint(equalTo: followPriceBackground.trailingAnchor, constant: -16),
            radioButton.heightAnchor.constraint(equalToConstant: 30),
            radioButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        recommendTableView.tableHeaderView = headerView
        responseTableView.tableHeaderView = headerView
        
        buttonActions()
        setupViews()
    }
    
    func buttonActions() {
        addCancelButton(to: fromTextField)
        addCancelButton(to: toTextField)
        button1.addTarget(self, action: #selector(handleButton1), for: .touchUpInside)
    }
    
    func setupViews() {
        recommendTableView.dataSource = self
        recommendTableView.delegate = self
        
        responseTableView.dataSource = self
        responseTableView.delegate = self
        
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
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func updateStackViewVisibility() {
        stackView.isHidden = switchBool
        recommendTableView.isHidden = switchBool
        
        [responseTableView,label,showAllButton,followPriceBackground,followIcon,followLabel, radioButton].forEach({$0.isHidden = !switchBool})
    }
    
//    MARK: - Button actions -
        
    @objc func clearTextField(_ sender: UIButton) {
        if let textField = sender.superview as? UITextField {
            textField.text = ""
        }
    }
    
    @objc func handleButton1() {
        print("lol")
    }
    
    @objc func imageTapped() {
        isSelect = !isSelect
        if isSelect {
            radioButton.setImage(UIImage(named: "radioOn"), for: .normal)
        } else {
            radioButton.setImage(UIImage(named: "radioOff"), for: .normal)
        }
        
    }
    
    @objc func showAllButtonHandle() {
        
    }

//    MARK: - Fetching of Data (tickets information)
    func fetchData() {
        guard let url = URL(string: "https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let ticketsResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        for ticketOffer in ticketsResponse.ticketsOffers {
                            self.idArray.append(ticketOffer.id)
                            self.titleArray.append(ticketOffer.title)
                            self.priceArray.append(ticketOffer.price.value)
                            self.rangeArray.append(ticketOffer.timeRange)
                            self.responseTableView.reloadData()
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}



//MARK: - Extension of SearchController
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recommendTableView {
            return countryArray.count
        } else {
            return titleArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == recommendTableView {
            let cell = recommendTableView.dequeueReusableCell(withIdentifier: RecTableViewCell.identifier, for: indexPath) as! RecTableViewCell
            cell.configure(country: countryArray[indexPath.item])
            return cell
        } else {
            let cell = responseTableView.dequeueReusableCell(withIdentifier: ResponseTableViewCell.identifier, for: indexPath) as! ResponseTableViewCell
            cell.configure(id: idArray[indexPath.item], title: titleArray[indexPath.item], price: priceArray[indexPath.item], timeRange: rangeArray[indexPath.item])
            return cell
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fromTextField {
            toTextField.becomeFirstResponder()
        } else if textField == toTextField {
            textField.resignFirstResponder()
            if let from = fromTextField.text, let to = toTextField.text,
               !from.isEmpty, !to.isEmpty {
                fetchData()
                switchBool = true
            } else {
                showAlert(message: "Please enter both 'from' and 'to' locations")
                return true
            }
        }
        return true
    }
    
   
}
