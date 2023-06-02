//
//  CuidaTuSaludApp.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 26/3/23.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct CuidaTuSaludApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate //codigo de Firebase
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            if let user = authenticationViewModel.user{
                HomeView(authenticationViewModel: authenticationViewModel)
            }else{
                PantallaInicialView(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
