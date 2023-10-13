//
//  HomeView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 9/5/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: FitnessManager
    @EnvironmentObject var vm:CDDataModel
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var index = 0
    @State var itemselected: Tab = .Desayuno
    @State var show = false
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                ZStack{
                    if self.index == 0{
                        VStack{
                            Text("Inicio")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(CustomColor.BgColorNoD)
                                .multilineTextAlignment(.leading)
                                .offset(x:-140)
                                .offset(y:10)
                                .padding(.bottom)
                            
                            }
                            Button(action: {
                                self.index = 2
                            }){
                                RingView()
                                    .padding(.horizontal,10)
                            }                                .padding(.vertical)
                            Button(action: {
                            self.index = 1
                            }){
                            ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id }), id: \.key){ item in
                                Tarjetas(activity: item.value)
                            }
                                .padding(.horizontal)
                                .padding(.vertical)
                            Button(action: {
                                self.index = 3
                            }){
                                Image("Boton3")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal,10)
                            }                                .padding(.vertical)
                            
                            
                        }
                    }
                    
                    else if self.index == 1{
                        VStack{
                            Text("Pasos")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(CustomColor.BgColorNoD)
                                .multilineTextAlignment(.leading)
                                .offset(x:-140)
                                .offset(y:10)
                            Spacer()
                            
                            ChartsView()
                            ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id }), id: \.key){ item in
                                Tarjetas(activity: item.value)
                            }
                            .padding(.all)
                        }
                        
                    }
                    
                    
                    
                    else if self.index == 2{
                        VStack{
                            Text("Comida")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(CustomColor.BgColorNoD)
                                .multilineTextAlignment(.leading)
                                .offset(x:-130)
                                .offset(y:10)
                                .padding(.bottom)
                            RingView()
                                .padding(.bottom)
                            WaterView()
                            Divider()
                            TabView(itemselected: $itemselected)
                                .padding(.bottom)
                            if itemselected == .Desayuno{
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing: 10){
                                        ForEach(vm.saveDesayunoEntity){item in
                                            FoodCard(width: 200, cards: CGFloat(item.cards), fat: CGFloat(item.cards), name: item.name ?? "", title: item.ingredients ?? "")
                                                .padding(.leading)
                                                .overlay(alignment: .topTrailing, content: {
                                                    Button(action: {
                                                        vm.addValue(fat: CGFloat(item.fat), cards: CGFloat(item.cards))
                                                        vm.addMealTaggle(meal: item)
                                                        vm.addRingCalories(calories: CGFloat(item.cards))
                                                    }, label: {
                                                        ZStack{
                                                            Circle()
                                                                .frame(width:30, height: 30)
                                                                .foregroundColor(CustomColor.FullColor)
                                                            Image(systemName: item.addmeal ? "checkmark" : "plus")
                                                                .imageScale(.small)
                                                                .foregroundColor(.black)
                                                        }
                                                        .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
                                                    })
                                                })
                                        }
                                    }
                                }
                            } else if itemselected == .Comida{
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing: 10){
                                        ForEach(vm.saveComidaEntity){item in
                                            FoodCard(width: 200, cards: CGFloat(item.cards), fat: CGFloat(item.cards), name: item.name ?? "", title: item.ingredients ?? "")
                                                .padding(.leading)
                                            
                                        }
                                    }
                                }
                            }
                            NavigationLink(destination: AddView()){
                                            Text("Nueva comida")
                                                .bold()
                                                .foregroundColor(.black)
                                                .frame(width:150, height:50)
                                                .background(CustomColor.FullColor)
                                                .clipShape(Capsule())
                                                .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
                                        }
                            .padding(.bottom)
                        }
                    }
                    
                    else if self.index == 3 {
                        VStack{
                            Text("Ejercicios")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(CustomColor.BgColorNoD)
                                .multilineTextAlignment(.leading)
                                .offset(x:-115)
                                .offset(y:10)
                            
                            Button(action: {
                                self.index = 5
                            }){
                                VStack{
                                    Image("cardio")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.top)
                                        .padding(.horizontal)
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    Button(action: {
                                        self.index = 6
                                    }){
                                        VStack{
                                            Image("Biceps")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(.leading)
                                        }
                                    }
                                    Button(action: {
                                        self.index = 7
                                    }){
                                        VStack{
                                            Image("Triceps")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    Button(action: {
                                        self.index = 8
                                    }){
                                        VStack{
                                            Image("Piernas")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    Button(action: {
                                        self.index = 9
                                    }){
                                        VStack{
                                            Image("abdominales")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    Button(action: {
                                        self.index = 10
                                    }){
                                        VStack{
                                            Image("pecho")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    Button(action: {
                                        self.index = 11
                                    }){
                                        VStack{
                                            Image("espalda")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                            
                        }
                        
                    }
                    
                    
                    
                    else if self.index == 4{
                        VStack{
                            
                            Button ("Cerrar sesión"){
                                authenticationViewModel.logout()
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.black)
                        }
                    }
                    else if self.index == 5 {
                        NavigationLink(destination: ChartsView()) {
                            Text("¿No tienes cuenta? Registrate")
                        }
                    }
                }
                Spacer()
                TabbVIew(index: self.$index)
            }.background(CustomColor.FullColor.edgesIgnoringSafeArea(.top))
            
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authenticationViewModel: AuthenticationViewModel())
    }
}

struct TabbVIew: View {
    @EnvironmentObject var manager: FitnessManager
    @Binding var index : Int
    
    var body : some View{
            HStack{
                Button(action: {
                    self.index = 1
                }){
                    VStack{
                        if self.index != 1{
                            Image(systemName: "shoeprints.fill").foregroundColor(CustomColor.TabViewColor)
                                .offset(y: 10)
                                .scaledToFit()
                        }
                        else{
                            Image(systemName: "shoeprints.fill")
                                .scaledToFit()
                                .frame(width: 25, height:23)
                                .foregroundColor(.white)
                                .padding()
                                .background(CustomColor.BtColor)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .offset(y: -10)
                                .padding(.bottom, -20)
                            
                        }
                    }
                }
                Spacer(minLength: 14)
                
                Button(action: {
                    
                    self.index = 2
                }){
                    VStack{
                        if self.index != 2{
                            Image(systemName: "carrot.fill").foregroundColor(CustomColor.TabViewColor)
                                .offset(y: 10)
                                .scaledToFit()
                        }
                        else{
                            Image(systemName: "carrot.fill")
                                .scaledToFit()
                                .frame(width: 25, height:23)
                                .foregroundColor(.white)
                                .padding()
                                .background(CustomColor.BtColor)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .offset(y: -10)
                                .padding(.bottom, -20)
                            
                        }
                    }
                }
                Spacer(minLength: 14)
                
                Button(action: {
                    
                    self.index = 0
                }){
                    VStack{
                        if self.index != 0{
                            Image(systemName: "house.fill").foregroundColor(CustomColor.TabViewColor)
                                .offset(y: 10)
                                .scaledToFit()
                        }
                        else{
                            Image(systemName: "house.fill")
                                .scaledToFit()
                                .frame(width: 25, height:23)
                                .foregroundColor(.white)
                                .padding()
                                .background(CustomColor.BtColor)
                                .clipShape(Circle())
                                .offset(y: -10)
                                .padding(.bottom, -20)
                            
                        }
                    }
                }
                Spacer(minLength: 14)
                
                Button(action: {
                    
                    self.index = 3
                }){
                    VStack{
                        if self.index == 3 || self.index == 5 || self.index == 6 || self.index == 7 || self.index == 8 || self.index == 9 || self.index == 10 || self.index == 11  {
                            Image(systemName: "dumbbell.fill")
                                .scaledToFit()
                                .frame(width: 25, height:23)
                                .foregroundColor(.white)
                                .padding()
                                .background(CustomColor.BtColor)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .offset(y: -10)
                                .padding(.bottom, -20)

                        }
                        else{
                            Image(systemName: "dumbbell.fill").foregroundColor(CustomColor.TabViewColor)
                                .offset(y: 10)
                                .scaledToFit()
                            
                        }
                    }
                }
                Spacer(minLength: 14)
                
                Button(action: {
                    
                    self.index = 4
                }){
                    VStack{
                        
                        if self.index != 4{
                            Image(systemName: "gear").foregroundColor(CustomColor.TabViewColor)
                            
                                .offset(y: 10)
                        }

                        else{
                            Image(systemName: "gear")
                                .scaledToFit()
                                .frame(width: 25, height:23)
                                .foregroundColor(.white)
                                .padding()
                                .background(CustomColor.BtColor)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .offset(y: -10)
                                .padding(.bottom, -20)
                            
                        }
                    }
                }
                
            }.padding(.vertical, 0)
                .padding(.horizontal, 40)
                .background(CustomColor.FullColor)
                    .shadow(radius: 6)
                .animation(
                  Animation
                    .easeInOut(duration: 0.2),
                  value: UUID()
                )

    }
}

