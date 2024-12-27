//
//  LoginViewModel.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//

import UIKit
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var rememberUserStatusSwitch: Bool = false
    
    private let userDefaults = UserDefaults.standard
    var cancellables = Set<AnyCancellable>()
    
    // Claves para UserDefaults
    let userTokenKey = "userToken"
    let savedUserEmailKey = "savedUserEmail"
    
    /// Valida las credenciales del usuario utilizando la API de login.
    /// - Parameters:
    ///   - username: Email del usuario.
    ///   - password: Contraseña del usuario.
    /// - Returns: Un `AnyPublisher` que emite `true` si el login es exitoso o un `LoginError` en caso de fallo.
    func validateCredentials(username: String?, password: String?) -> AnyPublisher<Bool, LoginError> {
        
        return ApiService.shared.loginRequest(email: username ?? "",
                                              password: password ?? "")
        .map { [weak self] token -> Bool in
            guard let self = self else { return false }
            
            // Guardar el token
            self.userDefaults.set(token, forKey: self.userTokenKey)
            
            if self.rememberUserStatusSwitch {
                // Guardar el email del usuario si se selecciona "Recordar"
                self.userDefaults.setValue(username, forKey: self.savedUserEmailKey)
            } else {
                // Eliminar el email del usuario si no se selecciona "Recordar"
                self.userDefaults.removeObject(forKey: self.savedUserEmailKey)
            }
            return true
        }
        .mapError { $0 }
        .eraseToAnyPublisher()
    }
    
    /// Verifica si el usuario está actualmente logueado.
    /// - Returns: `true` si el usuario está logueado, de lo contrario `false`.
    func isUserLoggedIn() -> Bool {
        // Verificar si existe un token en UserDefaults
        if let _ = userDefaults.string(forKey: userTokenKey) {
            return true
        }
        return false
    }
    
    func logout() {
        // Eliminar el token y el email del usuario de UserDefaults
        userDefaults.removeObject(forKey: userTokenKey)
        userDefaults.removeObject(forKey: savedUserEmailKey)
    }
    
    func getUserExists() {
        if let savedUser = userDefaults.string(forKey: savedUserEmailKey) {
            print("Usuario recordado: \(savedUser)")
        }
    }
}
