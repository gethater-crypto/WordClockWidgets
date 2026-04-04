//
//  NumberToWords.swift
//  WordClockWidgets
//
//  Created by GitHub Copilot on 2026-04-04.
//

import Foundation

class NumberToWords {

    private static let units = ["", "один", "два", "три", "четыре", "пять", "шесть", "семь", "восемь", "девять"]
    private static let teens = ["десять", "одиннадцать", "двенадцать", "тринадцать", "четырнадцать", "пятнадцать", "шестнадцать", "семнадцать", "восемнадцать", "девятнадцать"]
    private static let tens = ["", "", "двадцать", "тридцать", "сорок", "пятьдесят", "шестьдесят", "семьдесят", "восемьдесят", "девяносто"]
    private static let hours = ["двенадцать", "один", "два", "три", "четыре", "пять", "шесть", "семь", "восемь", "девять", "десять", "одиннадцать"]

    static func convertHour(_ hour: Int) -> String {
        var h = hour
        if h == 0 || h == 12 { return "двенадцать" }
        if h > 12 { h -= 12 }
        if h == 1 { return "час" }
        return hours[h]
    }

    static func convertHour24(_ hour: Int) -> String {
        if hour == 0 { return "ноль" }
        if hour < 0 { return "" }
        if hour < 10 { return units[hour] }
        if hour < 20 { return teens[hour - 10] }
        if hour < 24 { return convert(hour) }
        return ""
    }

    static func convertMinute(_ minute: Int, addZero: Bool = false, use12Hour: Bool = false) -> String {
        if minute == 0 {
            return use12Hour ? "ровно" : "ноль-ноль"
        }
        if addZero && minute >= 1 && minute <= 9 {
            return "ноль " + convert(minute)
        }
        if minute < 60 {
            return convert(minute)
        }
        return ""
    }

    private static func convert(_ number: Int) -> String {
        if number < 10 {
            return units[number]
        } else if number < 20 {
            return teens[number - 10]
        } else {
            let ten = number / 10
            let unit = number % 10
            return tens[ten] + (unit > 0 ? " " + units[unit] : "")
        }
    }

    static func getDayNight(_ hour: Int) -> String {
        if hour >= 4 && hour < 12 { return "утра" }
        if hour >= 12 && hour < 17 { return "дня" }
        if hour >= 17 && hour < 23 { return "вечера" }
        return "ночи"
    }

    private static let daysOfWeek = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"]

    static func getDayOfWeek(_ dayOfWeek: Int) -> String {
        if dayOfWeek < 0 || dayOfWeek >= daysOfWeek.count {
            return ""
        }
        return daysOfWeek[dayOfWeek]
    }

    private static let months = ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]

    static func convertDate(_ day: Int, _ month: Int, _ year: Int) -> String {
        if day < 1 || day > 31 || month < 1 || month > 12 {
            return ""
        }
        let dayStr = convertOrdinal(day)
        let monthStr = months[month - 1]
        return dayStr + " " + monthStr
    }

    private static func convertOrdinal(_ number: Int) -> String {
        switch number {
        case 1: return "первое"
        case 2: return "второе"
        case 3: return "третье"
        case 4: return "четвёртое"
        case 5: return "пятое"
        case 6: return "шестое"
        case 7: return "седьмое"
        case 8: return "восьмое"
        case 9: return "девятое"
        case 10: return "десятое"
        case 11: return "одиннадцатое"
        case 12: return "двенадцатое"
        case 13: return "тринадцатое"
        case 14: return "четырнадцатое"
        case 15: return "пятнадцатое"
        case 16: return "шестнадцатое"
        case 17: return "семнадцатое"
        case 18: return "восемнадцатое"
        case 19: return "девятнадцатое"
        case 20: return "двадцатое"
        case 30: return "тридцатое"
        default:
            let ten = number / 10
            let unit = number % 10
            let tenStr = tens[ten]
            var unitStr = ""
            switch unit {
            case 1: unitStr = "первое"
            case 2: unitStr = "второе"
            case 3: unitStr = "третье"
            case 4: unitStr = "четвёртое"
            case 5: unitStr = "пятое"
            case 6: unitStr = "шестое"
            case 7: unitStr = "седьмое"
            case 8: unitStr = "восьмое"
            case 9: unitStr = "девятое"
            default: break
            }
            return tenStr + " " + unitStr
        }
    }
}