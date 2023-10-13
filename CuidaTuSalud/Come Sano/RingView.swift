//
//  RingView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 13/10/23.
//

import SwiftUI

struct RingView: View {
    @EnvironmentObject var vm:CDDataModel
    var percent: CGFloat = 50
    let width: CGFloat = 130
    let height: CGFloat = 130
    var perc: CGFloat = 50
    var body: some View {
        return HStack{

            VStack(spacing: 30){
                ForEach(vm.saveValorEntiy){item in
                    foodElementValue(elemento: "Gramos", gramos: String(format: "%.0f", item.cards), color: "cards", elementValue: CGFloat(item.cards))
                    foodElementValue(elemento: "Calorías", gramos: String(format: "%.0f", item.fat), color: "fat", elementValue: CGFloat(item.fat))
                }.padding(.horizontal)
                .offset(y:10)
            }
        }
        .frame(height: 200)
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(CustomColor.FullColor)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
    }
}
struct foodElementValue: View {
    var elemento = ""
    var gramos = ""
    var color = ""
    var elementValue:CGFloat = 0
    var body: some View {
        let width: CGFloat = 130
        let multiplier = width / 2000
        VStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(width: 300, height: 8)
                    .foregroundColor(CustomColor.TabViewColor)
                if elementValue != 0{
                    Rectangle()
                        .frame(width:elementValue * multiplier, height: 8)
                        .foregroundColor(Color(color))
                } else {
                    Rectangle()
                        .frame(width: 300, height: 8)
                        .foregroundColor(Color(color))
                }
            }
            .cornerRadius(10)
            Text(elemento)
                .font(.system(size: 12))
            Text(gramos)
                .font(.system(size: 10))
        }
    }
}
#Preview {
    RingView()
        .environmentObject(CDDataModel())
}
