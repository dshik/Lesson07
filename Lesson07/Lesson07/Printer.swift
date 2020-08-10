//
//  Printer.swift
//  Lesson07
//
//  Created by Дмитрий Шикунов on 09.08.2020.
//  Copyright © 2020 Дмитрий Шикунов. All rights reserved.
//

import Foundation

enum PaperDensity {
    case thin, normal, heavy, superheavy
}

enum PaperFormat {
    case A6, A5, A4, A3, A2, A1, A0
}

enum PrinterStatus {
    case onLine, offLine
}

enum Resource {
    case yes, no
}

enum PaperLot {
    case empty, full
}

enum PrintError: Error, LocalizedError {
    case UnacceptablePaperWeight
    case UnsupportedPaperSize
    case DrumExhausted
    case TonerOut
    case PaperOut
    case PrinterIsNotConnected
    case UnknownError
    
    var errorDescription: String? {
        switch self {
        case .DrumExhausted:
            return "Ресурс фотобарабана исчерпан. Замените фотобарабан"
        case .PaperOut:
            return "Закончилась бумага. Добавьте в лоток бумагу."
        case .PrinterIsNotConnected:
            return "Принтер не подключен к компьютеру. Проверьте подключение."
        case .TonerOut:
            return "Закончился тонер. Замените картридж."
        case .UnacceptablePaperWeight:
            return "Не поддерживаемая плотность бумаги."
        case .UnsupportedPaperSize:
            return "Не верный размер бумаги."
        default:
            return "Не известная ошибка."
        }
    }
}

class Printer {
    var drumResource: Resource
    var tonerResource: Resource
    var printerConnection: PrinterStatus
    var paperLot: PaperLot
    
    var paperDensitySupport: Set<PaperDensity>
    var paperFormatSupport: Set<PaperFormat>
    
    init(paperFormatSupport: Set<PaperFormat>, paperDencitySupport: Set<PaperDensity>) {
        
        drumResource = .yes
        tonerResource = .yes
        printerConnection = .onLine
        paperLot = .full
        
        self.paperDensitySupport = paperDencitySupport
        self.paperFormatSupport = paperFormatSupport
        
    }
    
    func toPrint(paperDensity: PaperDensity, paperFormat: PaperFormat) -> (Bool, PrintError?) {
        guard drumResource == .yes else {
            return (false, .DrumExhausted)
        }
        guard tonerResource == .yes else {
            return (false, .TonerOut)
        }
        guard printerConnection == .onLine else {
            return (false, .PrinterIsNotConnected)
        }
        guard paperLot == .full else {
            return (false, .PaperOut)
        }
        guard paperDensitySupport.contains(paperDensity) else {
            return (false, .UnacceptablePaperWeight)
       }
        guard paperFormatSupport.contains(paperFormat) else {
            return (false, .UnsupportedPaperSize)
        }

        return (true, nil)
    }
}

