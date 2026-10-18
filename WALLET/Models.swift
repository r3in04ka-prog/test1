import Foundation
import SwiftUI

enum BankID: String, CaseIterable, Identifiable, Codable {
    case all, sber, alfa, tbank, ozon
    var id: String { rawValue }
    var title: String { switch self { case .all: "Все банки"; case .sber: "Сбер"; case .alfa: "Альфа"; case .tbank: "Т-Банк"; case .ozon: "Ozon Банк" } }
}

struct BankTheme: Equatable {
    let accent: Color
    let secondary: Color
    let symbol: String
    static func forBank(_ bank: BankID) -> BankTheme {
        switch bank { case .all: .init(accent: Color(hex: "D7FF62"), secondary: Color(hex: "F3A5DF"), symbol: "circle.grid.2x2.fill")
        case .sber: .init(accent: Color(hex: "21A038"), secondary: Color(hex: "B8F28B"), symbol: "leaf.fill")
        case .alfa: .init(accent: Color(hex: "F36BA8"), secondary: Color(hex: "FFB4D3"), symbol: "a.circle.fill")
        case .tbank: .init(accent: Color(hex: "FFD428"), secondary: Color(hex: "FFE99A"), symbol: "t.circle.fill")
        case .ozon: .init(accent: Color(hex: "005BFF"), secondary: Color(hex: "8AB8FF"), symbol: "bag.fill") }
    }
}

struct BankAccount: Identifiable, Equatable { let id, bankName, maskedCard: String; let bank: BankID; var balance: Decimal }
struct Transaction: Identifiable, Equatable { let id, merchant, category, maskedCard: String; let bank: BankID, date: Date, amount: Decimal }

struct MockRepository {
    let accounts: [BankAccount] = [
        .init(id: "sber-main", bankName: "Сбер", maskedCard: "1234", bank: .sber, balance: 18500),
        .init(id: "alfa-main", bankName: "Альфа-Банк", maskedCard: "9012", bank: .alfa, balance: 12700),
        .init(id: "tbank-main", bankName: "Т-Банк", maskedCard: "5678", bank: .tbank, balance: 8400),
        .init(id: "ozon-main", bankName: "Ozon Банк", maskedCard: "3456", bank: .ozon, balance: 7200)
    ]
    let transactions: [Transaction] = [
        .init(id: "t1", merchant: "Пятёрочка", category: "Продукты", maskedCard: "1234", bank: .sber, date: .now.addingTimeInterval(-86400), amount: -1240),
        .init(id: "t2", merchant: "Зарплата", category: "Доход", maskedCard: "9012", bank: .alfa, date: .now.addingTimeInterval(-172800), amount: 95000),
        .init(id: "t3", merchant: "Яндекс Такси", category: "Транспорт", maskedCard: "5678", bank: .tbank, date: .now.addingTimeInterval(-259200), amount: -420),
        .init(id: "t4", merchant: "App Store", category: "Покупки", maskedCard: "3456", bank: .ozon, date: .now.addingTimeInterval(-345600), amount: -520)
    ]
}

@MainActor final class AppState: ObservableObject {
    @Published var selectedBank: BankID = .all
    @Published var selectedTab = 0
    let repository = MockRepository()
    var theme: BankTheme { .forBank(selectedBank) }
    var visibleAccounts: [BankAccount] { selectedBank == .all ? repository.accounts : repository.accounts.filter { $0.bank == selectedBank } }
    var visibleTransactions: [Transaction] { selectedBank == .all ? repository.transactions : repository.transactions.filter { $0.bank == selectedBank } }
    var totalBalance: Decimal { visibleAccounts.reduce(0) { $0 + $1.balance } }
    func select(_ bank: BankID) { withAnimation(.easeInOut(duration: 0.35)) { selectedBank = bank } }
}

extension Color { init(hex: String) { let v = UInt64(hex, radix: 16) ?? 0; self.init(.sRGB, red: Double((v >> 16) & 255) / 255, green: Double((v >> 8) & 255) / 255, blue: Double(v & 255) / 255, opacity: 1) } }
extension Decimal { var rubles: String { let n = NSDecimalNumber(decimal: self).doubleValue; return n.formatted(.number.precision(.fractionLength(0))) + " ₽" } }
