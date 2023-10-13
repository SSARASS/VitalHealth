//
//  PantallaInicial.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 1/10/23.
//

import SwiftUI

struct PantallaInicial: View {
    @EnvironmentObject var manager: FitnessManager
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var text: String = "TextField Text"
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    @State var indice = 0
    @State private var showingResetPasswordAlert = false
    



    
    
    var body: some View {

            ZStack{
                if self.indice == 0{
                    CustomColor.BgColor
                        .edgesIgnoringSafeArea(.all)
                    Image("Image1")                    .resizable()
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .scaledToFill()
                        .opacity(0.05)
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:150)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                            .padding(.top, 70)
                            .offset(x: -10)
                        Text("INICIO DE SESIÓN")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        HStack {
                            Image(systemName: "envelope")
                                .font(.title2)
                                .foregroundColor(.white)
                            SuperTextField(
                                placeholder: Text("Introduce tu correo.")
                                    .foregroundColor(.white),
                                text: $textFieldEmail
                            )
                            .foregroundColor(.white)
                        }
                        .padding(.all)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(16)
                        .frame(minWidth: 340, maxWidth: 340, alignment: .center)
                        HStack {
                            Image(systemName: "lock")
                                .font(.title2)
                                .foregroundColor(.white)
                            SuperTextField(placeholder: Text("Introduce tu contraseña."), text: $textFieldPassword, isSecure: true)
                                .foregroundColor(.white)
                                .offset(x: 10)
                            
                        }
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(16)
                        .frame(minWidth: 340, maxWidth: 340, alignment: .center)
                        
                        Button("Aceptar"){
                            authenticationViewModel.login(email: textFieldEmail, password: textFieldPassword)
                            
                        }
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color.white)
                        .cornerRadius(16)
                        .offset(y: 20)
                        
                        
                        if let messageError = authenticationViewModel.messageError{
                            Text(messageError)
                                .bold()
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.indice = 1
                        }){
                            VStack{
                                Text("¿No tienes cuenta? Registrate.")
                                    .foregroundColor(.white)
                            }
                        }
                        Button(action: {
                            authenticationViewModel.resetPassword(email: textFieldEmail)
                        }) {
                            Text("Restablecer contraseña.")
                        }
                        .foregroundColor(.white)
                    }
                }
                
                
                else if self.indice == 1{
                    
                    CustomColor.BgColor
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("Image1")
                        .resizable()
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .scaledToFill()
                        .opacity(0.05)
                    
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:150)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                            .padding(.top, 70)
                            .offset(x: -10)
                        
                        Text("REGÍSTRO")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        
                        HStack {
                            Image(systemName: "envelope")
                                .font(.title2)
                                .foregroundColor(.white)
                            SuperTextField(
                                placeholder: Text(" Introduce un correo.").foregroundColor(.white),
                                text: $textFieldEmail
                            )
                            
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(16)
                        .frame(minWidth: 340, maxWidth: 340, alignment: .center)
                        HStack {
                            Image(systemName: "lock")
                                .font(.title2)
                                .foregroundColor(.white)
                            SuperTextField(placeholder: Text("Introduce una contraseña."), text: $textFieldPassword, isSecure: true)
                                .foregroundColor(.white)
                                .offset(x: 10)
                        }
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .cornerRadius(16)
                        .frame(minWidth: 340, maxWidth: 340, alignment: .center)
                        
                        Button("Aceptar"){
                            authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPassword)
                        }
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color.white)
                        .cornerRadius(16)
                        .offset(y: 20)
                        if let messageError = authenticationViewModel.messageError{
                            Text(messageError)
                                .bold()
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        Button(action: {
                            self.indice = 0
                        }){
                            VStack{
                                Text("¿Ya tienes cuenta? Inicia sesión.")
                                    .foregroundColor(.white)
                            }
                        }
                        
                    }
                }
            }
        }
    }





struct PantallaInicial_Previews: PreviewProvider {
    static var previews: some View {
        PantallaInicial(authenticationViewModel: AuthenticationViewModel())
    }
}



