import Foundation

enum HebrewTimeFormatter {
    private static let hourWords: [Int: String] = [
        1: "אחת",
        2: "שתיים",
        3: "שלוש",
        4: "ארבע",
        5: "חמש",
        6: "שש",
        7: "שבע",
        8: "שמונה",
        9: "תשע",
        10: "עשר",
        11: "אחת עשרה",
        12: "שתים עשרה"
    ]

    private static let minuteWordsExact: [Int: String] = [
        0: "אפס",
        1: "אחת",
        2: "שתיים",
        3: "שלוש",
        4: "ארבע",
        5: "חמש",
        6: "שש",
        7: "שבע",
        8: "שמונה",
        9: "תשע",
        10: "עשר",
        11: "אחת עשרה",
        12: "שתים עשרה",
        13: "שלוש עשרה",
        14: "ארבע עשרה",
        15: "חמש עשרה",
        16: "שש עשרה",
        17: "שבע עשרה",
        18: "שמונה עשרה",
        19: "תשע עשרה",
        20: "עשרים",
        30: "שלושים",
        40: "ארבעים",
        50: "חמישים"
    ]

    static func words(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let hour24 = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        if hour24 == 0 && minute == 0 {
            return "חצות"
        }

        let hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12
        let hour = hourWords[hour12] ?? "-"
        let period = dayPart(for: hour24)

        if minute == 0 {
            return "\(hour) \(period)"
        }

        return "\(hour) ו\(minuteInWords(minute)) \(period)"
    }

    static func digital(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "he_IL")
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }

    private static func dayPart(for hour24: Int) -> String {
        switch hour24 {
        case 5...11:
            return "בבוקר"
        case 12...16:
            return "בצהריים"
        case 17...23:
            return "בערב"
        default:
            return "בלילה"
        }
    }

    private static func minuteInWords(_ minute: Int) -> String {
        if let exact = minuteWordsExact[minute] {
            return exact
        }

        let tens = (minute / 10) * 10
        let ones = minute % 10

        let tensWord = minuteWordsExact[tens] ?? ""
        let onesWord = minuteWordsExact[ones] ?? ""

        if ones == 0 {
            return tensWord
        }

        return "\(tensWord) ו\(onesWord)"
    }
}
