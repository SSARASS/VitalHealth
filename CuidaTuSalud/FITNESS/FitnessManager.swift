//
//  FitnessManager.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 7/10/23.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var oneMonthAgo: Date {
        let calendar = Calendar.current
        let oneMonth = calendar.date(byAdding: .month, value: -1, to: Date())
        return calendar.startOfDay(for: oneMonth!)
    }
    static var oneYearAgo: Date {
        let calendar = Calendar.current
        let oneYear = calendar.date(byAdding: .year, value: -1, to: Date())
        return calendar.startOfDay(for: oneYear!)
    }
    static var oneWeekAgo: Date {
        let calendar = Calendar.current
        let oneWeek = calendar.date(byAdding: .weekOfYear, value: -1, to: Date())
        return calendar.startOfDay(for: oneWeek!)
    }
}

extension Double {
    func formattedString(style: NumberFormatter.Style, maximumFractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.maximumFractionDigits = maximumFractionDigits

        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return String(self)
        }
    }
}

class FitnessManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var activities: [String :  Activity] = [:]
    
    @Published var oneMonthChartData = [PasosDiariosView]()
    @Published var oneYearChartData = [PasosDiariosView]()
    @Published var oneWeekChartData = [PasosDiariosView]()
    
    init(){
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        
        Task{
            do{
                try await healthStore.requestAuthorization(toShare: [], read:healthTypes)
                fetchTodaySteps()
                fetchPastMonthStepData()
                fetchPastYearStepData()
                fetchPastWeekStepData()
            } catch{
                print("Error al tratar de obtener datos.")
            }
        }
    }
    func fetchDailySteps(startDate: Date, completion: @escaping ([PasosDiariosView]) -> Void){
        let steps = HKQuantityType(.stepCount)
        let interval = DateComponents (day: 1)
        let query = HKStatisticsCollectionQuery (quantityType: steps, quantitySamplePredicate: nil, anchorDate: startDate,
        intervalComponents: interval)
        query.initialResultsHandler = {query, result, error in
            guard let result = result else {
                completion([])
                return
            }
            var dailySteps = [PasosDiariosView]()
            
            result.enumerateStatistics (from: startDate, to: Date()) { statistics, stop in dailySteps.append (PasosDiariosView(Date: statistics.startDate, stepCount: statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0.00))
                }
                completion(dailySteps)
            }
        healthStore.execute(query)
    }
    func fetchTodaySteps() {
        let steps = HKQuantityType(.stepCount)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "EEEE"
        let today = Date()
        var dayString = dateFormatter.string(from: today)
        if let firstLetter = dayString.first {
            dayString.replaceSubrange(dayString.startIndex...dayString.startIndex, with: String(firstLetter).capitalized)
        }
        let predicate = HKQuery.predicateForSamples(withStart: Date.startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity() else {
                 let activity = Activity(id: 0, title: "Pasos:", subtitle: "\(dayString)", image: "figure.walk", amount: "0")
                 DispatchQueue.main.async {
                     self.activities["HoyPasos"] = activity
                 }
                 return
             }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Pasos:", subtitle: "\(dayString)", image: "figure.walk", amount: stepCount.formattedString(style: .decimal, maximumFractionDigits: 0))
            DispatchQueue.main.async {
                self.activities["HoyPasos"] = activity
            }
            print(stepCount.formattedString(style: .decimal, maximumFractionDigits: 0))
        }
        
        healthStore.execute(query)
    }
}
extension Double {
    func formattedString(decimalPlaces: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalPlaces
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        }
        return "\(self)"
    }
}

extension FitnessManager {
    func fetchPastMonthStepData() {
        fetchDailySteps(startDate: .oneMonthAgo) { dailySteps in
            DispatchQueue.main.async{
                self.oneMonthChartData = dailySteps
            }
        }
    }
}
extension FitnessManager {
    func fetchPastWeekStepData() {
        fetchDailySteps(startDate: .oneWeekAgo) { dailySteps in
            DispatchQueue.main.async{
                self.oneWeekChartData = dailySteps
            }
        }
    }
}
extension FitnessManager {
    func fetchPastYearStepData() {
        fetchDailySteps(startDate: .oneYearAgo) { dailySteps in
            DispatchQueue.main.async{
                self.oneYearChartData = dailySteps
            }
        }
    }
}
