import XCTest
@testable import WALLET

final class WALLETTests: XCTestCase {
    @MainActor func testCombinedBalanceAndFiltering() { let state = AppState(); XCTAssertEqual(state.totalBalance, 46800); state.select(.sber); XCTAssertEqual(state.totalBalance, 18500); XCTAssertEqual(state.visibleTransactions.count, 1) }
    func testThemeMapping() { XCTAssertEqual(BankTheme.forBank(.sber).accent, Color(hex: "21A038")); XCTAssertEqual(BankTheme.forBank(.alfa).accent, Color(hex: "F36BA8")); XCTAssertEqual(BankTheme.forBank(.tbank).accent, Color(hex: "FFD428")); XCTAssertEqual(BankTheme.forBank(.ozon).accent, Color(hex: "005BFF")) }
}
