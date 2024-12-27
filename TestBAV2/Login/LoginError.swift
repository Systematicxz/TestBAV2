//
//  LoginError.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//

import Foundation

enum LoginError: LocalizedError {
    case emptyData
    case invalidCredentials
    case serverError
    case parsingError
    case errorRetrievingInformation

    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "Los campos están vacíos."
        case .invalidCredentials:
            return "Credenciales inválidas."
        case .serverError:
            return "Error del servidor. Intenta más tarde."
        case .parsingError:
            return "Error al procesar la información."
        case .errorRetrievingInformation:
            return "No se puede recuperar la información."
        }
    }
}
