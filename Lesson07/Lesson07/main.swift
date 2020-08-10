//
//  main.swift
//  Lesson07
//
//  Created by Дмитрий Шикунов on 08.08.2020.
//  Copyright © 2020 Дмитрий Шикунов. All rights reserved.
//

import Foundation

/*
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
 */

/* ПРО ERROR */
var printerSharp: Printer = Printer(paperFormatSupport: [.A3, .A4, .A5, .A3], paperDencitySupport: [.normal, .heavy, .normal])

printerSharp.drumResource = .yes
printerSharp.paperLot = .full
printerSharp.printerConnection = .onLine
printerSharp.tonerResource = .yes

let risult = printerSharp.toPrint(paperDensity: .normal, paperFormat: .A0)

if risult.0 {
    print("Страница отпечатана.")
} else if let error = risult.1 {
    print("Произошла ошибка: \(error.localizedDescription)")
}


/* ПРО TRY/CATCH */
var carVolvo: Car = Car(brand: "Volvo", fuel: .disel, maxTunkFuelVolume: 80)

do {
    let volume = try carVolvo.pourFuel(typeFuel: .disel, volume: 100)
    print("Заправлено \(volume) л\nОстаток топлива в баке \(carVolvo.fuelRemaining) л")
}
catch let error {
    print(error.localizedDescription)
    print("Остаток топлива в баке \(carVolvo.fuelRemaining) л")
}
