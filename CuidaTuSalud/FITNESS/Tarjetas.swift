//
//  Tarjetas.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 7/10/23.
//

import SwiftUI

struct Activity{
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}
struct Tarjetas: View {
    @State var activity:Activity
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 5) {
                    Text(activity.title)
                        .font(.system(size: 22))
                    Text(activity.subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.3))
                }
                Spacer()
                Image(systemName: activity.image)
                    .font(.title)
                    .foregroundColor(CustomColor.BgColorNoD)
            }
            Text(activity.amount)
                .font(.system(size: 20))
                .offset(y:5)
        }
        .padding()
        .background(CustomColor.BtColor.opacity(0.5))
        .cornerRadius(10)
        
    }
}

struct Tarjetas_Previews: PreviewProvider {
    
    static var previews: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES") // Configurar el locale en español
        dateFormatter.dateFormat = "EEEE" // Formato para el nombre completo del día (por ejemplo, "lunes")
        let today = Date()
        var dayString = dateFormatter.string(from: today)

        if let firstLetter = dayString.first {
            dayString.replaceSubrange(dayString.startIndex...dayString.startIndex, with: String(firstLetter).capitalized)
        }

        let activity = Activity(id: 0, title: "Pasos:", subtitle: "\(dayString)", image: "figure.walk", amount: "8,429")
        return Tarjetas(activity: activity)
    }
}
