//
//  ChartsView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 8/10/23.
//

import SwiftUI
import Charts

struct PasosDiariosView: Identifiable {
    let id = UUID()
    let Date: Date
    let stepCount: Double
}

enum ChartOptions {
    case oneWeek
    case oneMonth
    case oneYear
}

struct ChartsView: View {
    @EnvironmentObject var manager: FitnessManager
    @State private var isAnnotationVisible = false
    @State private var selectedDate = Date()
    @State private var selectedSteps = 0
    @State var selectedChart: ChartOptions = .oneMonth
    var chartData: [PasosDiariosView] {
        switch selectedChart {
        case .oneWeek:
            return manager.oneWeekChartData
        case .oneMonth:
            return manager.oneMonthChartData
        case .oneYear:
            return manager.oneYearChartData
        }
    }
    
    var body: some View {
        VStack{

            HStack{
                Button("SEMANA"){
                    selectedChart = .oneWeek
                }
                .padding(.all)
                .bold()
                .foregroundColor(selectedChart == .oneWeek ? .white: CustomColor.BgColorNoD)
                .background(selectedChart == .oneWeek ? CustomColor.BgColorNoD.opacity(0.6): Color.clear)
                .cornerRadius(10)
                Spacer()
                Button("MES"){
                    selectedChart = .oneMonth
                }
                .padding(.all)
                .bold()
                .foregroundColor(selectedChart == .oneMonth ? .white: CustomColor.BgColorNoD)
                .background(selectedChart == .oneMonth ? CustomColor.BgColorNoD.opacity(0.6): Color.clear)
                .cornerRadius(10)
                Spacer()
                Button("AÑO"){
                        selectedChart = .oneYear
                }
                .padding(.all)
                .bold()
                .foregroundColor(selectedChart == .oneYear ? .white: CustomColor.BgColorNoD)
                .background(selectedChart == .oneYear ? CustomColor.BgColorNoD.opacity(0.6): Color.clear)
                .cornerRadius(10)
            }.padding(.vertical, 0)
                .background(.black.opacity(0.05))
                .cornerRadius(10)
            .frame(width: 300)
            
            Chart {
                ForEach(chartData) { daily in
                    BarMark(x: .value(daily.Date.formatted(), daily.Date, unit: .day), y: .value("Pasos", daily.stepCount))
                }
            }
            .frame(height: 430)
            .foregroundStyle(CustomColor.BtColor.gradient)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(CustomColor.FullColor)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(CustomColor.BtColor.opacity(0.5), lineWidth: 1))
            .padding(.horizontal)
            .padding(.top)
            .overlay(
                GeometryReader { proxy in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location
                                    let width = proxy.size.width
                                    let relativeX = location.x / width
                                    let index = Int(relativeX * CGFloat(chartData.count))

                                    if index >= 0 && index < chartData.count {
                                        let selectedItem = chartData[index]
                                        selectedDate = selectedItem.Date
                                        selectedSteps = Int(selectedItem.stepCount)
                                        isAnnotationVisible = true
                                    }
                                }
                                .onEnded { value in
                                    isAnnotationVisible = false
                                }
                        )
                        .overlay(
                            VStack {
                                if isAnnotationVisible {
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(CustomColor.FullColor)
                                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 5)
                                        .frame(width: 200)
                                        .frame(height: 100)
                                        .overlay(
                                            VStack {
                                                Text("Fecha: \(selectedDate.formatted())")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                                Text("Pasos: \(selectedSteps)")
                                                    .foregroundColor(CustomColor.BgColorNoD)
                                                    .font(.title3.bold())
                                                
                                                
                                            }
                                        )
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .position(x: proxy.size.width / 2, y: 0)
                                        .offset(y: 30)
                                }
                            }
                        )
                }
            )
        }
        .onAppear(){
            withAnimation(.easeInOut(duration: 1.0)) {
                print(chartData)
            }

        }
    }
}

#Preview {
    ChartsView()
        .environmentObject(FitnessManager())
}
