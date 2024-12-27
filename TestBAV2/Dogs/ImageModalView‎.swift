//
//  ImageModalView‎.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//

import UIKit

class ImageModalView: UIView {
    
    // MARK: - UI Components
    
    let dogImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()
    
    let nextImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cerrar Sesión", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        return ai
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View
    
    private func setupView() {
        self.backgroundColor = .white
        
        addSubview(dogImageView)
        addSubview(nextImageButton)
        addSubview(logoutButton)
        addSubview(activityIndicator)
        addSubview(errorLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            // UIImageView Constraints
            dogImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            dogImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dogImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            dogImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            // Next Image Button Constraints
            nextImageButton.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            nextImageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextImageButton.widthAnchor.constraint(equalToConstant: 200),
            nextImageButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Logout Button Constraints
            logoutButton.topAnchor.constraint(equalTo: nextImageButton.bottomAnchor, constant: 20),
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Activity Indicator Constraints
            activityIndicator.centerXAnchor.constraint(equalTo: dogImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: dogImageView.centerYAnchor),
            
            // Error Label Constraints
            errorLabel.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}
