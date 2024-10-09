//
//  Date+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/24/24.
//

import Foundation
import SwiftUICalendar

public extension Date {
    // 만약 input이 자정이라면, 전날 23:59:59으로 return
    func adjustDateIfMidNight() -> Date {
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: self)
        
        if self == midnight {
            return calendar.date(byAdding: .second, value: -1, to: midnight) ?? self
        } else {
            return self
        }
    }
    
    func toHHmm() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func toMM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    func toDD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    // date를 YMD로 변환
    func toYMD() -> YearMonthDay {
        let calendar = Calendar.current
        
        return YearMonthDay(
            year: calendar.component(.year, from: self),
            month: calendar.component(.month, from: self),
            day: calendar.component(.day, from: self)
        )
    }
    
    /// date를 YMD 형식의 string으로 변환
    func toYMDString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    /// date를 YMDEHM 형식의 string으로 변환 ex) "2022.06.28(화) 11:00"
    func toYMDEHM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd(E) HH:mm"
        return dateFormatter.string(from: self)
    }
    
    // date를 YM로 변환
    func toYM() -> YearMonth {
        let calendar = Calendar.current
        
        return YearMonth(
            year: calendar.component(.year, from: self),
            month: calendar.component(.month, from: self)
        )
    }
    
    // month의 첫번째 날 00시 00분
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    func endOfMonth() -> Date {
        let calendar = Calendar.current
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: self.startOfMonth())!
        return calendar.date(byAdding: .second, value: -1, to: nextMonth)!
    }
    
    func addingMonth(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: value, to: self)!
        
    }
    
    func isSunday() -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 1 // 일요일
    }
    
    
    /// Date타입을  ISO8601 포맷으로 변환합니다
    func dateToISO8601() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let ISO8601String = formatter.string(from: self)
        
        return ISO8601String
    }
    
    /// ISO8601 포맷을 Date 타입으로 변환합니다.
    static func ISO8601toDate(_ string: String) -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime ]
        guard let date = formatter.date(from: string) else {
            fatalError("Incorrect date format")            
        }
        return date
    }
}
