//
// PantallaInicialView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 26/3/23.
//

import SwiftUI


struct PantallaInicialView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("LoginFade")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:200)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                        .padding(.top, 70)
                    Text("INICIA SESIÓN")
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    TextField("Email", text: $textFieldEmail)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 64)
                    TextField("Introduce tu contraseña", text: $textFieldPassword)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 64)
                    Button("¿Has olvidado la contraseña?"){
                        print("hola")
                    }
                    .font(.custom("Alatsi", size: 10))
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .underline()
                    Button("Entra ya"){
                        print("Hola")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    Spacer()
                    NavigationLink(destination: PantallaRegistrarseView(authenticationViewModel: authenticationViewModel)) {
                        Text("¿No tienes cuenta? Registrate")
                    }
                }
            }
        }
    }
}
    
    struct PantallaInicialView_Previews: PreviewProvider {
        static var previews: some View {
            PantallaInicialView(authenticationViewModel: AuthenticationViewModel())
        }
    }
