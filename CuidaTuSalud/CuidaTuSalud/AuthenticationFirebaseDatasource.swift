//
//  AuthenticationFirebaseDatabase.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 9/5/23.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

class AuthenticationFirebaseDatasource{
    func getCurrentUser() -> User?{
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return.init(email: email)
    }
    func createNewUser(email: String, password: String, completionBlock: @escaping(Result<User, Error>) -> Void){
        Auth.auth().createUser(withEmail: email , password: password){ AuthDataResult, error in
            if let error = error {
                print("Error al crear un nuevo usuario \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No hay email"
            print("Nuevo usuario creado con \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    func logout() throws{
        try Auth.auth().signOut()
    }
}
