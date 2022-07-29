//
//  RoundCollectionViewCell.swift
//  StudyDriveTest
//
//  Created by Eric Mok on 27/7/2022.
//

import UIKit

final class RoundCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        
        contentView.add(label)
        let views: [String: Any] = ["label": label]
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|-8-[label]-8-|", options: [], metrics: nil, views: views))
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
