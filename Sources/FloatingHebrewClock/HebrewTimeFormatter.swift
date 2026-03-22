import Foundation

enum HebrewTimeFormatter {
    private static let hourWords: [Int: String] = [
        1: "אַחַת",
        2: "שְׁתַּיִם",
        3: "שָׁלוֹשׁ",
        4: "אַרְבַּע",
        5: "חָמֵשׁ",
        6: "שֵׁשׁ",
        7: "שֶׁבַע",
        8: "שְׁמוֹנֶה",
        9: "תֵּשַׁע",
        10: "עֶשֶׂר",
        11: "אַחַת עֶשְׂרֵה",
        12: "שְׁתֵּים עֶשְׂרֵה"
    ]

    private static let minuteWordsExact: [Int: String] = [
        0: "אֶפֶס",
        1: "אַחַת",
        2: "שְׁתַּיִם",
        3: "שָׁלוֹשׁ",
        4: "אַרְבַּע",
        5: "חָמֵשׁ",
        6: "שֵׁשׁ",
        7: "שֶׁבַע",
        8: "שְׁמוֹנֶה",
        9: "תֵּשַׁע",
        10: "עֶשֶׂר",
        11: "אַחַת עֶשְׂרֵה",
        12: "שְׁתֵּים עֶשְׂרֵה",
        13: "שָׁלוֹשׁ עֶשְׂרֵה",
        14: "אַרְבַּע עֶשְׂרֵה",
        15: "חֲמֵשׁ עֶשְׂרֵה",
        16: "שֵׁשׁ עֶשְׂרֵה",
        17: "שְׁבַע עֶשְׂרֵה",
        18: "שְׁמוֹנֶה עֶשְׂרֵה",
        19: "תְּשַׁע עֶשְׂרֵה",
        20: "עֶשְׂרִים",
        30: "שְׁלוֹשִׁים",
        40: "אַרְבָּעִים",
        50: "חֲמִשִּׁים"
    ]

    static func words(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let hour24 = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        if hour24 == 0 && minute == 0 {
            return "חֲצוֹת"
        }

        let hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12
        let hour = hourWords[hour12] ?? "-"
        let period = dayPart(for: hour24)

        if minute == 0 {
            return fullHourPhrase(hour: hour, period: period)
        }

        if minute == 15 {
            return "\(hour) וָרֶבַע \(period)"
        }

        if minute == 30 {
            return "\(hour) וָחֵצִי \(period)"
        }

        let connector = minute % 10 == 0 ? "" : "ו"
        return "\(hour) \(connector)\(minuteInWords(minute)) \(period)"
    }

    static func digital(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "he_IL")
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }


    private static func fullHourPhrase(hour: String, period: String) -> String {
        "\(hour) \(period)"
    }

    private static func dayPart(for hour24: Int) -> String {
        switch hour24 {
        case 5...11:
            return "בַּבֹּקֶר"
        case 12...16:
            return "בַּצָּהֳרַיִים"
        case 17...23:
            return "בָּעֶרֶב"
        default:
            return "בַּלַּיְלָה"
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
