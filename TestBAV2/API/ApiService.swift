//
//  ApiService.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//


import Foundation
import Combine


struct ReqResLoginResponse: Decodable {
    let token: String
}


final class ApiService {
    
    static let shared = ApiService()
    private init() {}
    
    func loginRequest(email: String, password: String) -> AnyPublisher<String, LoginError> {
        

        guard !email.isEmpty, !password.isEmpty else {
            return Fail(error: .emptyData).eraseToAnyPublisher()
        }

        guard let url = URL(string: "https://reqres.in/api/login") else {

            return Fail(error: .errorRetrievingInformation).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: body)
            request.httpBody = bodyData
        } catch {
            return Fail(error: .errorRetrievingInformation).eraseToAnyPublisher()
        }
        
        
        return URLSession.shared.dataTaskPublisher(for: request)
        
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw LoginError.errorRetrievingInformation
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 400:
                    // Credenciales inválidas
                    throw LoginError.invalidCredentials
                case 500:
                    throw LoginError.serverError
                default:
                    throw LoginError.errorRetrievingInformation
                }
            }
 
            .decode(type: ReqResLoginResponse.self, decoder: JSONDecoder())
 
            .map { $0.token }
       
            .mapError { error -> LoginError in
                if let loginError = error as? LoginError {
                    return loginError
                } else {
                    return LoginError.errorRetrievingInformation
                }
            }
            .eraseToAnyPublisher()
    }
}

extension ApiService {
    
    func fetchRandomDogImage() -> AnyPublisher<String, LoginError> {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            return Fail(error: .errorRetrievingInformation).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw LoginError.errorRetrievingInformation
                }
                return data
            }
            .decode(type: DogImageResponse.self, decoder: JSONDecoder())
            .map { $0.message }
            .mapError { error -> LoginError in
                if let loginError = error as? LoginError {
                    return loginError
                } else if error is DecodingError {
                    return .parsingError
                } else {
                    return .errorRetrievingInformation
                }
            }
            .eraseToAnyPublisher()
    }
}
