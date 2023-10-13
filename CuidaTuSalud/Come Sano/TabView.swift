//
//  TabView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 13/10/23.
//

import SwiftUI
struct foodselected:Identifiable{
    var id = UUID()
    var food:String
    var tab: Tab
}
var selectedTab: [foodselected] = [
    foodselected(food: "Desayuno", tab: .Desayuno),
    foodselected(food: "Comida", tab: .Comida),
    foodselected(food: "Cena", tab: .Cena),
    foodselected(food: "Merienda", tab: .Merienda)
]
enum Tab:String{
    case Desayuno
    case Comida
    case Cena
    case Merienda
}
struct TabView: View {
    @Binding var itemselected: Tab
    var body: some View {
        HStack{
            ForEach(selectedTab){ item in
                Button(action: {
                    itemselected = item.tab
                }, label: {
                    Text(item.food)
                        .foregroundColor(itemselected == item.tab ? .white : .black)
                        .padding(8)
                        .background(itemselected == item.tab ? .black : Color(""))
                        .cornerRadius(10)
                })
            }
        }
    }
}

#Preview {
    TabView(itemselected: .constant(.Desayuno))
}
