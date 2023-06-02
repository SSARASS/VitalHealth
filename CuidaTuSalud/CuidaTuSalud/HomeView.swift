//
//  HomeView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 9/5/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        NavigationView{
            VStack{
                Text("IWDN")
                Text("IWDN")
                Button ("Cerrar sesión"){
                    authenticationViewModel.logout()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.black)
            }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authenticationViewModel: AuthenticationViewModel())
    }
}
