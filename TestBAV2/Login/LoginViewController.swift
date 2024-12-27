//
//  LoginViewController.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//

import UIKit
import Combine


class LoginViewController: UIViewController {
    // MARK: - Properties
    private let viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let contentView: LoginView = LoginView() // Tu clase de vista (UIKit)
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.idUserTextField.delegate = self
        contentView.passwordTextField.delegate = self
        
        contentView.logInButton.addTarget(self,
                                          action: #selector(didTapLogin),
                                          for: .touchUpInside)
        
        contentView.rememberCheckBox.addTarget(self,
                                               action: #selector(didTapRememberCheckBox),
                                               for: .touchUpInside)
        
        viewModel.getUserExists()
    }
    
    // MARK: - Acciones
    @objc private func didTapLogin() {
        viewModel.validateCredentials(
            username: contentView.idUserTextField.text,
            password: contentView.passwordTextField.text
        )
        .receive(on: RunLoop.main)
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                switch error {
                case .emptyData:
                    self?.showAlert(title: "Error", message: "Los campos están vacíos.")
                case .invalidCredentials:
                    self?.showAlert(title: "Error", message: "Credenciales inválidas.")
                case .serverError:
                    self?.showAlert(title: "Error", message: "Error del servidor. Intenta más tarde.")
                default:
                    self?.showAlert(title: "Error", message: "No se puede iniciar sesión.")
                }
            }
        } receiveValue: { [weak self] success in
            if success {
                print("Login correcto")
                self?.presentImageModal()
            } else {
                print("Login incorrecto")
                self?.showAlert(title: "Error", message: "Login incorrecto.")
            }
        }
        .store(in: &cancellables)
    }
    
    @objc private func didTapRememberCheckBox() {
        viewModel.rememberUserStatusSwitch = contentView.rememberCheckBox.isSelected
    }
    
    private func presentImageModal() {
        let imageModalVC = ImageModalViewController()
        imageModalVC.modalPresentationStyle = .fullScreen
        present(imageModalVC, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == contentView.idUserTextField {
            contentView.passwordTextField.becomeFirstResponder()
        } else if textField == contentView.passwordTextField {
            didTapLogin()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        contentView.changeBackground(textField: textField, isSelected: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contentView.changeBackground(textField: textField, isSelected: false)
    }
    
}
