//
//  CustomLabel.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 08.06.2024.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0) // Adjust the left padding as needed

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
