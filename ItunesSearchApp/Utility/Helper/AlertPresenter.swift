//
//  AlertPresenter.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 30.04.2022.
//

import UIKit

struct Alert: Equatable {
    let title: String
    let message: String
}

protocol AlertPresenter where Self: UIViewController {
    func show(_ alert: Alert)
}

extension AlertPresenter {
    
    func show(_ alert: Alert) {
        let alert = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.alertActionTitle, style: .default)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}

