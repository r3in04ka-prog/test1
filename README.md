# WALLET — iOS Multibanking UI Prototype

Premium Russian-language SwiftUI multibanking **interactive mockup**. This is a demo: no bank connections, real money transfers, or live balances.

## First milestone
Build a runnable native iOS 17+ app with four screens: Dashboard, Cards, Transfer and Transaction Details. Use fake data and an adaptive bank accent theme.

## Key differentiator: Adaptive Bank Theme
Selecting **All Banks / Сбер / Альфа / Т-Банк / Ozon Банк** changes app accents smoothly while the dark background and layout stay stable. Selecting a bank also filters its accounts and transactions. The transfer's source account is managed separately from the global bank filter.

## Design
Quiet premium dark fintech, **not** sci-fi. Black and graphite backgrounds, lime/pink default accents, restrained rounded surfaces, system SF typography and SF Symbols. See [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md).

## Stack
Swift 6, SwiftUI, iOS 17+, NavigationStack, Swift Charts, MVVM, XCTest. No backend in the first milestone.

## Development with Codex
Read [AGENTS.md](AGENTS.md) and [PRODUCT_SPEC.md](PRODUCT_SPEC.md), then implement tasks in [ROADMAP.md](ROADMAP.md), starting at milestone 1. Create a real compilable Xcode project rather than static images.

## Safety
All financial data is fabricated. Do not capture bank passwords, store card PAN/CVV, or imply the mock buttons send real funds. Real bank/СБП integration requires separate official access, agreements, compliance and a secure backend.
