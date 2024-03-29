//
//  AuthenticationRepository.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 9/5/23.
//

import Foundation
import FirebaseAuth


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
    func login(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        authenticationFirebaseDatasource.login(email: email, password: password, completionBlock: completionBlock)
    }
    func logout() throws {
        try authenticationFirebaseDatasource.logout()
    }
    func resetPassword(email: String, completionBlock: @escaping (Result<Void, Error>) -> Void) {
        authenticationFirebaseDatasource.resetPassword(email: email, completion: completionBlock)
    }
}
