//
//  AuthenticationRepository.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 9/5/23.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    func getCurrentUser() -> User?{
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        authenticationFirebaseDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }
    func logout() throws {
        try authenticationFirebaseDatasource.logout()
    }
}
