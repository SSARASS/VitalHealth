//
// PantallaRegitrarseView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 26/3/23.
//

import SwiftUI

struct PantallaRegistrarseView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""

    var body: some View {
        ZStack {
            Image("LoginFade")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(systemName: "person.3.fill")
                //Hemos puesto un icono que nos proporciona apple que se puede ver desde simbolos sf
                    .resizable()
                    .scaledToFit()
                    .frame(width:200)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                    .padding(.top, 70)
                Text("Registrarse")
                    .font(.custom("Alatsi", size: 25))
                    .fontWeight(.thin)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                TextField("Email", text: $textFieldEmail)
                TextField("Introduce tu contraseña", text: $textFieldPassword)
                Button("Aceptar"){
                    authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPassword)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                if let messageError = authenticationViewModel.messageError{
                    Text(messageError)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                }
                Spacer()
                NavigationLink(destination: PantallaInicialView(authenticationViewModel: authenticationViewModel)) {
                    Text("¿Tienes cuenta? Inicia sesión.")
                }
            }
        }
    }
}

struct PantallaRegistrarseView_Previews: PreviewProvider {
    static var previews: some View {
        PantallaRegistrarseView(authenticationViewModel: AuthenticationViewModel())
    }
}
