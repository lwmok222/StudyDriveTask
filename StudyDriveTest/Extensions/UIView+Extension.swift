//
//  UIView+Extension.swift
//  StudyDriveTest
//
//  Created by Eric Mok on 27/7/2022.
//

import UIKit

extension UIView {
    static func autoLayoutView() -> Self {
        let a = self.init()
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }
    
    func add(_ subviews: UIView...) {
        for view in subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func add(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func add(_ subviews: [UIView]) {
        for view in subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
