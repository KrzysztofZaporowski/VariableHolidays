//
//  DateExtension.swift
//  VariableHolidays
//
//  Created by Krzysztof Zaporowski on 28/04/2025.
//

import Foundation
extension Date {
    
    static func fromYMD(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        return calendar.date(from: components)!
    }
    
    init?(year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        var components = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        if let newDate = calendar.date(from: components) {
            self = newDate
        } else
        {
            return nil
        }
    }
    
    mutating func addDays(numberOfDays: Int) {
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        dateComponent.hour = 24 * numberOfDays
        let newDate = calendar.date(byAdding: dateComponent, to: self) ?? Date()
        self = newDate
    }
    
    func dayNumberOfWeek() -> Int {
        return Calendar.current.dateComponents([.weekday], from: self).weekday!
    }
    
    var ymd : DateComponents {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: self)
            return components
        }
    }
    /// Porównuje dwie daty z dokładnością do roku, miesiąca i dnia
     func isSameDate(date: Date) -> Bool {
         let me = self.ymd
         let other = date.ymd
         if me == other {
             return true
         }
         return false
     }

     func daysBetween(date: Date) -> Int {
         let calendar = Calendar.current
         let dateMe = calendar.startOfDay(for: self)
         let dateOther = calendar.startOfDay(for: date)
         let numberOfDays = calendar.dateComponents([.day], from: dateMe, to: dateOther)
         return numberOfDays.day!
     }

     func isWeekend() -> Bool {
         switch self.dayNumberOfWeek() {
         case 1,7: //1 to niedziela, 7 to sobota
             return true
         default:
             return false
         }
     }
    
    static func easterDate(year: Int)->Date{
        let a = year % 19
        let b = year / 100
        let c = year % 100
        let d = b / 4
        let e = b % 4
        let f = (b + 8) / 25
        let g = (b - f + 1) / 3
        let h = (19 * a + b - d - g + 15) % 30
        let i = c / 4
        let k = c % 4
        let l = (32 + 2 * e + 2 * i - h - k) % 7
        let m = (a + 11 * h + 22 * l) / 451
        let month = (h + l - 7 * m + 114) / 31
        let day = ((h + l - 7 * m + 114) % 31) + 1
        
        return Date.fromYMD(year: year, month: month, day: day)
    }
    
    func countWorkdays(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar.current
        guard startDate <= endDate else { return 0 }
        
        guard let year = calendar.dateComponents([.year], from: startDate).year else { return 0 }
        
        // Stałe święta (na podstawie roku startDate)
        let fixedHolidays: [Date] = [
            Date.fromYMD(year: year, month: 1, day: 1), // nowy rok
            Date.fromYMD(year: year, month: 1, day: 6), // trzech król
            Date.fromYMD(year: year, month: 5, day: 1), // swieto pracy
            Date.fromYMD(year: year, month: 5, day: 3), // konstytucja 3 maja
            Date.fromYMD(year: year, month: 8, day: 15), // zielone swiatki
            Date.fromYMD(year: year, month: 11, day: 1), // wszystkich swietych
            Date.fromYMD(year: year, month: 11, day: 11), // swieto niepodleglosci
            Date.fromYMD(year: year, month: 12, day: 25), // pierwszy dzien bozego narodzenia
            Date.fromYMD(year: year, month: 12, day: 26) // drugi dzien bozego narodzenia
        ]
        
        let easter = Date.easterDate(year: year)
        let easterMonday = calendar.date(byAdding: .day, value: 1, to: easter)! // poniedzialek wielkanocny
        let corpusChristi = calendar.date(byAdding: .day, value: 60, to: easter)! // boze cialo
        let movingHolidays = [easterMonday, corpusChristi]
        
        var currentDate = startDate
        var workdays = 0
        
        while currentDate < endDate {
            if !currentDate.isWeekend() &&
                !fixedHolidays.contains(where: { $0.isSameDate(date: currentDate) }) &&
                !movingHolidays.contains(where: { $0.isSameDate(date: currentDate) }) {
                workdays += 1
            }
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return workdays
    }
}
