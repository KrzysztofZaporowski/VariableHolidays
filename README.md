# First SwiftUI application
## Short preview about swift
* What does `...` means?
  It's ClosedRange operator for example:
  ``` swift
  let range = 1...5 // it's 1 to 5 range (1, 2, 3, 4, 5)
  DatePicker("Start", selection: $dateStart, in: ...dateEnd) // it's mean that start date have to be before end date
  ```
* What `guard` variable or constant means?
  You can check if the condition is met or if the variable is of a given type:
  ``` swift
  guard endDate >= startDate else {return 0} // if endDate is smaller than startDate it will return 0
  guard let year = calendar.dateComponent([.year], from: startDate).year else {return 0}
  // if year is not year type it will return 0
  ```
* func vs static func
  The main difference between `func` and `static func` is that static delong to the type (like `Date`) when normal func delong to instance. Example below:
  ``` swift
  static func addYear(year: Int, month: Int, day: Int)->Date {
      let newYear = year + 1
      return Date.fromYMD(year: newYear, month: month, day: day)
  }
  let newDate = Date.addYear(year: 2025, month: 4, day: 29)
  //////////////////////////////////////////////////////////////////
  func addOneYear() -> Date? {
        return Calendar.current.date(byAdding: .year, value: 1, to: self)
    }
  let today = Date()
  let newDate = today.add()
  ```
* VStact vs HStact
  If you your items to be one above the other then use `VStack` but if you want to have in line then use `HStack`
