//
//  UIButton+Extension.swift
//  StudyDriveTest
//
//  Created by Eric Mok on 28/7/2022.
//

import UIKit

extension UIButton {
    convenience init(font: UIFont, textColor: UIColor) {
        self.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel!.font = font
        setTitleColor(textColor, for: .normal)
    }
    
    func addRoundCorner(backgroundColor: UIColor = .systemBlue) {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
    }
}

