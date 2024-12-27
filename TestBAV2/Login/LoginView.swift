//
//  LoginView.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//

import UIKit
final class LoginView: UIView {
    
    // MARK: - UI Components

    private let evaluationLabel: UILabel = {
        let label = UILabel()
        label.text = "Evaluation"
        label.font =  UIFont(name: "Avenir-Roman", size: 33)
        label.textAlignment = .center
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label that displays "Bienvenido" to welcome the user
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font =  UIFont(name: "Avenir-Roman", size: 19)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .gray
        label.minimumScaleFactor = 0.2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label for the login title, displaying "Iniciar sesión"
    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font =  UIFont(name: "Avenir-Heavy", size: 30)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label for the "Usuario"
    private let userLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.font =  UIFont(name: "Avenir", size: 19)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A text field where the user can input their username.
    let idUserTextField: UITextField = {
        let textfield = UITextField()
        textfield.font =  UIFont(name: "Avenir", size: 21)
        textfield.layer.cornerRadius = 9
        textfield.layer.borderWidth = 0.5
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.textColor = .gray
        textfield.setPadding()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    /// A label for the "Contraseña" (password)
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "password"
        label.font = UIFont(name: "Avenir", size: 18)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A text field where the user can input their password
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.font =  UIFont(name: "Avenir-Roman", size: 21)
        textfield.isSecureTextEntry = true
        textfield.layer.cornerRadius = 9
        textfield.layer.borderWidth = 0.5
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.setPadding()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    /// A custom UIButton that represents a checkbox to remember the user's login information.
    let rememberCheckBox: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        
        let uncheckedImage = UIImage(systemName: "square")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let checkedImage = UIImage(systemName: "checkmark.square")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        button.setImage(uncheckedImage, for: .normal)
        button.setImage(checkedImage, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 20
        button.clipsToBounds = false
        button.backgroundColor = .clear
        return button
    }()
    
    /// A label that accompanies the checkbox, prompting the user to "Recordar contraseña" (Remember password).
    let rememberLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember"
        label.font =  UIFont(name: "Avenir", size: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A button to trigger the login action.
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 19)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 8
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.9
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Stack Views
    /// A stack view containing the left side of the login form (labels, text fields, and buttons).
    private let leftLoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// The main stack view that horizontally arranges the login form and the evaluation view.
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// A custom view that contains the evaluation section.
    private let evaluationView: UIView = {
        let stackView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets up the view by adding the required subviews
    private func setupView() {
        self.backgroundColor = .white
        
        leftLoginStackView.addArrangedSubview(welcomeLabel)
        leftLoginStackView.addArrangedSubview(loginTitleLabel)
        leftLoginStackView.addArrangedSubview(userLabel)
        leftLoginStackView.addArrangedSubview(idUserTextField)
        leftLoginStackView.addArrangedSubview(passwordLabel)
        leftLoginStackView.addArrangedSubview(passwordTextField)
        
        let rememberStack = UIStackView(arrangedSubviews: [rememberCheckBox, rememberLabel])
        rememberStack.axis = .horizontal
        rememberStack.spacing = 5
        leftLoginStackView.addArrangedSubview(rememberStack)
        
        rememberCheckBox.addTarget(self, action: #selector(toggleCheckBox), for: .touchUpInside)
        leftLoginStackView.addArrangedSubview(logInButton)
        
        mainStackView.addArrangedSubview(evaluationView)
        mainStackView.addArrangedSubview(leftLoginStackView)
        
        evaluationView.addSubview(evaluationLabel)
        contentView.addSubview(mainStackView)

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupConstraints()
    }
    
    // MARK: - Constraints
    /// All the constrains for the view
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -50),
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
        ])
        NSLayoutConstraint.activate([
            evaluationView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.15),
        ])
        NSLayoutConstraint.activate([
            rememberCheckBox.widthAnchor.constraint(equalToConstant: 22),
            rememberLabel.heightAnchor.constraint(equalTo: rememberCheckBox.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
            evaluationLabel.centerXAnchor.constraint(equalTo: evaluationView.centerXAnchor),
            evaluationLabel.bottomAnchor.constraint(equalTo: evaluationView.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            
            idUserTextField.heightAnchor.constraint(equalTo: logInButton.heightAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: logInButton.heightAnchor),
            userLabel.heightAnchor.constraint(equalTo: logInButton.heightAnchor, multiplier: 0.5),
            passwordLabel.heightAnchor.constraint(equalTo: logInButton.heightAnchor, multiplier: 0.5),
            welcomeLabel.heightAnchor.constraint(equalTo: logInButton.heightAnchor, multiplier: 0.6),
            loginTitleLabel.heightAnchor.constraint(equalTo: logInButton.heightAnchor, multiplier: 1.1),
        ])
    }
    
    // MARK: - Checkbox Functionality
    /// Toggles the checkbox selection state for "Remember password."
    @objc private func toggleCheckBox() {
        rememberCheckBox.isSelected.toggle()
    }
}

// MARK: UITextField
extension LoginView: UITextFieldDelegate {
    /// This function is in charge of modifying the visual appearance for when the user is interacting or stops interacting with a text field
    /// - Parameters:
    ///   - textField: is the view the user is interacting
    ///   - isSelected: status when is selected the textField
    ///
    func changeBackground(textField: UITextField, isSelected: Bool) {
        if isSelected {
            if textField == passwordTextField {
                textField.layer.borderWidth =  0.5
                textField.layer.borderColor = UIColor.purple.cgColor
                textField.layer.cornerRadius = 9
            } else if textField == idUserTextField {
                textField.layer.borderWidth =  0.5
                textField.layer.borderColor = UIColor.purple.cgColor
                textField.layer.cornerRadius = 9
            }
        } else {
            textField.backgroundColor = .white
            textField.layer.borderWidth =  0.5
            textField.layer.cornerRadius = 9
            textField.layer.borderColor = UIColor.gray.cgColor
        }
    }
    ///Method used to jump to the nextField o make the login action when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == idUserTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            logInButton.sendActions(for: .touchUpInside)
        }
        return true
    }
}

// MARK: - UITextField Padding
extension UITextField {
    func setPadding(left: CGFloat = 12, right: CGFloat = 14) {
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = paddingViewLeft
        self.leftViewMode = .always
        
        let paddingViewRight = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.rightView = paddingViewRight
        self.rightViewMode = .always
    }
}
