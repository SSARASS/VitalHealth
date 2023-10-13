//
//  AuthenticationViewModel.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 9/5/23.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user:User?
    @Published var messageError:String?
    private let authenticationRepository: AuthenticationRepository
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    func getCurrentUser(){
        self.user = authenticationRepository.getCurrentUser()
    }
    func createNewUser (email:String, password:String){
        authenticationRepository.createNewUser(email: email,
                                               password: password) {[weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    func login (email:String, password:String){
        authenticationRepository.login(email: email,
                                               password: password) {[weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func logout() {
        do{
            try authenticationRepository.logout()
            self.user = nil
        }catch{
            print("Error al cerrar sesión.")
        }
    }
    func resetPassword(email: String) {
        authenticationRepository.resetPassword(email: email) { result in
            switch result {
            case .success:
                self.messageError = "¡La contraseña se ha restablecido con éxito! Se ha enviado un correo electrónico con instrucciones."

            case .failure(let error):
                self.messageError = error.localizedDescription
            }
        }
    }
}


