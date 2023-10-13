//
//  AddView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 13/10/23.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var vm:CDDataModel
    @State var itemselected: Tab = .Desayuno
    @State var title: String = ""
    @State var fat: String = ""
    @State var name: String = ""
    @State var cards: String = ""
    @State var fatTF: Bool = false
    @State var cardsTF: Bool = false
    var body: some View {
        VStack (spacing:25) {
            TabView(itemselected: $itemselected)
            VStack(spacing: 25){
                VStack{
                    TextField("Nombre de la comida.", text: $name)
                    Divider()
                    TextField("Ingredientes", text: $title)
                }
                .font(.title3)
                .padding()
                .background(CustomColor.FullColor)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
                
                VStack{
                    values(number: $fat, show: $fatTF, name: "Grasas")
                    values(number: $cards, show: $cardsTF, name: "Gramos")
                }
                .padding()
                .background(CustomColor.FullColor)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
                Button(action: {
                    switch itemselected {
                    case .Desayuno:
                        vm.addBreakfast(name: name, ingredient: title, fat: CGFloat(Int(fat) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                    case .Comida:
                        vm.addBreakfast(name: name, ingredient: title, fat: CGFloat(Int(fat) ?? 0), cards: CGFloat(Int(cards) ?? 0))
                    case .Cena:
                        print("Cena")
                    case .Merienda:
                        print("Merienda")
                    }
                }, label: {
                    Text("Guardar")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 180, height: 50)
                        .background(CustomColor.FullColor)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
                })
            }
        }
    }
}

#Preview {
    AddView()
        .environmentObject(CDDataModel())
}

struct values: View {
    @Binding var number: String
    @Binding var show:Bool
    var name = ""
    
    var body: some View {
        HStack{
            Text(name)
                .bold()
                .font(.title2)
            Spacer()
            Text("\(number)")
                .bold()
                .font(.title2)
                .frame(width: 45, height: 30)
                .background(.black)
                .cornerRadius(5)
                .foregroundColor(CustomColor.FullColor)
                .onTapGesture {
                    withAnimation{
                        show.toggle()
                    }
                }
            if show{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(1 ..< 100){ item in
                            Text("\(item)").bold()
                                .frame(width:30, height: 30)
                                .background(.black.opacity(0.2))
                            .cornerRadius(5)
                            .onTapGesture {
                                show.toggle()
                                number = "\(item)"
                            }
                        }
                    }
                }
                .frame(width: 100, height: 30)
            }
        }
        .padding(10)
    }
}
