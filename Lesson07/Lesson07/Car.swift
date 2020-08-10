//
//  Car.swift
//  Lesson07
//
//  Created by Дмитрий Шикунов on 09.08.2020.
//  Copyright © 2020 Дмитрий Шикунов. All rights reserved.
//

import Foundation


enum TypesFuel {
    case ai76, ai80, ai92, ai95, ai100, disel, gas
}

enum CarError: Error, LocalizedError {
    case UnacceptableFuel
    case AttemptToAddNegativeAmountOfFuel
    case LessVolumeFilled(volumeFact: Double)
    case UnknownError
    
    
    var errorDescription: String? {
        switch self {
        case .UnacceptableFuel:
            return "Недопустимый вид топлива"
        case .AttemptToAddNegativeAmountOfFuel:
            return "Попытка залить отрицательный объём."
        case .LessVolumeFilled(let volumeFact):
            return "Не удалось залить весь объём. Залито \(volumeFact) л"
        default:
            return "Не известная ошибка."
        }
    }
}
class Car {
    
    var brand: String
    var fuel: TypesFuel
    var maxTunkFuelVolume: Double
    var fuelRemaining: Double

 
    init(brand: String, fuel: TypesFuel, maxTunkFuelVolume: Double) {
        
        self.brand = brand
        self.fuel = fuel
        self.maxTunkFuelVolume = maxTunkFuelVolume
        self.fuelRemaining = 0
    }
    

    
    func pourFuel(typeFuel: TypesFuel, volume: Double) throws -> Double {
        
        var volumeFact = 0.0
        
        guard volume > 0 else {
            throw CarError.AttemptToAddNegativeAmountOfFuel
        }
        
        guard typeFuel == fuel else {
            throw CarError.UnacceptableFuel
        }
        
        if fuelRemaining + volume > maxTunkFuelVolume {
            volumeFact = maxTunkFuelVolume - fuelRemaining
            fuelRemaining = maxTunkFuelVolume
            throw CarError.LessVolumeFilled(volumeFact: volumeFact)
        } else {
            fuelRemaining += volume
            volumeFact = volume
        }
        return volumeFact
    }
}
