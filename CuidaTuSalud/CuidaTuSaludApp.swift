//
//  CuidaTuSaludApp.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 26/3/23.
//

import SwiftUI
import Firebase
import HealthKit
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

struct CustomColor {
    static let BgColor = Color("BgColor")
    static let BtColor = Color("BtColor")
    static let BgColorNoD = Color("BgColorNoD")
    static let FullColor = Color("FullColor")
    static let TabViewColor = Color("TabViewColor")
}

struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    var isSecure: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            
            if isSecure {
                SecureField("", text: $text, onCommit: commit)
            } else {
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
        }
    }
}


@main
struct CuidaTuSaludApp: App {
    @StateObject var manager = FitnessManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate //codigo de Firebase
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @StateObject var vm: CDDataModel = CDDataModel()
    var body: some Scene {
        WindowGroup {
            if let _ = authenticationViewModel.user{
                HomeView(authenticationViewModel: authenticationViewModel)
                    .environmentObject(manager)
                    .environmentObject(CDDataModel())
            }else{
                PantallaInicial(authenticationViewModel: authenticationViewModel)
            }
        }
    }
}
