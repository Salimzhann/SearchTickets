//
//  ResponseTableViewCell.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 06.06.2024.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {
    static let identifier: String = "ResponseCell"
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let rangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemBlue
        return label
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(id: Int, title: String, price: Int, timeRange: [String]) {
        companyLabel.text = title
        circleView.backgroundColor = UIColor(hex: findColor(id: id))
        priceLabel.text = "\(price) ₽ >"
        var temp: String = ""
        for time in timeRange {
            temp = "\(temp) \(time)"
        }
        rangeLabel.text = temp
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(hex: "#2F3035")
        [companyLabel, priceLabel, rangeLabel, circleView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            circleView.heightAnchor.constraint(equalToConstant: 24),
            circleView.widthAnchor.constraint(equalToConstant: 24),
            
            companyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            companyLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 8),
            
            rangeLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 5),
            rangeLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 8),
            rangeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func findColor(id: Int) -> String{
        switch id {
            case 1:
                return "#FF5E5E"
            case 10:
                return "#2261BC"
            case 30:
                return "#FFFFFF"
            default:
                return "Unknown"
            }
    }
}
