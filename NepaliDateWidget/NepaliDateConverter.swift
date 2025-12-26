//
//  NepaliDateConverter.swift
//  Nepali Date
//
//  Created by Bibek Bhujel on 25/12/2025.
//

import Foundation

//
//  NepaliDateConverter.swift
//  Nepali Date Converter
//
//  Swift implementation of AD to BS date conversion
//

class NepaliDateConverter {

    // MARK: - Calendar Data (2000-2090 BS - Full Range)

    private let calendarData: [[Int]] = [
        [2000, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2001, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2002, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2003, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2004, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2005, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2006, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2007, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2008, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
        [2009, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2010, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2011, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2012, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
        [2013, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2014, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2015, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2016, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
        [2017, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2018, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2019, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2020, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2021, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2022, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
        [2023, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2024, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2025, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2026, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2027, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2028, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2029, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
        [2030, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2031, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2032, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2033, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2034, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2035, 30, 32, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
        [2036, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2037, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2038, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2039, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
        [2040, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2041, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2042, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2043, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
        [2044, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2045, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2046, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2047, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2048, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2049, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
        [2050, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2051, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2052, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2053, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
        [2054, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2055, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2056, 31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
        [2057, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2058, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2059, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2060, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2061, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2062, 30, 32, 31, 32, 31, 31, 29, 30, 29, 30, 29, 31],
        [2063, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2064, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2065, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2066, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
        [2067, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2068, 31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2069, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2070, 31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
        [2071, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2072, 31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
        [2073, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
        [2074, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2075, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2076, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
        [2077, 31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2078, 31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2079, 31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
        [2080, 31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
        [2081, 31, 31, 32, 32, 31, 30, 30, 30, 29, 30, 29, 31],
        [2082, 31, 32, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
        [2083, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
        [2084, 31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
        [2085, 31, 32, 31, 32, 30, 31, 30, 30, 29, 30, 30, 30],
        [2086, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
        [2087, 31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30],
        [2088, 30, 31, 32, 32, 30, 31, 30, 30, 29, 30, 30, 30],
        [2089, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
        [2090, 30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30]
    ]

    // MARK: - Month Names

    private let bsMonthInNepali = [
        1: "वैशाख", 2: "जेठ", 3: "असार", 4: "साउन",
        5: "भदौ", 6: "असोज", 7: "कार्तिक", 8: "मंसिर",
        9: "पुष", 10: "माघ", 11: "फागुन", 12: "चैत"
    ]

    private let dayOfWeekInNepali = [
        1: "आइतवार", 2: "सोमवार", 3: "मङ्गलवार", 4: "बुधवार",
        5: "बिहिवार", 6: "शुक्रवार", 7: "शनिवार"
    ]

    private let numbersInNepali = [
        "0": "०", "1": "१", "2": "२", "3": "३", "4": "४",
        "5": "५", "6": "६", "7": "७", "8": "८", "9": "९"
    ]


     private var currentNepaliDate: NepaliDate {
        let now = Date()
        // Get current date components
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        // Convert current date to Nepali
        var nepaliDateResult: NepaliDate = NepaliDate(
            year: components.year!,
            month: components.month!,
            day: components.day!,
            dayOfWeek: components.weekday ?? 5
        )
        do {
                nepaliDateResult = try self.adToBs(
                year: components.year!,
                month: components.month!,
                day: components.day!
            )
        }catch {
            print(error.localizedDescription)
        }

        return nepaliDateResult
    }

    var currentNepaliYear: Int {
        currentNepaliDate.year
    }

    var currentNepaliMonth: String {
        self.getBSMonthInNepali(currentNepaliDate.month) ?? ""
    }

    var currentNepaliDay: Int {
        currentNepaliDate.day
    }

    var currentWeekDay: String {
        self.getDayOfWeekInNepali(currentNepaliDate.dayOfWeek) ?? ""
    }


    // MARK: - Public Methods

    /// Convert AD (English) date to BS (Nepali) date
    func adToBs(year: Int, month: Int, day: Int) throws -> NepaliDate {
        try validateEnglishDate(year: year, month: month, day: day)

        // Calculate total English days from reference
        let totalAdDays = calculateTotalEnglishDays(year: year, month: month, day: day)

        // Reference Nepali date: 2000-09-17 corresponds to English reference
        let initialNepaliYear = 2000
        let initialNepaliMonth = 9
        let initialNepaliDay = 17
        var dayOfWeek = 6 // Saturday

        var nepaliYear = initialNepaliYear
        var nepaliMonth = initialNepaliMonth
        var nepaliDay = initialNepaliDay

        var i = 0 // Year index in calendar data
        var j = initialNepaliMonth // Month counter

        var remainingDays = totalAdDays

        // Iterate through each day
        while remainingDays != 0 {
            // Check if we're within bounds
            guard i < calendarData.count else {
                throw DateConverterError.outOfRange("Date exceeds available calendar data")
            }

            guard j >= 1 && j <= 12 else {
                throw DateConverterError.invalidMonth("Invalid month during conversion")
            }

            let lastDayOfMonth = calendarData[i][j]

            nepaliDay += 1
            dayOfWeek += 1

            // Handle day overflow
            if nepaliDay > lastDayOfMonth {
                nepaliMonth += 1
                nepaliDay = 1
                j += 1
            }

            // Handle week overflow
            if dayOfWeek > 7 {
                dayOfWeek = 1
            }

            // Handle month overflow
            if nepaliMonth > 12 {
                nepaliYear += 1
                nepaliMonth = 1
            }

            // Handle calendar data array overflow
            if j > 12 {
                j = 1
                i += 1
            }

            remainingDays -= 1
        }

        return NepaliDate(
            year: nepaliYear,
            month: nepaliMonth,
            day: nepaliDay,
            dayOfWeek: dayOfWeek
        )
    }

    // MARK: - Formatting Methods

    func formatNepaliNumber(_ value: Int) -> String {
        let stringValue = String(value)
        var result = ""
        for char in stringValue {
            result += numbersInNepali[String(char)] ?? String(char)
        }
        return result
    }

    func getBSMonthInNepali(_ month: Int) -> String? {
        return bsMonthInNepali[month]
    }

    func getDayOfWeekInNepali(_ day: Int) -> String? {
        return dayOfWeekInNepali[day]
    }

    // MARK: - Private Helper Methods

    private func isLeapYear(year: Int) -> Bool {
        if year % 100 == 0 {
            return year % 400 == 0
        } else {
            return year % 4 == 0
        }
    }

    private func validateEnglishDate(year: Int, month: Int, day: Int) throws {
        guard year >= 1944 && year <= 2033 else {
            throw DateConverterError.outOfRange("Supported only between 1944-2033")
        }

        guard month >= 1 && month <= 12 else {
            throw DateConverterError.invalidMonth("Month value must be between 1-12")
        }

        guard day >= 1 && day <= 31 else {
            throw DateConverterError.invalidDay("Day value must be between 1-31")
        }
    }

    private func calculateTotalEnglishDays(year: Int, month: Int, day: Int) -> Int {
        var totalAdDays = 0
        let initialEnglishYear = 1944
        let normalMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        let leapMonths = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        // Add days for complete years
        for i in 0..<(year - initialEnglishYear) {
            let currentYear = initialEnglishYear + i
            if isLeapYear(year: currentYear) {
                totalAdDays += 366
            } else {
                totalAdDays += 365
            }
        }

        // Add days for complete months in the target year
        let monthDays = isLeapYear(year: year) ? leapMonths : normalMonths
        for i in 0..<(month - 1) {
            totalAdDays += monthDays[i]
        }

        // Add remaining days
        totalAdDays += day

        return totalAdDays
    }
}

// MARK: - Data Models

struct NepaliDate {
    let year: Int
    let month: Int
    let day: Int
    let dayOfWeek: Int

    func formatted(converter: NepaliDateConverter) -> String {
        let yearStr = converter.formatNepaliNumber(year)
        let monthName = converter.getBSMonthInNepali(month) ?? ""
        let dayStr = converter.formatNepaliNumber(day)
        return "\(yearStr) \(monthName) \(dayStr)"
    }

    func formattedWithDay(converter: NepaliDateConverter) -> String {
        let dayName = converter.getDayOfWeekInNepali(dayOfWeek) ?? ""
        return "\(formatted(converter: converter)), \(dayName)"
    }

    func toBS() -> String {
        return "\(year)-\(String(format: "%02d", month))-\(String(format: "%02d", day))"
    }
}

// MARK: - Error Handling

enum DateConverterError: LocalizedError {
    case outOfRange(String)
    case invalidMonth(String)
    case invalidDay(String)

    var errorDescription: String? {
        switch self {
        case .outOfRange(let message),
             .invalidMonth(let message),
             .invalidDay(let message):
            return message
        }
    }
}


