//
//  ContentView.swift
//  VariableHolidays
//
//  Created by Krzysztof Zaporowski on 28/04/2025.
//

import SwiftUI

struct ContentView: View {
    let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - HH:mm"
        return formatter
    }()
    @State var dateStart = Date()
    @State var dateEnd = Date()
    
    var body: some View {
        VStack {
            Text("Date calculator").font(.title)
            Spacer()
            Text("Today is: \(Date(), formatter: dataFormatter)").foregroundStyle(.secondary).font(.title2)
            Spacer()
            DatePicker("Enter first date", selection:
                        $dateStart, in: ...dateEnd, displayedComponents: .date)
                .datePickerStyle(.automatic)
            DatePicker("Enter second date",selection: $dateEnd, in:dateStart...,
                       displayedComponents: .date)
                .datePickerStyle(.automatic)
            Spacer()
            Text("Days between: \(dateStart.daysBetween(date: dateEnd))")
            let workdays = Date().countWorkdays(from: dateStart, to: dateEnd)
            Text("Workdays between: \(workdays)")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
