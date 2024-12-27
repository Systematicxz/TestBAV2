//
//  ImageModalViewController.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//


import UIKit
import Combine

class ImageModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private let imageModalView = ImageModalView()
    private let viewModel = ImageModalViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = imageModalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupActions()
        viewModel.fetchRandomDogImage()
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
       
        viewModel.$imageURL
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] urlString in
                guard let url = URL(string: urlString) else { return }
                self?.loadImage(from: url)
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                self?.showAlert(title: "Error", message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    private func setupActions() {
        imageModalView.nextImageButton.addTarget(self, action: #selector(didTapNextImage), for: .touchUpInside)
        imageModalView.logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapNextImage() {
        viewModel.fetchRandomDogImage()
    }
    
    @objc private func didTapLogout() {
        viewModel.logout()
        
        navigateToLogin()
    }
    
    // MARK: - Navigation
    
    private func navigateToLogin() {
        let loginVC = LoginViewController()

        if let sceneDelegate = UIApplication.shared.connectedScenes
            .first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            window.rootViewController = UINavigationController(rootViewController: loginVC)
            window.makeKeyAndVisible()
            
            let options: UIView.AnimationOptions = .transitionFlipFromLeft
            UIView.transition(with: window, duration: 0.5, options: options, animations: {}, completion: nil)
        }
    }
    
    // MARK: - Helper Methods
    
    private func loadImage(from url: URL) {
        imageModalView.activityIndicator.startAnimating()
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.imageModalView.activityIndicator.stopAnimating()
            }
            
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "No se pudo cargar la imagen.")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.imageModalView.dogImageView.image = image
            }
        }.resume()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
