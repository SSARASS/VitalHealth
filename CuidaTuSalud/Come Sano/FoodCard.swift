//
//  FoodCard.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 13/10/23.
//

import SwiftUI

struct FoodCard: View {
    var width:CGFloat = 200
    @State var cards:CGFloat = 20
    @State var fat:CGFloat = 70
    @State var name:String = ""
    @State var title:String = ""
    var body: some View {
        let multiplier = width / 200
        return VStack(alignment: .leading, spacing: 2){
            HStack{
                Text(name)
                    .font(.title2)
                    .frame(width:160)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }.bold()
            HStack{
                Text(title)
                Spacer()
            }
            .frame(width:200, height: 50)
            .minimumScaleFactor(0.6)
        }
        .offset(x:20, y:-20)
        .frame(width: 270, height:130)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
        .overlay(alignment:.bottom, content: {
            HStack{
                Elements(name: "Gramos", foodElement: cards, multiplier: multiplier, color: "cantidad")
                Elements(name: "Calorías", foodElement: cards, multiplier: multiplier, color: "calorías")
            }.offset(y:-20)
        })
    }
}
struct Elements: View {
    var name = "name"
    var foodElement:CGFloat = 0
    var multiplier:CGFloat = 0
    var color = ""
    var body: some View {
        let width: CGFloat = 130
        let multiplier = width / 50
        VStack{
        Text(name)
                .font(.system(size: 12))
            Rectangle().frame(width: foodElement * multiplier, height: 5)
                .cornerRadius(5)
                .foregroundColor(CustomColor.BgColor)
        }
        .padding(.bottom, 5)
        .frame(width: 90)
    }
}
#Preview {
    FoodCard()
}
