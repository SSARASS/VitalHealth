//
//  CDDataModel.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 12/10/23.
//

import Foundation
import CoreData
class CDDataModel:ObservableObject{
    let container: NSPersistentContainer
    @Published var saveDesayunoEntity: [DesayunoEntity] = []
    @Published var saveComidaEntity: [ComidaEntity] = []
    @Published var saveValorEntiy: [ValorEntity] = []
        init(){
            container = NSPersistentContainer(name: "CdFoodClass")
            container.loadPersistentStores{(descrip,error) in
                if let error = error{
                    print("Error al tratar de conseguir datos \(error)")
                }
            }
            fetchData()
    }
    func fetchData(){
        let requestOne = NSFetchRequest<DesayunoEntity>(entityName: "DesayunoEntity")
        let requestTwo = NSFetchRequest<ComidaEntity>(entityName: "ComidaEntity")
        let requestThree = NSFetchRequest<ValorEntity>(entityName: "ValorEntity")
        do {
            saveDesayunoEntity = try container.viewContext.fetch(requestOne)
            saveComidaEntity = try container.viewContext.fetch(requestTwo)
            saveValorEntiy = try container.viewContext.fetch(requestThree)
        } catch let error{
            print("Error al sincronizar datos: \(error)")
        }
    }
    func addBreakfast(name:String, ingredient:String, fat:CGFloat, cards:CGFloat){
        let newmeal = DesayunoEntity(context: container.viewContext)
        newmeal.name = name
        newmeal.ingredients = ingredient
        newmeal.fat = Float(fat)
        newmeal.cards = Float(cards)
        saveData()
    }
    func addLunch(name:String, ingredient:String, fat:CGFloat, cards:CGFloat){
        let newmeal = DesayunoEntity(context: container.viewContext)
        newmeal.name = name
        newmeal.ingredients = ingredient
        newmeal.fat = Float(fat)
        newmeal.cards = Float(cards)
        saveData()
    }
    func addValue(fat:CGFloat, cards:CGFloat){
        let newValue = NSFetchRequest<ValorEntity>(entityName: "ValorEntity")
        do{
            let results = try container.viewContext.fetch(newValue)
            if let entity = results.first{
                entity.fat += Float(fat)
                entity.cards += Float(cards)
            } else{
                let newValue = ValorEntity(context: container.viewContext)
                newValue.fat = Float(fat)
                newValue.cards = Float(cards)
            }
            saveData()
            fetchData()
        } catch {
            print("\(error)")
        }
    }
    func addRingCalories(calories:CGFloat){
        let newcal = NSFetchRequest<ValorEntity>(entityName: "ValorEntity")
        do{
            let results = try container.viewContext.fetch(newcal)
            if let entity = results.first{
                entity.ring += Float(Int(calories))
            } else{
                let newEntity = ValorEntity(context: container.viewContext)
                newEntity.ring = 10
            }
        }catch {
            print("\(error)")
        }
        saveData()
        fetchData()
    }
    func addMealTaggle(meal:DesayunoEntity){
        meal.addmeal.toggle()
        saveData()
    }
    func saveData(){
        do{
            try container.viewContext.save()
            fetchData()
        } catch {
            print("Error al guardar datos: \(error)")
        }
    }
}
