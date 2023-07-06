//
//  ViewController.swift
//  uikit-marathon-2-buttons
//
//  Created by Vladislav Shakhray on 06/07/2023.
//

import UIKit

let buttonTitles = [
    "It's",
    "Wednesday",
    "My dudes"
]

class ViewController: UIViewController {
    
    var buttons: [UIButton] = []
    
    func createButton(title: String) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        
        let systemImage = UIImage(systemName: "trash.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .medium))
        
        button.setImage(systemImage, for: .normal)
        button.layer.cornerRadius = 6.0
        button.semanticContentAttribute = .forceRightToLeft
        
        let spacing: CGFloat = 8
        let verticalOffset = 10.0
        let horizontalOffset = 14.0
        
        button.configuration = .borderedProminent()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: verticalOffset, leading: horizontalOffset, bottom: verticalOffset, trailing: horizontalOffset)
        button.configuration?.imagePadding = spacing
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons = buttonTitles.map {
            createButton(title: $0)
        }
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.alignment = .center
        view.addSubview(stackView)
        
        for (index, button) in buttons.enumerated() {
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.addTarget(self, action: #selector(scaleButton), for: .touchDown)
            button.addTarget(self, action: #selector(unscaleButton), for: .touchUpInside)
            
            if index == 2 {
                button.addTarget(self, action: #selector(openModal), for: .touchUpInside)
            }
            stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0)
        ])
    }
    
    @objc func scaleButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .allowUserInteraction,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }
        )
    }
    
    @objc func openModal() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemPink
        present(vc, animated: true)
    }
    
    @objc func unscaleButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .allowUserInteraction,
                       animations: {
            sender.transform = .identity
        }
        )
    }
}

