//
//  UIViewController.swift
//  ArgyleTest
//
//  Created by Vitalii Kizlov on 12.02.2023.
//

import UIKit

extension UIViewController {
    func showAlertInfo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
